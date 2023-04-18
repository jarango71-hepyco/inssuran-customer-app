import 'package:flutter/material.dart';
import 'package:inssurancustomer/models/policy.dart';
import 'package:inssurancustomer/pages/home/representative.dart';
import 'package:inssurancustomer/pages/home/documents.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import '../../components/drawer.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';
import 'coverages.dart';

class InsuredObjectsPage extends StatefulWidget {
  const InsuredObjectsPage({Key? key, required this.policy}) : super(key: key);
  final INSSPolicy policy;

  @override
  InsuredObjectsPageState createState() => InsuredObjectsPageState();
}

class InsuredObjectsPageState extends State<InsuredObjectsPage> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;
  final PreloadPageController _pageController = PreloadPageController(
      initialPage: 0, keepPage: true, viewportFraction: 1);

  late bool _canChange;

  @override
  void initState() {
    super.initState();

    _canChange = true;
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        changePage(_tabController.index, page: true);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void changePage(index, {page = false, tab = false}) async {
    if (page) {
      _canChange = false;
      await _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        _canChange = true;
      });
    } else {
      setState(() {
        _tabController.animateTo(index);
      });
    }
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("${"policy".tr} - ${widget.policy.policy_number}", textAlign: TextAlign.center,
        style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      controller: _tabController,
      indicatorWeight: 3,
      indicatorColor: const Color(Consts.C_ACCENTCOLOR),
      labelStyle: const TextStyle(
        fontFamily: FontRes.GILROYLIGHT,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(Consts.C_TEXTCOLOR),
      ),
      tabs: <Widget>[
        Tab(
          //icon: const Icon(FlutterRemix.group_line, color: Color(Consts.C_WHITECOLOR), size: 22,),
          text: "representative".tr,

        ),
        Tab(
          //icon: const Icon(FlutterRemix.roadster_line, color: Color(Consts.C_WHITECOLOR), size: 22,),
          text: "documents".tr,
        ),
        Tab(
          //icon: const Icon(FlutterRemix.roadster_line, color: Color(Consts.C_WHITECOLOR), size: 22,),
          text: "coverages".tr,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
        leading: IconButton(
          icon: const Icon(FlutterRemix.arrow_left_line),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildTitle(context),
        // actions: _buildActions(),
        bottom: _tabBar(),
      ),
      drawer: buildDrawer(context),
      body: PreloadPageView(
        preloadPagesCount: 2,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          if (_canChange) {
            changePage(index);
          }
        },
        children: <Widget>[
          RepresentativePage(policy: widget.policy),
          DocumentsPage(policy: widget.policy),
          CoveragesPage(policy: widget.policy),
        ],
      ),
    );
  }

}
