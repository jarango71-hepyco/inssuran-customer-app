import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/partner.dart';
import '../models/user.dart';
import '../pages/landing.dart';
import '../services/api_base_helper.dart';
import '../services/local_storage_service.dart';
import '../utils/constants.dart';

class UserController extends GetxController {
  String baseUrlAuth = "api/auth";
  String baseUrlPartner = "api/core";
  RxBool loadingLoginUser = false.obs;
  final ApiBaseHelper _helper = ApiBaseHelper();
  User? user;
  INSSPartner? partner;


  Future<User?> userMe() async {
    user = await LocalStorageService.getUserData();
    if (user != null) {
      await getPartner(user!.partner_id!);
    }
    return user;
  }

  Future login(String email, String password) async {
    loadingLoginUser.value = true;

    var body = {
      "email": email,
      "password": password
    };

    String response = await _helper.post("${Consts.appDomain}/$baseUrlAuth/token/", body);
    var decoded = json.decode(response);
    loadingLoginUser.value = false;
    user = User.fromJson(decoded);
    if (user != null) {
      await LocalStorageService.setJWT(user!.access);
      await LocalStorageService.setLanguage(user!.language);
      await LocalStorageService.setUserData(user!);

      if (user!.partner_id != null && user!.partner_id!.isNotEmpty) {
        await getPartner(user!.partner_id!);
      } else {
        throw HasNoPartnerException();
      }
    }
    update();
  }

  Future logout(BuildContext context) async {
    LocalStorageService.logout();
    LocalStorageService.clearSession();
    LocalStorageService.removeUserData();

    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LandingPage(),
      ),
          (route) => false,
    );
  }

  Future getPartner(String id) async {
    try {
      var response = await _helper.get(url: '${Consts.appDomain}/$baseUrlPartner/partners/$id');
      final decoded = jsonDecode(response);
      partner = INSSPartner.fromJson(decoded);
    } on Exception catch (e) {
      partner =  null;
      throw HasNoPartnerException();
    }
  }

  String getUserDescription() {
    if (partner != null) {
      return partner!.name;
    } else if (user != null) {
      return user!.email;
    } else {
      return "";
    }
  }

  String getUserPhoto() {
    if (partner != null) {
      return partner!.logo;
    } else {
      return "";
    }
  }

}

class HasNoPartnerException implements Exception {
}