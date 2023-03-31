import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../components/common_controls.dart';
import '../../components/dropdown.dart';
import '../../models/label_function.dart';
import '../../res/i_font_res.dart';
import '../../services/app_exception.dart';
import '../../utils/constants.dart';


class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateProfileEditPage();
}

class _StateProfileEditPage extends State<ProfileEditPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _dropDownProvinceKey = GlobalKey<csDropDownFieldState>();
  final _dropDownMunicipalityKey = GlobalKey<csDropDownFieldState>();

  late TextEditingController _phone;
  late TextEditingController _email;
  late TextEditingController _address;

  List<String> _provinces = [];
  List<String> _municipalities = [];

  String? provinceId;
  String? municipalityId;

  late bool _loadingOverlay;

  @override
  void initState() {
    super.initState();

    _phone = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _address = TextEditingController(text: "");

    _loadingOverlay = false;
  }

  @override
  void dispose() {
    super.dispose();
    _phone.dispose;
    _email.dispose;
    _address.dispose;
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("editprofile".tr, textAlign: TextAlign.center,
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
    double radius = 6.0;
    double height = 100;
    double width = MediaQuery.of(context).size.width;
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

                const Center(
                  //widget.customer.name
                  child: Text("Hector Curbelo Barrio",
                    style: TextStyle(
                      fontFamily: FontRes.GILROYLIGHT,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(Consts.C_PRIMARYCOLOR),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                // Información personal
                Text("  ${"personalinformation".tr}",
                  //textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_PRIMARYCOLOR),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 15,),
                        csTextField(
                          label: "email".tr,
                          labelColor: Colors.black.withOpacity(0.45),
                          fillColor: const Color(Consts.C_FILLCOLOR),
                          borderColor: const Color(Consts.C_BORDERCOLOR),
                          controller: _email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "REQUIRED_EMAIL".tr;
                            }
                            if (!EmailValidator.validate(value!)) {
                              return "INVALID_EMAIL".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        // Phone
                        csTextField(
                          label: "phone".tr,
                          labelColor: Colors.black.withOpacity(0.45),
                          fillColor: const Color(Consts.C_FILLCOLOR),
                          borderColor: const Color(Consts.C_BORDERCOLOR),
                          controller: _phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "REQUIRED_PHONE".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        // Address
                        csTextField(
                          label: "street".tr,
                          labelColor: Colors.black.withOpacity(0.45),
                          fillColor: const Color(Consts.C_FILLCOLOR),
                          borderColor: const Color(Consts.C_BORDERCOLOR),
                          controller: _address,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "REQUIRED_ADDRESS".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        // Provinces
                        csDropDownField(
                          key: _dropDownProvinceKey,
                          label: "province".tr,
                          initialValue: "",
                          items: _provinces
                            .map((item) => DropdownItem(
                              //value: item.id,
                              //text: item.name,
                              value: "",
                              text: "",
                          )).toList(),
                          separatorItemHeight: 10,
                          onChanged: (dropdownItem) {
                            municipalityId = null;
                            _municipalities.clear();
                            //_getMunicipalities(dropdownItem.value);
                            setState(() {
                              provinceId = dropdownItem.value;
                            });
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "REQUIRED_PROVINCE".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        // Municipalities
                        csDropDownField(
                          key: _dropDownMunicipalityKey,
                          label: "city".tr,
                          initialValue: "",
                          items: _municipalities
                           .map((item) => DropdownItem(
                             value: "",
                              text: "",
                          )).toList(),
                          separatorItemHeight: 10,
                          onChanged: (dropdownItem) {
                            setState(() {
                              municipalityId = dropdownItem.value;
                            });
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "REQUIRED_MUNICIPALITY".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 60,),
                        csLargeButton(
                            label: "updateinfo".tr,
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
      //await _userController.save(_email.text, _phone.text, _address.text, ...);
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
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
      //_userController.loadingLoginUser.value = false;
    }
  }

}