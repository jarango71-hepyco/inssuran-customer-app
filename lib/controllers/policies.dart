import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/policy.dart';
import '../services/api_base_helper.dart';
import '../utils/constants.dart';

class PoliciesController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();

  String baseUrl = "api/policy";
  RxList<INSSPolicy> policies = <INSSPolicy>[].obs;
  RxBool loading = false.obs;
  RxBool scrollLoading = false.obs;
  RxBool allLoaded = false.obs;
  int currentPage = 1;
  int pageSize = 10;

  TextEditingController filterController = TextEditingController(text: '');

  Future<void> listPolicies({bool paginated = false}) async {
    if (paginated) {
      scrollLoading.value = true;
    } else {
      loading.value = true;
      currentPage = 1;
      allLoaded.value = false;
    }
    update();

    Map<String, String> filters = geFilters();
    String response = await _helper.get(url: '${Consts.appDomain}/$baseUrl/policies/', qParams: filters);
    var decoded = json.decode(response);
    var list = decoded['results'] as List;
    List<INSSPolicy> policies = list.map((policy) => INSSPolicy.fromJson(policy)).toList();
    // Quitar
    policies[0].policy_number = "00011";
    INSSPolicy tmp = INSSPolicy.from(policies[0]);
    tmp.state = "closed";
    tmp.contractor_name = "Jorge Luis Arango Labrada";
    tmp.policy_number = "00012";
    policies.add(tmp);
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