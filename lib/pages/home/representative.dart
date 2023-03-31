import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:inssurancustomer/pages/home/profile_edit.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';


class RepresentativePage extends StatefulWidget {
  const RepresentativePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateRepresentativePage();
}

class _StateRepresentativePage extends State<RepresentativePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    double height = 100;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10,),

              const Center(
                //widget.customer.name
                child: Text("Jorge Luis Arango Labrada",
                  style: TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_PRIMARYCOLOR),
                  ),
                ),
              ),
              /*const Center(
                //widget.customer.identification
                child: Text("1756501704",
                  style: TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_SECUNDARYCOLOR),
                  ),
                ),
              ),*/
              const SizedBox(height: 10,),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color(Consts.C_BORDERCOLOR),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    //child: true?
                    child:
                    /*ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: "",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const RPadding(
                            padding: EdgeInsets.all(38),
                            child: CircularProgressIndicator(color: Color(Consts.C_ACCENTCOLOR), strokeWidth: 2,),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(FlutterRemix.user_fill,
                              color: Color(Consts.C_PRIMARYCOLOR),
                              size: 80,
                            ),
                          ),
                        )
                    ):*/
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Icon(FlutterRemix.user_fill,
                        color: Color(Consts.C_PRIMARYCOLOR),
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              // Información personal
              const SizedBox(height: 10,),
              Text("  ${"personalinformation".tr}",
                //textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_PRIMARYCOLOR),
                ),
              ),

              const SizedBox(height: 5,),
              Column(
                children: [
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
                          title: Text("identification".tr,
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text("1756501704",
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text("gender".tr,
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text("Masculino",
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 16, ),
                          title: Text("age".tr,
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text("51",
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text("birthday".tr,
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text("24/11/1971",
                            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
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
                            child: Text("+593 99 523 0554",
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
                      //csCallNumber(widget.provider.phone);
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
                            child: Text("jarango71@gmail.com",
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
                      //csSendMail(widget.provider.email);
                    },
                  ),

                ],
              ),
            ],
          ),
        ),
    );
  }
}