import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../controllers/vehicles.dart';
import '../../models/label_function.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';
import '../Details/vehicle_detail.dart';


class VehiclesPage extends StatefulWidget {
  const VehiclesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateVehiclesPage();
}

class _StateVehiclesPage extends State<VehiclesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? _searchQuery;
  bool _isSearching = false;
  bool _loadingOverlay = false;

  final _scrollController = ScrollController();
  final VehiclesController _vehiclesController = Get.find<VehiclesController>();

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _vehiclesController.filterController = _searchQuery!;

    listVehicles();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          listVehicles(paginated: false);
        } else {
          if (!_vehiclesController.allLoaded.value) {
            listVehicles(paginated: true);
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

  void listVehicles({bool paginated = false}) async {
    try {
      setState(() {_loadingOverlay = true;});
      _vehiclesController.loading.value = true;
      await _vehiclesController.listVehicles (paginated: paginated);
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
      csDialog(context: context, text: "VEHICLES_ERROR_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      setState(() {_loadingOverlay = false;});
      _vehiclesController.loading.value = false;
      _vehiclesController.scrollLoading.value = false;
      _vehiclesController.update();
    }
  }

  void _startSearch() {
    listVehicles();
  }

  void _stopSearching() {
    _searchQuery!.clear();
    listVehicles();
  }

  Widget _listVehicles() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: true,
        itemExtent: 55,
        itemCount: _vehiclesController.vehicles.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(Consts.C_AVATAR),
              child: Text(_vehiclesController.vehicles[index].brand[0].toUpperCase(),
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_WHITECOLOR),
                ),
              ),
            ),
            title: Text("${_vehiclesController.vehicles[index].brand} ${_vehiclesController.vehicles[index].model} - ${_vehiclesController.vehicles[index].year}",
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(Consts.C_PRIMARYCOLOR),
              ),
            ),
            subtitle: Text("${_vehiclesController.vehicles[index].plate} | ${_vehiclesController.vehicles[index].owner.name}",
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(Consts.C_STATUS3),
              ),
            ),
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: VehicleDetailPage(vehicle: _vehiclesController.vehicles[index],),
                  routeSettings: const RouteSettings(name: "VehicleDetailPage")));
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
      child: GetBuilder<VehiclesController>(
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  if (_vehiclesController.vehicles.isNotEmpty)
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
                  if (_vehiclesController.vehicles.isNotEmpty)
                    _listVehicles(),
                  if (_vehiclesController.vehicles.isEmpty && !_vehiclesController.loading.value)
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

