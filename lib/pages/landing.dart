import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/route_transitions/fade.dart';
import '../controllers/user.dart';
import '../models/user.dart';
import '../res/assets_res.dart';
import '../utils/constants.dart';
import 'home.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateLandingPage();
}

class _StateLandingPage extends State<LandingPage> {

  final UserController _userController = Get.find<UserController>();

  _checkIfAuthenticated() async {
    //await LocalStorageService.removeUserData();
    bool isLoggedIn = await _loadUserData();
    await Future.delayed(const Duration(seconds: 2));
    return isLoggedIn;
  }

  _loadUserData() async {
    try {
      User? user = await _userController.userMe();
      return user != null;
    } on Exception {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    _checkIfAuthenticated().then((success) {
      _gotoView(success);
    });
  }

  _gotoView(bool success)
  {
    if (success) {
      Navigator.pushReplacement(context, FadeRoute(page: const HomePage(),
          routeSettings: const RouteSettings(name: "HomePage"), duration: const Duration(milliseconds: 1000)));
    } else {
      Navigator.pushReplacement(
          context, FadeRoute(page: const LoginPage(),
          routeSettings: const RouteSettings(name: "LoginPage"),
          duration: const Duration(milliseconds: 500)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(Consts.C_WHITECOLOR),
      child: Center(
        child: //Image.asset(AssetsRes.LOGO)
        SvgPicture.asset(
          AssetsRes.LOGO,
          width: 100,
          height: 108,
          // width: 112.14,
        ),
      ),
    );
  }
}