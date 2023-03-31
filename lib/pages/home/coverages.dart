import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../models/label_function.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';
import '../Details/vehicle_detail.dart';


class CoveragesPage extends StatefulWidget {
  const CoveragesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateCoveragesPage();
}

class _StateCoveragesPage extends State<CoveragesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loadingOverlay = false;

  final _scrollController = ScrollController();
  //final CoveragesController _CoveragesController = Get.find<CoveragesController>();

  List<String> coverages = ["Cobertura", "Ayuda", "Beneficio"];
  List<String> coveragesDetails = ["Cobertura uno para todos", "Ayuada uno para todos", "Beneficio uno para todos"];

  @override
  void initState() {
    super.initState();

    listCoverages();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          listCoverages(paginated: false);
        } else {
          /*if (!_CoveragesController.allLoaded.value) {
            listCoverages(paginated: true);
          }*/
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void listCoverages({bool paginated = false}) async {
    try {
      setState(() {_loadingOverlay = true;});
      //_CoveragesController.loading.value = true;
      //await _CoveragesController.listCoverages (paginated: paginated);
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
      csDialog(context: context, text: "Coverages_ERROR_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      setState(() {_loadingOverlay = false;});
      //_CoveragesController.loading.value = false;
      //_CoveragesController.scrollLoading.value = false;
      //_CoveragesController.update();
    }
  }

  Widget _listCoverages() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: true,
        itemExtent: 55,
        //itemCount: _CoveragesController.Coverages.length,
        itemCount: coverages.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(Consts.C_AVATAR),
              //child: Text(_CoveragesController.Coverages[index].brand[0].toUpperCase(),
              child: Text(coverages[index][0].toUpperCase(),
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_WHITECOLOR),
                ),
              ),
            ),
            title: Text(coverages[index],
            //title: Text("${_CoveragesController.Coverages[index].brand} ${_CoveragesController.Coverages[index].model} - ${_CoveragesController.Coverages[index].year}",
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(Consts.C_PRIMARYCOLOR),
              ),
            ),
            //subtitle: Text("${_CoveragesController.Coverages[index].plate} | ${_CoveragesController.Coverages[index].owner.name}",
            subtitle: Text(coveragesDetails[index],
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(Consts.C_STATUS3),
              ),
            ),
            onTap: () {
              /*Navigator.push(context, SlideRightRoute(page: VehicleDetailPage(vehicle: _CoveragesController.Coverages[index],),
                  routeSettings: const RouteSettings(name: "VehicleDetailPage")));*/
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
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10,),
              //if (_CoveragesController.Coverages.isNotEmpty)
                _listCoverages(),
              /*if (_CoveragesController.Coverages.isEmpty && !_CoveragesController.loading.value)
                Center(
                  child: csEmptyList("noitems".tr),
                ),*/
            ],
          ),
        )
    );
  }
}

