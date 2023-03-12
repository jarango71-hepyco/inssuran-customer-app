import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/vehicle.dart';
import '../services/api_base_helper.dart';
import '../utils/constants.dart';

class VehiclesController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();

  String baseUrl = "api/core";
  RxList<INSSVehicle> vehicles = <INSSVehicle>[].obs;
  RxBool loading = false.obs;
  RxBool scrollLoading = false.obs;
  RxBool allLoaded = false.obs;
  int currentPage = 1;
  int pageSize = 10;

  TextEditingController filterController = TextEditingController(text: '');

  Future<void> listVehicles({bool paginated = false}) async {
    if (paginated) {
      scrollLoading.value = true;
    } else {
      loading.value = true;
      currentPage = 1;
      allLoaded.value = false;
    }
    update();

    Map<String, String> filters = geFilters();
    String response = await _helper.get(url: '${Consts.appDomain}/$baseUrl/vehicles/', qParams: filters);
    var decoded = json.decode(response);
    var list = decoded['results'] as List;
    List<INSSVehicle> vehics = list.map((vehicle) => INSSVehicle.fromJson(vehicle)).toList();
    allLoaded.value = vehics.length < pageSize + 1;
    save(vehics, paginated);
    // loading.value = false;
  }

  save(List<INSSVehicle> data, bool paginated) {
    if (!paginated) {
      vehicles.value = data;
      currentPage += 1;
    } else {
      vehicles.addAll(data);
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