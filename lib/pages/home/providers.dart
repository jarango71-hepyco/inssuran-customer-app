import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import '../../components/common_controls.dart';
import '../../controllers/providers.dart';
import '../../models/provider.dart';
import '../../models/label_function.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';
import '../Details/provider_detail.dart';


class ProvidersPage extends StatefulWidget {
  const ProvidersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateProvidersPage();
}

class _StateProvidersPage extends State<ProvidersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? _searchQuery;
  bool _isSearching = false;
  bool _loadingOverlay = false;

  final _scrollController = ScrollController();
  final ProvidersController _providersController = Get.find<ProvidersController>();

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _providersController.filterController = _searchQuery!;

    listProviders();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          print('At the top');
          listProviders(paginated: false);
        } else {
          if (!_providersController.allLoaded.value) {
            listProviders(paginated: true);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _searchQuery!.dispose();
    super.dispose();
  }

  void listProviders({bool paginated = false}) async {
    try {
      setState(() {_loadingOverlay = true;});
      await _providersController.listProviders (paginated: paginated);
    } on BadRequestException catch (e) {
      csDialog(context: context, text: e.message,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]
      );
    } on FetchDataException {
      csDialog(context: context, text: "ERROR_MSG_FETCH_DATA_EXCEPTION".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]
      );
    } on Exception {
      csDialog(context: context, text: "PROVIDERS_ERROR_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      setState(() {_loadingOverlay = false;});
      _providersController.loading.value = false;
      _providersController.scrollLoading.value = false;
      _providersController.update();
    }
  }

  void _startSearch() {
    listProviders();
  }

  void _stopSearching() {
    _searchQuery!.clear();
    listProviders();
  }

  Widget _listInsureds() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: true,
        itemExtent: 55,
        itemCount: _providersController.providers.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(Consts.C_AVATAR),
              child: Text(_providersController.providers[index].name[0].toUpperCase(),
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_WHITECOLOR),
                ),
              ),
            ),
            title: Text(_providersController.providers[index].name,
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(Consts.C_PRIMARYCOLOR),
              ),
            ),
            subtitle: Text(_providersController.providers[index].ruc,
              style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(Consts.C_STATUS3),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProviderDetailPage(provider: _providersController.providers[index])));
            },
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("companies".tr, textAlign: TextAlign.center,
        style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          FlutterRemix.notification_2_line,
          color: Color(Consts.C_WHITECOLOR),
        ),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return csLoadingOverlay(
      loading: _loadingOverlay,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
          leading: IconButton(
            icon: const Icon(FlutterRemix.arrow_left_line),
            onPressed: () => Navigator.pop(context),
            /* Navigator.push(context, SlideRightRoute(page: const HomePage(),
                routeSettings: const RouteSettings(name: "HomePage"))),*/
          ),
          title: _buildTitle(context),
          //actions: _buildActions(),
        ),
        body: GetBuilder<ProvidersController>(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    if (_providersController.providers.isNotEmpty)
                    csSearch(
                        controller: _searchQuery,
                        label: '',
                        hintText: "search".tr,
                        height: 54,
                        width: 350,
                        searching: _isSearching,
                        onChanged: (String text) {
                          if (_isSearching) {
                            if (_searchQuery!.text.isNotEmpty) {
                              setState(() {
                                _startSearch();
                              });
                            } else {
                              setState(() {
                                _isSearching = false;
                                _stopSearching();
                              });
                            }
                          }
                        },
                        onPressed: () {
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                          if (_isSearching) {
                            _startSearch();
                          } else {
                            _stopSearching();
                          }
                        }
                    ),
                    const SizedBox(height: 10,),
                    if (_providersController.providers.isNotEmpty)
                      _listInsureds(),
                    if (_providersController.providers.isEmpty && !_providersController.loading.value)
                      Center(
                        child: csEmptyList("noitems".tr),
                      ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}