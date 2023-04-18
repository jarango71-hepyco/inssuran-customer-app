import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/policy.dart';
import '../models/user.dart';
import '../services/api_base_helper.dart';
import '../services/local_storage_service.dart';
import '../utils/constants.dart';

class HistoricalsController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();

  String baseUrl = "/api/cutomer-mobile";
  RxList<INSSPolicy> policies = <INSSPolicy>[].obs;
  RxBool loading = false.obs;
  RxBool scrollLoading = false.obs;
  RxBool allLoaded = false.obs;
  int currentPage = 1;
  int pageSize = 10;

  TextEditingController filterController = TextEditingController(text: '');

  Future<void> listHistoricals({bool paginated = false}) async {
    if (paginated) {
      scrollLoading.value = true;
    } else {
      loading.value = true;
      currentPage = 1;
      allLoaded.value = false;
    }
    update();

    User? user = await LocalStorageService.getUserData();

    if (user == null) {
      return;
    }

    var body = {
      "identification": user.identification,
      "pin_code": user.pinCode
    };

    String response = await _helper.post("${Consts.appDomain}/$baseUrl/policies/?state=closed", body);
    var decoded = json.decode(response);
    var list = decoded as List;
    List<INSSPolicy> policies = list.map((policy) => INSSPolicy.fromJson(policy)).toList();
    allLoaded.value = policies.length < pageSize + 1;
    save(policies, paginated);
    // loading.value = false;
  }

  save(List<INSSPolicy> data, bool paginated) {
    if (!paginated) {
      policies.value = data;
      currentPage += 1;
    } else {
      policies.addAll(data);
      currentPage += 1;
      update();
    }
  }

  Map<String, String> geFilters() {
    Map<String, String> queryParams = {};
    //queryParams['policy_type'] = '';
    queryParams['page'] = currentPage.toString();
    //queryParams['pagesize'] = pageSize.toString();

    if (filterController.text.isNotEmpty) {
      queryParams['policy_number_contains'] = filterController.text;
      //queryParams['search'] = "policy_number=${filterController.text},contractor_name=${filterController.text}";
      //queryParams['searchopt'] = "or";
    }

    return queryParams;
  }

}