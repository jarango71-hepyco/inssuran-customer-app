import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/Place.dart';
import '../models/partner.dart';
import '../models/user.dart';
import '../pages/landing.dart';
import '../services/api_base_helper.dart';
import '../services/app_exception.dart';
import '../services/local_storage_service.dart';
import '../utils/constants.dart';

class UserController extends GetxController {
  String baseUrlAuth = "/api/cutomer-mobile";
  String baseUrl = "/api/core";

  RxBool loadingLoginUser = false.obs;
  final ApiBaseHelper _helper = ApiBaseHelper();
  User? user;
  INSSPartner? partner;

  Future<User?> userMe() async {
    user = await LocalStorageService.getUserData();
    return user;
  }
  Future login(String identification, String pinCode) async {
    loadingLoginUser.value = true;

    var body = {
      "identification": identification,
      "pin_code": pinCode
    };

    String response = await _helper.post(
        "${Consts.appDomain}/$baseUrlAuth/login/", body);
    var decoded = json.decode(response);
    loadingLoginUser.value = false;
    user = User.fromJson(decoded);
    if (user != null) {
      //await LocalStorageService.setLanguage(user!.language);
      user!.pinCode = pinCode;

      List<INSSPlace> places = await getPlace(user!.province);
      user!.province_name = places[0].name;

      places = await getPlace(user!.city);
      user!.city_name = places[0].name;

      await LocalStorageService.setUserData(user!);
      /*if (user!.partner_id != null && user!.partner_id!.isNotEmpty) {
        await getPartner(user!.partner_id!);
      } else {
        throw HasNoPartnerException();
      }*/
    }
    update();
  }

  Future logout(BuildContext context) async {
    LocalStorageService.removeUserData();

    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LandingPage(),
      ),
          (route) => false,
    );
  }

  Future changePIN(String pinCode, String newPinCode) async {
    var body = {
      "identification": user!.identification,
      "pin_code": pinCode,
      "new_pin_code": newPinCode
    };

    String response = await _helper.post(
        "${Consts.appDomain}/$baseUrlAuth/change-pin-code/", body);
    user!.pinCode = newPinCode;
    await LocalStorageService.setUserData(user!);
  }

  Future updateProfile(String email, String phone, String street, int province,
    String provinceName, int city, String cityName) async {
    var body = {
      "identification": user!.identification,
      "pin_code": user!.pinCode,
      "email": email,
      "phone": phone,
      "street": street,
      "province": province,
      "city": city
    };

    String response = await _helper.post(
        "${Consts.appDomain}/$baseUrlAuth/customer-update/", body);
    if (response.isEmpty) {
      user!.email = email;
      user!.phone = phone;
      user!.street = street;
      user!.province = province;
      user!.province_name = provinceName;
      user!.city = city;
      user!.city_name = cityName;
      await LocalStorageService.setUserData(user!);
    }
  }

  Future<List<INSSPlace>> getPlace(int id) async {
    try {
      var response = await _helper.get(
          url: '${Consts.appDomain}/$baseUrl/country-states?id=$id');
      var decoded = json.decode(response);
      var list = decoded['results'] as List;
      List<INSSPlace> places = list.map((place) => INSSPlace.fromJson(place))
          .toList();
      return places;
    } on FetchDataException catch (e) {
      return [];
    }
  }

  Future<List<INSSPlace>> getPlaces(int parent) async {
    try {
      var response = await _helper.get(
          url: '${Consts.appDomain}/$baseUrl/country-states?parent=$parent');
      var decoded = json.decode(response);
      var list = decoded['results'] as List;
      List<INSSPlace> places = list.map((place) => INSSPlace.fromJson(place))
          .toList();
      return places;
    } on FetchDataException catch (e) {
      return [];
    }
  }

}

class HasNoPartnerException implements Exception {
}