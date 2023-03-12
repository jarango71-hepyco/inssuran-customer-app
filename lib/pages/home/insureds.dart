import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../controllers/insureds.dart';
import '../../models/label_function.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';
import '../Details/customer_detail.dart';


class InsuredsPage extends StatefulWidget {
  const InsuredsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateInsuredsPage();
}

class _StateInsuredsPage extends State<InsuredsPage> {

  TextEditingController? _searchQuery;
  bool _isSearching = false;
  bool _loadingOverlay = false;

  final _scrollController = ScrollController();
  final InsuredsController _ensuredsController = Get.find<InsuredsController>();

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _ensuredsController.filterController = _searchQuery!;

    listInsureds();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          print('At the top');
          listInsureds(paginated: false);
        } else {
          if (!_ensuredsController.allLoaded.value) {
            listInsureds(paginated: true);
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

  void listInsureds({bool paginated = false}) async {
    try {
      setState(() {_loadingOverlay = true;});
      _ensuredsController.loading.value = true;
      await _ensuredsController.listInsureds (paginated: paginated);
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
      csDialog(context: context, text: "INSUREDS_ERROR_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      setState(() {_loadingOverlay = false;});
      _ensuredsController.loading.value = false;
      _ensuredsController.scrollLoading.value = false;
      _ensuredsController.update();
    }
  }

  void _startSearch() {
    listInsureds();
  }

  void _stopSearching() {
    _searchQuery!.clear();
    listInsureds();
  }

  Widget _listInsureds() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: true,
        itemExtent: 55,
        itemCount: _ensuredsController.insureds.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(Consts.C_AVATAR),
              child: Text(_ensuredsController.insureds[index].name[0].toUpperCase(),
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_WHITECOLOR),
                ),
              ),
            ),
            title: Text(_ensuredsController.insureds[index].name,
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(Consts.C_PRIMARYCOLOR),
              ),
            ),
            subtitle: Text(_ensuredsController.insureds[index].identification,
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(Consts.C_STATUS3),
              ),
            ),
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: CustomerDetailPage(customer: _ensuredsController.insureds[index], title: "affiliateinfo".tr,),
                  routeSettings: const RouteSettings(name: "CustomerDetailPage")));
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return csLoadingOverlay(
      loading: _loadingOverlay,
      offset: 150,
      child: GetBuilder<InsuredsController>(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10,),
                if (_ensuredsController.insureds.isNotEmpty)
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
                if (_ensuredsController.insureds.isNotEmpty)
                  _listInsureds(),
                if (_ensuredsController.insureds.isEmpty && !_ensuredsController.loading.value)
                  Center(
                    child: csEmptyList("noitems".tr),
                  ),
              ],
            ),
          );
        }
      ),
    );
  }
}

