import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/provider.dart';
import '../services/api_base_helper.dart';
import '../utils/constants.dart';

class ProvidersController extends GetxController {
  final ApiBaseHelper _helper = ApiBaseHelper();

  String baseUrl = "api/policy";
  RxList<INSSProvider> providers = <INSSProvider>[].obs;
  RxBool loading = false.obs;
  RxBool scrollLoading = false.obs;
  RxBool allLoaded = false.obs;
  int currentPage = 1;
  int pageSize = 10;

  TextEditingController filterController = TextEditingController(text: '');

  Future<void> listProviders({bool paginated = false}) async {
    if (paginated) {
      scrollLoading.value = true;
    } else {
      loading.value = true;
      currentPage = 1;
      allLoaded.value = false;
    }
    update();

    Map<String, String> filters = geFilters();
    String response = await _helper.get(url: '${Consts.appDomain}/$baseUrl/providers/', qParams: filters);
    var decoded = json.decode(response);
    var list = decoded['results'] as List;
    List<INSSProvider> provs = list.map((provider) => INSSProvider.fromJson(provider)).toList();
    allLoaded.value = provs.length < pageSize + 1;
    save(provs, paginated);
    // loading.value = false;
  }

  save(List<INSSProvider> data, bool paginated) {
    if (!paginated) {
      providers.value = data;
      currentPage += 1;
    } else {
      providers.addAll(data);
      currentPage += 1;
      update();
    }
  }

  Map<String, String> geFilters() {
    Map<String, String> queryParams = {};
    queryParams['page'] = currentPage.toString();

    if (filterController.text.isNotEmpty) {
      queryParams['search'] = filterController.text;
    }

    return queryParams;
  }

}