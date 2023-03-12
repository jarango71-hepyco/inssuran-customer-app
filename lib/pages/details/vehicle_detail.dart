import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:inssurancustomer/models/vehicle.dart';
import 'package:get/get.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';


class VehicleDetailPage extends StatefulWidget {
  const VehicleDetailPage({Key? key, required this.vehicle}) : super(key: key);
  final INSSVehicle vehicle;

  @override
  State<StatefulWidget> createState() => _StateVehicleDetailPage();
}

class _StateVehicleDetailPage extends State<VehicleDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("vehicleinfo".tr, textAlign: TextAlign.center,
        style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
      ),
    );
  }

  BorderRadius _getBorderRadius(double radius) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.zero,
      bottomRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
    );
  }

  @override
  Widget build(BuildContext context) {
    double radius = 6.0;
    double height = 87;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
        leading: IconButton(
          icon: const Icon(FlutterRemix.arrow_left_line),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildTitle(context),
        //actions: _buildActions(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10,),
              Center(
                child: Text(widget.vehicle.owner.name,
                  style: const TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_PRIMARYCOLOR),
                  ),
                ),
              ),
              Center(
                child: Text(widget.vehicle.plate,
                  style: const TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_SECUNDARYCOLOR),
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              // Información del vehiculo
              const SizedBox(height: 10,),
              Text("  ${"description".tr}",
                //textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_PRIMARYCOLOR),
                ),
              ),
              const SizedBox(height: 5,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: _getBorderRadius(10),
                ),
                color: Colors.white,
                elevation: 2,
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("brand".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(widget.vehicle.brand,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("model".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("${widget.vehicle.model}",
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("color".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(widget.vehicle.color,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("year".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("${widget.vehicle.year}",
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("version".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(widget.vehicle.version,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("cousin".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("${widget.vehicle.prima}",
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),

                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}