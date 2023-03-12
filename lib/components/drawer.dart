import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inssurancustomer/components/route_transitions/slide_right.dart';

import '../controllers/user.dart';
import '../models/label_function.dart';
import '../pages/home/providers.dart';
import '../services/app_exception.dart';
import '../utils/constants.dart';
import 'common_controls.dart';

final UserController _userController = Get.find<UserController>();

Future<void> _logout(BuildContext context) async {
  try {
    EasyLoading.show();
    _userController.logout(context);
  } on AppException catch (e) {
    csDialog(context: context, text: e.message,
        buttons: [
          LabelFunction(Consts.LINK_OK, () {
            Navigator.of(context).pop();
          }),
        ]
    );
  } finally {
    EasyLoading.dismiss();
  }
}

void showLogout(BuildContext context) {
  final List<LabelFunction> buttons = [
    LabelFunction("closesession".tr, () {
      _logout(context);
    },
    color: const Color(Consts.C_PRIMARYCOLOR)),
    LabelFunction("cancel".tr,  (){
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    },
    color: const Color(Consts.C_PRIMARYCOLOR),),
  ];

  csDialog(context: context,
      text: "closesessiontitle".tr,
      buttons: buttons);

}
Widget buildDrawer(BuildContext context) {
  String photo = _userController.getUserPhoto();
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 220,
          //alignment: Alignment.center,
          color:  const Color(Consts.C_PRIMARYCOLOR),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(Consts.C_WHITECOLOR),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      color: Color(Consts.C_SECUNDARYCOLOR),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: photo.isNotEmpty?
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: photo,
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
                      ):
                      const SizedBox(
                        width: 80,
                        height: 80,
                        child: Icon(FlutterRemix.user_fill,
                          color: Color(Consts.C_PRIMARYCOLOR),
                          size: 80,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(_userController.getUserDescription(), textAlign: TextAlign.center,
                  style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
                ),
              ),
              )
            ],
          ),
        ),
        ListTile(
          title: Text("companies".tr,
            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
          ),
          leading: const Icon(
            FlutterRemix.building_2_line,
            color: Color(Consts.C_PRIMARYCOLOR),
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(page: const ProvidersPage(),
                routeSettings: const RouteSettings(name: "ProvidersPage")));
            /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => const ProvidersPage(),
                    settings: const RouteSettings(name: "ProvidersPage")));*/
          },
        ),
        // ListTile(
        //   title: Text("notifications".tr,
        //     style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
        //   ),
        //   leading: const Icon(
        //     FlutterRemix.notification_2_line,
        //     color: Color(Consts.C_PRIMARYCOLOR),
        //   ),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // ListTile(
        //   title: Text(Consts.S_HELP,
        //     style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
        //   ),
        //   leading: const Icon(
        //     FlutterRemix.question_line,
        //     color: Color(Consts.C_PRIMARYCOLOR),
        //     semanticLabel: Consts.S_HELP,
        //   ),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        // ),
        ListTile(
          title: Text("closesession".tr,
            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
          ),
          leading: const Icon(
            Icons.exit_to_app_outlined,
            color: Color(Consts.C_PRIMARYCOLOR),
          ),
          onTap: () {
            showLogout(context);
          },
        ),
      ],
    ),
  );
}
