import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/payments.dart';
import '../services/api_base_helper.dart';
import '../utils/constants.dart';

class PaymentsController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();

  String baseUrl = "api/policy";
  RxList<INSSPayment> payments = <INSSPayment>[].obs;
  RxBool loading = false.obs;
  RxBool scrollLoading = false.obs;
  RxBool allLoaded = false.obs;
  int currentPage = 1;
  int pageSize = 10;

  TextEditingController filterController = TextEditingController(text: '');

  Future<void> listPayments({bool paginated = false}) async {
    if (paginated) {
      scrollLoading.value = true;
    } else {
      loading.value = true;
      currentPage = 1;
      allLoaded.value = false;
    }
    update();

    Map<String, String> filters = geFilters();
    String response = await _helper.get(url: '${Consts.appDomain}/$baseUrl/payments/', qParams: filters);
    var decoded = json.decode(response);
    var list = decoded['results'] as List;
    List<INSSPayment> pays = list.map((vehicle) => INSSPayment.fromJson(vehicle)).toList();
    allLoaded.value = pays.length < pageSize + 1;
    save(pays, paginated);
    // loading.value = false;
  }

  save(List<INSSPayment> data, bool paginated) {
    if (!paginated) {
      payments.value = data;
      currentPage += 1;
    } else {
      payments.addAll(data);
      currentPage += 1;
      update();
    }
  }

  Map<String, String> geFilters() {
    Map<String, String> queryParams = {};
    queryParams['page'] = currentPage.toString();
    //queryParams['pagesize'] = pageSize.toString();

    if (filterController.text.isNotEmpty) {
      queryParams['search'] = filterController.text;
      //queryParams['search'] = "vehicle_number=${filterController.text},contractor_name=${filterController.text}";
      //queryParams['searchopt'] = "or";
    }

    return queryParams;
  }

}