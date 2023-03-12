import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/customer.dart';
import '../services/api_base_helper.dart';
import '../utils/constants.dart';

class InsuredsController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();

  String baseUrl = "api/core";
  RxList<INSSCustomer> insureds = <INSSCustomer>[].obs;
  RxBool loading = false.obs;
  RxBool scrollLoading = false.obs;
  RxBool allLoaded = false.obs;
  int currentPage = 1;
  int pageSize = 10;

  TextEditingController filterController = TextEditingController(text: '');

  Future<void> listInsureds({bool paginated = false}) async {
    if (paginated) {
      scrollLoading.value = true;
    } else {
      loading.value = true;
      currentPage = 1;
      allLoaded.value = false;
    }
    //update();

    Map<String, String> filters = geFiltersInsureds();
    String response = await _helper.get(url: '${Consts.appDomain}/$baseUrl/customers/', qParams: filters);
    var decoded = json.decode(response);
    var list = decoded['results'] as List;
    List<INSSCustomer> customers = list.map((policy) => INSSCustomer.fromJson(policy)).toList();
    allLoaded.value = customers.length < pageSize + 1;
    saveInsureds(customers, paginated);
    loading.value = false;
  }

  saveInsureds(List<INSSCustomer> data, bool paginated) {
    if (!paginated) {
      insureds.value = data;
      currentPage += 1;
    } else {
      insureds.addAll(data);
      currentPage += 1;
      update();
    }
  }

  Map<String, String> geFiltersInsureds() {
    Map<String, String> queryParams = {};
    queryParams['insured_type'] = 'insured';
    queryParams['page'] = currentPage.toString();
    //queryParams['pagesize'] = pageSize.toString();

    if (filterController.text.isNotEmpty) {
      queryParams['search'] = filterController.text;
      //queryParams['search'] = "policy_number=${filterController.text},contractor_name=${filterController.text}";
      //queryParams['searchopt'] = "or";
    }

    return queryParams;
  }

}