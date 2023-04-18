import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inssurancustomer/pages/home/profile_edit.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../components/common_controls.dart';
import '../../components/drawer.dart';
import '../../components/route_transitions/slide_right.dart';
import '../../controllers/user.dart';
import '../../models/user.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateProfilePage();
}

class _StateProfilePage extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController _userController = Get.find<UserController>();
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = _userController.user;
  }

  Future<void> initialization() async {
    _user = _userController.user;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("profile".tr, textAlign: TextAlign.center,
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

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          FlutterRemix.more_2_fill,
          color: Color(Consts.C_WHITECOLOR),
        ),
        onPressed: () {

        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
        title: _buildTitle(context),
        leading: IconButton(
          icon: const Icon(FlutterRemix.menu_line),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10,),

              Center(
                //widget.customer.name
                child: Text(_user!.name,
                  style: const TextStyle(
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
              /*Stack(
                children: [
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
                  Positioned(
                    bottom: 15,
                    right: width/2 - 95,
                    child: GestureDetector(
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(Consts.C_PRIMARYCOLOR),
                          shape: BoxShape.circle,
                        ),
                        child:  const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(Consts.C_WHITECOLOR),
                          child: Icon(
                            FlutterRemix.camera_fill,
                            color: Color(Consts.C_PRIMARYCOLOR),
                            size: 35,
                          ),
                        ),
                      ),
                      onTap: () {
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),*/

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
                      subtitle: Text(_user!.identification,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("email".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_user!.email,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("phone".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_user!.phone,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("province".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_user!.province_name,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("city".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_user!.city_name,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text("street".tr,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_user!.street,
                        style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: csLargeButton(
                    label: "editprofile".tr,
                    //width: MediaQuery.of(context).size.width - 5,
                    textColor: Colors.white.withOpacity(0.8),
                    onTap: () async {
                      await Navigator.push(context, SlideRightRoute(page: const ProfileEditPage(),
                          routeSettings: const RouteSettings(name: "ProfileEditPage")));
                      setState(() {});
                    },
                    width: MediaQuery.of(context).size.width
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}