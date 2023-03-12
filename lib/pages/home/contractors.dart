import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../components/drawer.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../controllers/contractors.dart';
import '../../models/label_function.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';
import '../Details/customer_detail.dart';


class ContractorsPage extends StatefulWidget {
  const ContractorsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateContractorsPage();
}

class _StateContractorsPage extends State<ContractorsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? _searchQuery;
  bool _isSearching = false;
  bool _loadingOverlay = false;

  final _scrollController = ScrollController();
  final ContractorsController _contractorsController = Get.find<ContractorsController>();

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _contractorsController.filterController = _searchQuery!;

    listContractors();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          print('At the top');
          listContractors(paginated: false);
        } else {
          if (!_contractorsController.allLoaded.value) {
            listContractors(paginated: true);
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

  void listContractors({bool paginated = false}) async {
    try {
      setState(() {_loadingOverlay = true;});
      await _contractorsController.listContractors (paginated: paginated);
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
      csDialog(context: context, text: "CONTRACTORS_ERROR_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      setState(() {_loadingOverlay = false;});
      _contractorsController.loading.value = false;
      _contractorsController.scrollLoading.value = false;
      _contractorsController.update();
    }
  }

  void _startSearch() {
    listContractors();
  }

  void _stopSearching() {
    _searchQuery!.clear();
    listContractors();
  }

  Widget _listInsureds() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: true,
        itemExtent: 55,
        itemCount: _contractorsController.contractors.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(Consts.C_AVATAR),
              child: Text(_contractorsController.contractors[index].name[0].toUpperCase(),
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_WHITECOLOR),
                ),
              ),
            ),
            title: Text(_contractorsController.contractors[index].name,
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(Consts.C_PRIMARYCOLOR),
              ),
            ),
            subtitle: Text(_contractorsController.contractors[index].identification,
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(Consts.C_STATUS3),
              ),
            ),
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: CustomerDetailPage(customer: _contractorsController.contractors[index], title: "contractorinfo".tr,),
                  routeSettings: const RouteSettings(name: "CustomerDetailPage")));
            },
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("contractors".tr, textAlign: TextAlign.center,
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
        body: GetBuilder<ContractorsController>(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    if (_contractorsController.contractors.isNotEmpty)
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
                            _isSearching = !_isSearching;
                          });
                          if (_isSearching) {
                            _startSearch();
                          } else {
                            _stopSearching();
                          }
                        }
                    ),
                    const SizedBox(height: 10,),
                    if (_contractorsController.contractors.isNotEmpty)
                      _listInsureds(),
                    if (_contractorsController.contractors.isEmpty && !_contractorsController.loading.value)
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