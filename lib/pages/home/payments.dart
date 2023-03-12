import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../components/drawer.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../controllers/payments.dart';
import '../../models/label_function.dart';
import '../../models/payments.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';
import '../Details/payment_details.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatePaymentsPage();
}

class _StatePaymentsPage extends State<PaymentsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? _searchQuery;
  bool _isSearching = false;
  bool _loadingOverlay = false;

  final _scrollController = ScrollController();
  final PaymentsController _paymentsController = Get.find<PaymentsController>();

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _paymentsController.filterController = _searchQuery!;

    listPayments();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          print('At the top');
          listPayments(paginated: false);
        } else {
          if (!_paymentsController.allLoaded.value) {
            listPayments(paginated: true);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _searchQuery!.dispose();
    super.dispose();
  }

  void listPayments({bool paginated = false}) async {
    try {
      setState(() {_loadingOverlay = true;});
      await _paymentsController.listPayments (paginated: paginated);
    } on BadRequestException catch (e) {
      csDialog(context: context, text: e.message,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]
      );
    } on FetchDataException {
      csDialog(context: context, text: "ERROR_MSG_FETCH_DATA_EXCEPTION".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]
      );
    } on Exception {
      csDialog(context: context, text: "PAYMENTS_ERROR_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      _paymentsController.loading.value = false;
      _paymentsController.scrollLoading.value = false;
      _paymentsController.update();
      setState(() {_loadingOverlay = false;});
    }
  }


  void _startSearch() {
    listPayments();
  }

  void _stopSearching() {
    _searchQuery!.clear();
    listPayments();
  }

  Color? _getColorType(String type) {
    switch(type) {
      case "payed": return const Color(Consts.C_PRIMARYCOLOR);
      case "on_time": return const Color(Consts.C_STATUS1);
      case "near": return const Color(Consts.C_STATUS3);
      case "delayed": return const Color(Consts.C_STATUS2);
      default:
        return const Color(Consts.C_STATUS2);
    }
  }

  BorderRadius _getBorderRadius(double radius) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.zero,
      bottomRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
    );
  }

  Widget _drawCard(INSSPayment payment) {
    double radius = 6.0;
    double height = 64;
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.zero,
      bottomRight: Radius.zero,
      bottomLeft: Radius.circular(radius),
    );

    return GestureDetector(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: _getBorderRadius(10),
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: radius,
              height: height,
              decoration: BoxDecoration(
                color: _getColorType(payment.state),
                borderRadius: borderRadius,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 4, right: 10),
                height: height,
                //color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text("${payment.policy_policy_number}",
                            style: const TextStyle(
                              fontFamily: FontRes.GILROYLIGHT,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(Consts.C_PRIMARYCOLOR),
                            ),
                          ),
                        ),
                        /*Container(
                          padding: const EdgeInsets.all(5),
                          width: 35,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: _getIconType(payment.state),
                          ),
                        ),*/
                      ],
                    ),
                    Text(payment.policy_contractor,
                      style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(Consts.C_STATUS1),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(payment.payment_date,
                        style: const TextStyle(
                          fontFamily: FontRes.GILROYLIGHT,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(Consts.C_TEXTCOLOR),
                        ),
                      ),
                    ),
                  ],
                ),                ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, SlideRightRoute(page: PaymentDetailPage(payment: payment,),
            routeSettings: const RouteSettings(name: "PaymentDetailPage")));
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("wallets".tr, textAlign: TextAlign.center,
        style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          FlutterRemix.notification_2_line,
          color: Color(Consts.C_WHITECOLOR),
        ),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return csLoadingOverlay(
      loading: _loadingOverlay,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
          leading: IconButton(
            icon: const Icon(FlutterRemix.menu_line),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          title: _buildTitle(context),
          // actions: _buildActions(),
        ),
        drawer: buildDrawer(context),
        body: GetBuilder<PaymentsController>(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    if (_paymentsController.payments.isNotEmpty)
                    csSearch(
                        controller: _searchQuery,
                        label: '',
                        hintText: "search".tr,
                        height: 54,
                        width: 350,
                        searching: _isSearching,
                        onChanged: (String text) {
                          if (_isSearching) {
                            if (_searchQuery!.text.isNotEmpty) {
                              setState(() {
                                _startSearch();
                              });
                            } else {
                              setState(() {
                                _isSearching = false;
                                _stopSearching();
                              });
                            }
                          }
                        },
                        onPressed: () {
                          setState(() {
                            _isSearching = ! _isSearching;
                          });
                          if (_isSearching) {
                            _startSearch();
                          } else {
                            _stopSearching();
                          }
                        }
                    ),
                    const SizedBox(height: 10,),
                    if (_paymentsController.payments.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: _paymentsController.payments.length,
                          itemBuilder: (context, index) {
                            return _drawCard(_paymentsController.payments[index]);
                          },
                        ),
                      ),
                    if (_paymentsController.payments.isEmpty && !_paymentsController.loading.value)
                      Center(
                        child: csEmptyList("noitems".tr),
                      ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}