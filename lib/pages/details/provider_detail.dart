import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../models/provider.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';


class ProviderDetailPage extends StatefulWidget {
  const ProviderDetailPage({Key? key, required this.provider}) : super(key: key);
  final INSSProvider provider;
  @override
  State<StatefulWidget> createState() => _StateProviderDetailPage();
}

class _StateProviderDetailPage extends State<ProviderDetailPage> {
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
      child: Text("companyinfo".tr, textAlign: TextAlign.center,
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
                child: Text(widget.provider.name,
                  style: const TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_PRIMARYCOLOR),
                  ),
                ),
              ),
              Center(
                child: Text(widget.provider.ruc,
                  style: const TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_SECUNDARYCOLOR),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              // Telefono
              GestureDetector(
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: _getBorderRadius(10),
                  ),
                  color: const Color(Consts.C_PRIMARYCOLOR),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5,),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 35,
                        height: 46,
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(FlutterRemix.phone_line, color: Colors.white.withOpacity(0.8), size: 20),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Text(widget.provider.phone,
                          style: TextStyle(
                            fontFamily: FontRes.GILROYLIGHT,
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  csCallNumber(widget.provider.phone);
                },
              ),
              // Email
              GestureDetector(
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: _getBorderRadius(10),
                  ),
                  color: const Color(Consts.C_PRIMARYCOLOR),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5,),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 35,
                        height: 46,
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(FlutterRemix.mail_line, color: Colors.white.withOpacity(0.8), size: 20),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Text(widget.provider.email,
                          style: TextStyle(
                            fontFamily: FontRes.GILROYLIGHT,
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  csSendMail(widget.provider.email);
                },
              ),

              // Información personal
              const SizedBox(height: 10,),
              Text("  ${"information".tr}",
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
                      title: Text("shortname".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(widget.provider.short_name,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("direction".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(widget.provider.address,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 16, ),
                      title: Text("contact".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(widget.provider.contact,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}