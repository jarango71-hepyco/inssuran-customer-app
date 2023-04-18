import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../utils/constants.dart';

class LocalStorageService {
  static const String SHP_LOGGED_IN = "loggedIn";
  static const String SHP_JWT = "JWT";
  static const String HAS_SESSION = "hasSession";
  static const String SHP_USER_INFO = "userInfoCustomer";
  static const String SHR_LANGUAGE = "LANGUAGE";

  static Future<void> setLoggedIn(bool loggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(SHP_LOGGED_IN, loggedIn);
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(SHP_LOGGED_IN) ?? false;
  }

  static Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(SHP_LOGGED_IN);
    pref.remove(SHP_JWT);
    pref.remove(SHP_USER_INFO);
  }

  static Future<void> setUserData(User user) async {
    String strUser = jsonEncode(user);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(SHP_USER_INFO, strUser);
  }

  static Future<User?> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? strUser = pref.getString(SHP_USER_INFO);
    if (strUser != null) {
      return User.fromJson(jsonDecode(strUser));
    }
    return null;
  }

  static Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SHP_USER_INFO);
  }


  static Future<void> setJWT(String jwt) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(SHP_JWT, jwt);
  }

  static Future<String?> getJWT() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(SHP_JWT);
  }

  static Future<void> deleteJWT() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(SHP_JWT);
  }

  static Future<bool?> hasSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return Future.value(pref.getBool(HAS_SESSION)) ;
  }

  static Future<void> setHasSession(bool session) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(HAS_SESSION,session);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(HAS_SESSION, false);
    prefs.remove(HAS_SESSION);
  }

  static Future<void> createSession() async {
    return LocalStorageService.setHasSession(true);
  }

  static Future<String> getLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var language = pref.getString(SHR_LANGUAGE);
    if (language != null) {
      return language;
    }
    else {
      return "es";
    }
  }

  static Future<void> setLanguage(String language) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(SHR_LANGUAGE, language);
  }

}