import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../components/common_controls.dart';
import '../../controllers/user.dart';
import '../../models/label_function.dart';
import '../../models/user.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';


class ChangePINPage extends StatefulWidget {
  const ChangePINPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateChangePINPage();
}

class _StateChangePINPage extends State<ChangePINPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType>? errorController;

  final UserController _userController = Get.find<UserController>();
  late User? _user;

  late TextEditingController _PIN;
  late TextEditingController _newPIN;

  String currentText = "";
  bool _loadingOverlay = false;

  @override
  void initState() {
    super.initState();
    _user = _userController.user;
    _PIN = TextEditingController(text: "");
    _newPIN = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    //_PIN.dispose();
    //_newPIN.dispose();
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("changepin".tr, textAlign: TextAlign.center,
        style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
      ),
    );
  }

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
    return csLoadingOverlay(
      loading: _loadingOverlay,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
          leading: IconButton(
            icon: const Icon(FlutterRemix.arrow_left_line),
            onPressed: () => Navigator.pop(context),
          ),
          title: _buildTitle(context),
          //actions: _buildActions(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10,),

                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 15,),
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
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "pinrequired".tr;
                            }
                            if (_user!.pinCode != value) {
                              return "noeqcurrentpin".tr;
                            }
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
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
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
                        // New PIN
                        const SizedBox(height: 10,),
                        Text("newpin".tr,
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
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "newpinrequired".tr;
                            }
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
                          controller: _newPIN,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
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
                        const SizedBox(height: 60,),
                        csLargeButton(
                            label: "savechanges".tr,
                            width: MediaQuery.of(context).size.width - 25,
                            textColor: Colors.white.withOpacity(0.8),
                            onTap: () {

                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _doSave();
                              }
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    _doSave() async {
    try {
      setState(() {
        _loadingOverlay = true;
      });
      await _userController.changePIN(_PIN.text, _newPIN.text);
      if (!mounted) return;
      showSuccess(context);
    } on BadRequestException catch (e) {
      _formKey.currentState!.validate();
    } on FetchDataException {
      csDialog(context: context, text: "ERROR_MSG_FETCH_DATA_EXCEPTION".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]
      );
    } on Exception {
      csDialog(
          context: context, text: "ERROR_PROFILE_EDIT_MSG".tr,
          buttons: [
            LabelFunction("ok".tr, () {
              Navigator.of(context).pop();
            }),
          ]);
    } finally {
      setState(() {
        _loadingOverlay = false;
      });
    }
  }

  void showSuccess(BuildContext context) {
    final List<LabelFunction> buttons = [
      LabelFunction("ok".tr,  (){
        Navigator.of(context).popUntil((route) => route.isFirst);
        //Navigator.pop(context);
      },
        color: const Color(Consts.C_PRIMARYCOLOR),),
    ];

    csDialog(context: context,
        text: "savepinsuccess".tr,
        buttons: buttons
    );
  }

}