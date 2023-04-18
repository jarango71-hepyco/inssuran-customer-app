import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/clippath.dart';
import '../components/common_controls.dart';
import '../controllers/user.dart';
import '../models/bad_request_error.dart';
import '../models/label_function.dart';
import '../res/assets_res.dart';
import '../res/i_font_res.dart';
import '../services/app_exception.dart';
import '../utils/constants.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = Get.find<UserController>();

  late TextEditingController _Ident;
  late TextEditingController _PIN;

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  late bool _loadingOverlay;

  @override
  void initState() {
    super.initState();

    _Ident = TextEditingController(text: "");
    _PIN = TextEditingController(text: "");
    //_Ident.text = "1756251086";
    //_PIN.text = "1086";
    _loadingOverlay = false;
  }

  @override
  void dispose() {
    _Ident.dispose();
    _PIN.dispose();
    super.dispose();
  }

  _appBar(height) => PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, height),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
              color: const Color(Consts.C_WHITECOLOR),
              child: Stack(children: <Widget>[ //stack overlaps widgets
                ClipPath(
                  clipper: BarShape(true), //set our custom wave clipper
                  child:Container(
                    color: const Color(Consts.C_SHADOWCOLOR),
                    height: height + 25,
                  ),
                ),
                ClipPath(
                  clipper: BarShape(false),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    height: height + 23,
                    alignment: Alignment.center,
                    color: const Color(Consts.C_PRIMARYCOLOR),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          SizedBox(
                            width: 110,
                            height: 134,
                            child: //Image.asset(AssetsRes.LOGIN)
                            SvgPicture.asset(
                              AssetsRes.LOGIN,
                              width: 100,
                              height: 108,
                              // width: 112.14,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(Consts.S_WELCOME1, style: TextStyle(
                              fontFamily: FontRes.GILROYLIGHT,
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 20,),
                          Text(Consts.S_WELCOME2,
                            style: TextStyle(
                                fontFamily: FontRes.AVENIRHEAVY,
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          /*Text(Consts.S_WELCOME3,
                            style: TextStyle(
                              fontFamily: FontRes.AVENIRROMAN,
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 9,
                              //    fontStyle: FontStyle.italic
                            ),
                          ),*/
                          Text(Consts.S_WELCOME4,
                            style: TextStyle(
                                fontFamily: FontRes.AVENIRHEAVY,
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          //const SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ],
    ),
  );


  BorderRadius _getBorderRadius(double radius) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.zero,
      bottomRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark, // works
    ));
    return SafeArea(
      child: csLoadingOverlay(
        loading: _loadingOverlay,
        child: Scaffold(
          backgroundColor: const Color(Consts.C_WHITECOLOR),
          appBar: _appBar(340.0),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 15,),
                    csTextField(
                      label: Consts.S_IDENTIFICACION,
                      labelColor: Colors.black.withOpacity(0.45),
                      fillColor: const Color(Consts.C_FILLCOLOR),
                      borderColor: const Color(Consts.C_BORDERCOLOR),
                      controller: _Ident,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return Consts.S_REQUIRED_IDENTIFICACION;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    // PIN
                    Text(Consts.S_PIN,
                      style: TextStyle(
                          fontFamily: FontRes.GILROYLIGHT,
                          color: Colors.black.withOpacity(0.45),
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 10,),
                    PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      mainAxisAlignment: MainAxisAlignment.center,
                      obscureText: true,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                          return null;
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: _getBorderRadius(10),
                        borderWidth: 1,
                        fieldOuterPadding: const EdgeInsets.only(right: 10),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: const Color(Consts.C_FILLCOLOR),
                        inactiveFillColor: const Color(Consts.C_FILLCOLOR),
                        selectedFillColor: const Color(Consts.C_FILLCOLOR),
                        activeColor: const Color(Consts.C_BORDERCOLOR),
                        selectedColor: const Color(Consts.C_PRIMARYCOLOR),
                        inactiveColor: const Color(Consts.C_BORDERCOLOR),
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      errorAnimationController: errorController,
                      controller: _PIN,
                      keyboardType: TextInputType.number,
                      /*boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],*/
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                    const SizedBox(height: 80,),
                    csLargeButton(
                        label: Consts.S_TITLE_LOGIN,
                        width: MediaQuery.of(context).size.width - 25,
                        textColor: Colors.white.withOpacity(0.8),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _doUserLogin();
                          }
                          _doUserLogin();
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _doUserLogin() async {
    try {
      setState(() {
        _loadingOverlay = true;
      });
      await _userController.login(_Ident.text, _PIN.text);
      //await LocalStorageService.createSession();
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (ctx) => const HomePage(),
              settings: const RouteSettings(name: "HomePage")));
    } on BadRequestException catch (e) {
      BadRequestError error = BadRequestError.fromJson(
          json.decode(e.message));
      _formKey.currentState!.validate();
    } on HasNoPartnerException {
      csDialog(context: context, text: Consts.ERROR_HASTNOPARTNER_MSG,
          buttons: [
            LabelFunction(Consts.LINK_OK, () {
              Navigator.of(context).pop();
            }),
          ]
      );
    } on FetchDataException {
      csDialog(context: context, text: Consts.ERROR_MSG_FETCH_DATA_EXCEPTION,
          buttons: [
            LabelFunction(Consts.LINK_OK, () {
              Navigator.of(context).pop();
            }),
          ]
      );
    } on Exception {
      csDialog(
          context: context, text: Consts.ERROR_LOGIN_MSG,
          buttons: [
            LabelFunction(Consts.LINK_OK, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      setState(() {
        _loadingOverlay = false;
      });
      _userController.loadingLoginUser.value = false;
    }
  }

}



