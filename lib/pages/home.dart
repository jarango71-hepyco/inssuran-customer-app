import 'package:flutter/widgets.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';

import '../res/i_font_res.dart';
import '../utils/constants.dart';
import 'home/payments.dart';
import 'home/contractors.dart';
import 'home/insured_objects.dart';
import 'home/policies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  int _selectedPage = 0;
  final List<Widget> _pageOptions = [
    const PoliciesPage(),
    const InsuredObjectsPage(),
    const ContractorsPage(),
    const PaymentsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _initialization();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _initialization() async {
    //String language = await LocalStorageService.getLanguage();
    Locale locale = const Locale('es','ES');
    /*if (language == "en") {
      locale = const Locale('en','US');
    }*/
    setState(() {
      Get.updateLocale(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        elevation: 4,
        color: Colors.white.withOpacity(0.9),
        backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
        items: [
          TabItem(icon: FlutterRemix.shield_check_line , title: "policies".tr, fontFamily: FontRes.AVENIRROMAN),
          TabItem(icon: FlutterRemix.secure_payment_line, title: "insureds".tr, fontFamily: FontRes.AVENIRROMAN),
          TabItem(icon: FlutterRemix.user_follow_line, title: "contractors".tr, fontFamily: FontRes.AVENIRROMAN),
          TabItem(icon: FlutterRemix.wallet_3_line, title: "payments".tr, fontFamily: FontRes.AVENIRROMAN),
        ],
        initialActiveIndex: _selectedPage,
        onTap: (index){
          setState(() {
            _selectedPage = index;
          });
        },
      ),
      body: _pageOptions[_selectedPage],
    );
  }
}




