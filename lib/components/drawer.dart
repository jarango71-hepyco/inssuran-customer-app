import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inssurancustomer/components/route_transitions/slide_right.dart';

import '../controllers/user.dart';
import '../models/label_function.dart';
import '../pages/home/change_pin.dart';
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
  String photo = "";
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 80,
          //alignment: Alignment.center,
          color:  const Color(Consts.C_PRIMARYCOLOR),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(_userController.user!.name, textAlign: TextAlign.center,
                  style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
                ),
              ),
              )
            ],
          ),
        ),
        ListTile(
          title: Text("changepin".tr,
            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
          ),
          leading: const Icon(
            FlutterRemix.lock_password_line,
            color: Color(Consts.C_PRIMARYCOLOR),
          ),
          onTap: () {
            Navigator.push(context, SlideRightRoute(page: const ChangePINPage(),
                routeSettings: const RouteSettings(name: "ChangePINPage")));
            /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => const ProvidersPage(),
                    settings: const RouteSettings(name: "ProvidersPage")));*/
          },
        ),
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
