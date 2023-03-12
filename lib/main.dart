import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:inssurancustomer/res/i_font_res.dart';
import 'package:inssurancustomer/utils/Messages.dart';

import '../../utils/constants.dart';
import 'controllers/contractors.dart';
import 'controllers/insureds.dart';
import 'controllers/payments.dart';
import 'controllers/policies.dart';
import 'controllers/providers.dart';
import 'controllers/user.dart';
import 'controllers/vehicles.dart';
import 'pages/landing.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(Consts.C_WHITECOLOR), // status bar color
    statusBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  GlobalBindings().dependencies();
  configLoading();
  runApp(const MedicalRecordPage());
}

class MedicalRecordPage extends StatefulWidget {
  const MedicalRecordPage({Key? key}) : super(key: key);
  @override
  MedicalRecordPageState createState() => MedicalRecordPageState();
}

class MedicalRecordPageState extends State<MedicalRecordPage>  {

  void initialization() async {
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return ScreenUtilInit(
              designSize: orientation == Orientation.portrait ? const Size(392.0, 803.0)
                  : const Size(803.0, 392.0),
              minTextAdapt: false,
              splitScreenMode: false,
              builder: (_,child) {
                return GetMaterialApp(
                  title: Consts.S_APP_TITLE,
                  translations: Messages(),
                  locale: const Locale('es','ES'),
                  builder: EasyLoading.init(
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                          child: child ?? Container(),
                        );
                      }),
                  navigatorKey: Consts.navState,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    dividerColor: Colors.transparent,
                    appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                    ),
                    primaryColor: const Color(Consts.C_PRIMARYCOLOR),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    platform: TargetPlatform.iOS,
                    textTheme: TextTheme(
                      headline1: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800, color: const Color(Consts.C_PRIMARYCOLOR), fontFamily: FontRes.GILROYLIGHT, height: 1.36),
                      headline2: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600, color: const Color(Consts.C_SECUNDARYCOLOR), fontFamily: FontRes.GILROYLIGHT, height: 1.36),
                      headline3: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: const Color(Consts.C_SECUNDARYCOLOR), fontFamily: FontRes.GILROYLIGHT, height: 1.36),
                      headline4: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(Consts.C_SECUNDARYCOLOR), fontFamily: FontRes.GILROYLIGHT, height: 1.36),
                      bodyText1: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(Consts.C_SECUNDARYCOLOR), fontFamily: FontRes.GILROYLIGHT, height: 1.36),
                      bodyText2: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: const Color(Consts.C_SECUNDARYCOLOR), fontFamily: FontRes.GILROYLIGHT, height: 1.36),
                    ),
                  ),
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  home: child,
                );
              },
              child:const LandingPage()
          );
        }
    );
  }
}

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
    Get.put<PoliciesController>(PoliciesController());
    Get.put<InsuredsController>(InsuredsController());
    Get.put<ContractorsController>(ContractorsController());
    Get.put<VehiclesController>(VehiclesController());
    Get.put<PaymentsController>(PaymentsController());
    Get.put<ProvidersController>(ProvidersController());
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..contentPadding = EdgeInsets.zero
    ..boxShadow = <BoxShadow>[]
    ..radius = 10.0
    ..progressColor = Colors.white
  // ..backgroundColor = Colors.black.withOpacity(0.5)
    ..backgroundColor = Colors.transparent
    ..indicatorColor = const Color(Consts.C_ACCENTCOLOR)
    ..textColor = const Color(Consts.C_PRIMARYCOLOR)
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = const Color.fromRGBO(0, 0, 0, 0.6)
    ..userInteractions = false
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}