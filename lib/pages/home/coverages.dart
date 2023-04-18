import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../models/policy.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';


class CoveragesPage extends StatefulWidget {
  const CoveragesPage({Key? key, required this.policy}) : super(key: key);
  final INSSPolicy policy;

  @override
  State<StatefulWidget> createState() => _StateCoveragesPage();
}

class _StateCoveragesPage extends State<CoveragesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final _scrollController = ScrollController();
    bool _loadingOverlay = false;

  List<String> coverages = ["Cobertura", "Ayuda", "Beneficio"];
  List<String> coveragesDetails = ["Cobertura uno para todos", "Ayuada uno para todos", "Beneficio uno para todos"];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _listCoverages() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: true,
        itemExtent: 55,
        itemCount: widget.policy?.coverages.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(Consts.C_AVATAR),
              child: Text(widget.policy.coverages[index].coverage_type_name[0].toUpperCase(),
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_WHITECOLOR),
                ),
              ),
            ),
            title: Text(widget.policy.coverages[index].coverage_type_name,
            //title: Text("${_CoveragesController.Coverages[index].brand} ${_CoveragesController.Coverages[index].model} - ${_CoveragesController.Coverages[index].year}",
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(Consts.C_PRIMARYCOLOR),
              ),
            ),
            subtitle: Text("${"limit".tr}: ${widget.policy.coverages[index].amount_limit} | ${"percentage".tr}: ${widget.policy.coverages[index].amount_percentage}",
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10,),
          //if (_CoveragesController.Coverages.isNotEmpty)
            _listCoverages(),
        ],
      ),
    );
  }
}

