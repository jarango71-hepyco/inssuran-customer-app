import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../components/drawer.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../controllers/historical.dart';
import '../../models/label_function.dart';
import '../../models/policy.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';
import 'insured_objects.dart';


class HistoricalPage extends StatefulWidget {
  const HistoricalPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateHistoricalPage();
}

class _StateHistoricalPage extends State<HistoricalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? _searchQuery;
  bool _isSearching = false;
  bool _loadingOverlay = false;

  final _scrollController = ScrollController();
  final HistoricalsController _historicalsController = Get.find<HistoricalsController>();

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _historicalsController.filterController = _searchQuery!;

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          print('At the top');
          listHistoricals(paginated: false);
        } else {
          if (!_historicalsController.allLoaded.value) {
            listHistoricals(paginated: true);
          }
        }
      }
    });

    listHistoricals();
  }

  @override
  void dispose() {
    _searchQuery!.dispose();
    super.dispose();
  }

  void listHistoricals({bool paginated = false}) async {
    try {
      if (mounted) {
        setState(() {
          _loadingOverlay = true;
        });
      } else {
        _loadingOverlay = true;
      }
      await _historicalsController.listHistoricals(paginated: paginated);
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
      csDialog(context: context, text: "POLICIES_ERROR_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      if (mounted) {
        setState(() {
          _loadingOverlay = false;
        });
      } else {
        _loadingOverlay = false;
      }
      _historicalsController.loading.value = false;
      _historicalsController.scrollLoading.value = false;
      _historicalsController.update();
    }
  }


  void _startSearch() {
    listHistoricals();
  }

  void _stopSearching() {
    _searchQuery!.clear();
    listHistoricals();
  }

  Color? _getColorType(String type) {
    switch(type) {
      case "active": return const Color(Consts.C_PRIMARYCOLOR);
      case "closed": return const Color(Consts.C_STATUS2);
      case "draft": return const Color(Consts.C_STATUS3);
      default:
        return const Color(Consts.C_STATUS2);
    }
  }

  Widget _getIconType(String type) {
    switch(type) {
      case "personal": return const Icon(FlutterRemix.user_line, color: Color(Consts.C_PRIMARYCOLOR), size: 18,);
      case "corporate": return const Icon(FlutterRemix.briefcase_line, color: Color(Consts.C_PRIMARYCOLOR), size: 18);
      case "massive": return const Icon(FlutterRemix.group_line, color: Color(Consts.C_PRIMARYCOLOR), size: 18);
      default:
        return const Icon(FlutterRemix.user_line, color: Color(Consts.C_PRIMARYCOLOR), size: 18,);
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

  Widget _drawCard(INSSPolicy policy) {
    double radius = 6.0;
    double height = 190;
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
                color: _getColorType(policy.state),
                borderRadius: borderRadius,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 4, right: 10),
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("nopolicy".tr,
                                style: const TextStyle(
                                  fontFamily: FontRes.GILROYLIGHT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Color(Consts.C_BLACKCOLOR),
                                ),
                              ),
                              Text(policy.policy_number,
                                style: const TextStyle(
                                  fontFamily: FontRes.GILROYLIGHT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(Consts.C_PRIMARYCOLOR),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 35,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: _getIconType(policy.policy_type_name),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Text("representative".tr,
                      style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(Consts.C_BLACKCOLOR),
                      ),
                    ),
                    Text(policy.contractor_name,
                      style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(Consts.C_STATUS1),
                      ),
                    ),

                    const SizedBox(height: 5,),
                    Text("company".tr,
                      style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(Consts.C_BLACKCOLOR),
                      ),
                    ),
                    Text(policy.provider_name,
                      style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(Consts.C_STATUS1),
                      ),
                    ),

                    const SizedBox(height: 5,),
                    Text("branch".tr,
                      style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(Consts.C_BLACKCOLOR),
                      ),
                    ),
                    Text(policy.branch_name,
                      style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(Consts.C_STATUS1),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text("${policy.date_start} | ${policy.date_end}",
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
        Navigator.push(context, SlideRightRoute(page: InsuredObjectsPage(policy: policy,),
            routeSettings: const RouteSettings(name: "PolicyDetailPage")));
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("policyhistory".tr, textAlign: TextAlign.center,
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
          //actions: _buildActions(),
        ),
        drawer: buildDrawer(context),
        body: GetBuilder<HistoricalsController>(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    if (_historicalsController.policies.isNotEmpty)
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
                    if (_historicalsController.policies.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: _historicalsController.policies.length,
                          itemBuilder: (context, index) {
                            return _drawCard(_historicalsController.policies[index]);
                          },
                        ),
                      ),
                    if (_historicalsController.policies.isEmpty && !_historicalsController.loading.value)
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