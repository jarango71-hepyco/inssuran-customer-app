import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../utils/constants.dart';
import '../models/label_function.dart';
import '../../res/i_font_res.dart';

csBaseLayout({required Widget appbar, required Widget body}) {
  return Column(
    children: [
      appbar,
      Expanded(
        child: body,
      ),
    ],
  );
}

csAppBar(
    {
      required BuildContext context,
      required String title,
      required double height,
      double textBoxWidth =  300,
      double textBoxHeight =  99,
      bool showLogo = false,
      bool showBack = true,
      bool showDrawer = false,
      IconData? icon,
      Widget? badget,
      Widget? filter,
      String? iconText,
      int badgeCount = 0,
      double logoHeight = 124,
      double logoWidth = 150,
      String logoName = "",
      //String logoName = Consts.S_IMG_LOGO,
      Function()? onPressedDrawer,
      Function()? onPressedIcon,
    }) {

  bool showIcon = icon != null || filter != null;

  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, height),
    child: SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          if (showLogo)
            Positioned(
              top: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: csLogo(context, width: logoWidth, height: logoHeight, logoName: logoName),
                ),
              ),
            ),
          Positioned(
            top: showLogo?logoHeight+28:30,
            left: 62.0,
            right: 62.0,
            child: Center(
              child: SizedBox(
                width: textBoxWidth,
                height: textBoxHeight,
                child: Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: FontRes.GILROYLIGHT,
                      color: Color(Consts.C_SECUNDARYCOLOR),
                      fontSize: 24,
                      height: 1.12,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
          if (showDrawer)
            Positioned(
              top: 15,
              left: 8.0,
              child: csDrawerButton(onPressedDrawer),
            ),
          if (showBack && !showDrawer)
            Positioned(
              top: 15,
              left: 8.0,
              child: csBackButton(context),
            ),
          if (showIcon)
            Positioned(
              top: 15,
              right: 10.0,
              child: icon!=null ? csIconButton(icon, 24, onPressedIcon) : filter!,
            ),
          if (iconText != null)
            Positioned(
              top: 34,
              right: 2.0,
              child: TextButton(
                child: const Text(Consts.S_BTN_HELP,
                  style: TextStyle(
                      fontFamily: FontRes.GILROYLIGHT,
                      color: Color(Consts.C_PRIMARYCOLOR),
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                onPressed: () {
                  if (onPressedIcon != null) {
                    onPressedIcon();
                  }
                },
              ),
            ),
          if (showIcon && badget != null && badgeCount > 0)
            Positioned(
              top: 16,
              right: 16.0,
              child: badget,
            ),
        ],
      ),
    ),
  );
}

csAppBarColumn(
    {
      required BuildContext context,
      required String title,
      double textBoxWidth =  300,
      double textBoxHeight =  99,
      bool showLogo = false,
      bool showBack = true,
      bool showDrawer = false,
      IconData? icon,
      Widget? badget,
      Widget? filter,
      String? iconText,
      int badgeCount = 0,
      double logoHeight = 124,
      double logoWidth = 150,
      String logoName = "",
      ///String logoName = Consts.S_IMG_LOGO,
      GlobalKey? drawerKey,
      GlobalKey? iconKey,
      Function()? onPressedDrawer,
      Function()? onPressedIcon,
    }) {
  bool showIcon = icon != null || filter != null;
  return RPadding(
    padding: const EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 12),
    child: Stack(
      children: [
        if (showDrawer)
          Container(
            key: drawerKey,
            padding: EdgeInsets.zero,
            child: csDrawerButton(onPressedDrawer),
          ),
        if (showBack && !showDrawer)
          RPadding(
            padding: const EdgeInsets.only(top: 0),
            child: csBackButton(context),
          ),
        Container(
          // color: Colors.orange.withOpacity(0.5),
          margin: const EdgeInsets.symmetric(horizontal: 70).r,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 12).r,
                  child: Column(
                    children: [
                      if (showLogo)
                        RPadding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: RSizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: csLogo(context, width: logoWidth, height: logoHeight, logoName: logoName),
                            ),
                          ),
                        ),
                      Center(
                        child: RSizedBox(
                          width: textBoxWidth,
                          // height: textBoxHeight,
                          child: Text(title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1!.copyWith(height: 1.12,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // if (showIcon && badget != null && badgeCount > 0)

            ],
          ),
        ),
        Positioned(
          right: 4.r,
          top: 0,
          child: Column(
            children: [
              if (showIcon)
                Stack(
                  children: [
                    Container(
                      key: iconKey,
                      padding: EdgeInsets.zero,
                      child: icon!=null ? csIconButton(icon, 24, onPressedIcon) : filter!,
                    ),
                    if (badget != null && badgeCount > 0)
                      Positioned(
                        top: 2.r,
                        right: 4.r,
                        child: badget,
                      ),
                  ],
                ),
              if (iconText != null)
                RPadding(
                  padding: const EdgeInsets.only(top: 2),
                  child: TextButton(
                    child: Text(Consts.S_BTN_HELP,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                    ),
                    onPressed: () {
                      if (onPressedIcon != null) {
                        onPressedIcon();
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget csBackButton(BuildContext context) {
  return
    TextButton(
      child: Text(Consts.S_BTN_BACK,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
}

Widget csDrawerButton(Function()? onPressed) {
  return IconButton(
    icon: Icon(
        FlutterRemix.menu_fill,
        size: 24.r,
        color: const Color(Consts.C_PRIMARYCOLOR)
    ),
    onPressed: onPressed,
  );
}

csAppBarCenter({
  required BuildContext context,
  required double height,
  required String title,
  double textBoxWidth =  300,}) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, height),
    child: Center(
      child: SizedBox(
        height: height,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              csBackButton(context),
              Expanded(
                child: SizedBox(
                  width: textBoxWidth,
                  // height: textBoxHeight,
                  child: Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        color: Color(Consts.C_SECUNDARYCOLOR),
                        fontSize: 24,
                        height: 1.12,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget csIconButton(IconData icon, double size, Function()? onPressed) {
  return IconButton(
    icon: Icon(
        icon,
        size: size.r,
        color: const Color(Consts.C_PRIMARYCOLOR)
    ),
    onPressed: onPressed,
  );
}

Widget csTextButton(
    {required String text, required Color color, required Function()? onPressed, EdgeInsets padding = EdgeInsets.zero}) {
  return TextButton(
    style: TextButton.styleFrom(
      minimumSize: Size.zero,
      padding: padding,
    ),
    child: Text(text,
      style: TextStyle(
          fontFamily: FontRes.GILROYLIGHT,
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.normal),
    ),
    onPressed: onPressed,
  );
}

Widget csBadge(int value) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: const Color(Consts.C_BADGECOLOR),
      borderRadius: BorderRadius.circular(8),
    ),
    constraints: const BoxConstraints(
      minWidth: 18,
      minHeight: 18,
    ),
    child: Text('$value',
      style: const TextStyle(
        color: Color(Consts.C_WHITECOLOR),
        fontWeight: FontWeight.w400,
        fontSize: 11,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget csLogo(BuildContext context, {double width = 252, double height = 60, String logoName = ""}) {
  return csSvgBox(
    context: context,
    width: width.r,
    height: height.r,
    svg: logoName,
    //color: const Color(Consts.C_LOGOCOLOR),
  );
}

Widget csSvgBox(
    {
      required BuildContext context,
      required String svg,
      required double width,
      required double height,
      Color? color,
    })
{
  return SizedBox(
    width: width,
    height: height,
    child: csSvg(
      context: context,
      svg: svg,
      color: color,
    ),
  );
}

Widget csSvg(    {
  required BuildContext context,
  required String svg,
  Color? color,
})
{
  return SvgPicture.asset(Consts.S_IMG_PATH + svg,
    color: color,
    placeholderBuilder: (context) =>
    const Center(
        child: CircularProgressIndicator(
          backgroundColor: Color(Consts.C_PRIMARYCOLOR),
          valueColor: AlwaysStoppedAnimation<Color>(
              Color(Consts.C_WHITECOLOR)),
        )
    ),
  );
}

Widget csTextField(
    {
      Key? key,
      required String label,
      TextEditingController? controller,
      FocusNode? focusNode,
      String? initialValue,
      bool readOnly = false,
      bool labelInside = false,
      bool obscureText = false,
      double radius = 10,
      int? maxLength,
      TextOverflow? overflow,
      IconData? prefixIcon,
      IconData? suffixIcon,
      Widget? prefixWidget,
      Widget? suffixWidget,
      Color fillColor = const Color(Consts.C_GRAYCOLOR),
      Color borderColor = const Color(Consts.C_BORDERCOLOR),
      Color labelColor = const Color(Consts.C_LABELCOLOR),
      Color textColor = const Color(Consts.C_BLACKCOLOR),
      Color errorColor = const Color(Consts.C_ERRORTEXTCOLOR),
      Color iconColor = const Color(Consts.C_BLACKCOLOR),
      double iconSize =  24,
      double textFontSize = 14,
      double anglePrefixIcon = 0,
      double angleSuffixIcon = 0,
      TextAlign textAlign = TextAlign.start,
      TextInputType keyboardType = TextInputType.text,
      autovalidateMode: AutovalidateMode.always,
      EdgeInsetsGeometry? contentPadding,
      void Function()? onPressedPrefixIcon,
      void Function()? onPressedSuffixIcon,
      void Function(String)? onChanged,
      String? Function(String?)? validator,
      int? maxLines = 1,
      TextInputAction? textInputAction,
      bool? autofocus,
      List<TextInputFormatter>? textInputFormatters,
    })
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!labelInside)
        ...[
          Text(label,
            style: Theme.of(Consts.navState.currentContext!).textTheme.bodyText1!.copyWith(color: labelColor),
          ),
          SizedBox(
            height: 4.r,
          ),
        ],
      TextFormField(
        key: key,
        autofocus: autofocus??false,
        controller: controller,
        focusNode: focusNode,
        initialValue: initialValue,
        readOnly: readOnly,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        autovalidateMode: autovalidateMode,
        cursorColor: const Color(Consts.C_BLACKCOLOR),
        textAlign: textAlign,
        maxLines: maxLines,
        obscureText: obscureText,
        maxLength: maxLength,
        inputFormatters: textInputFormatters,
        style: TextStyle(
          fontFamily: FontRes.GILROYLIGHT,
          color: textColor,
          fontSize: textFontSize,
          fontWeight: FontWeight.normal,
          overflow: overflow,
        ),
        decoration: InputDecoration(
          contentPadding: contentPadding,
          isDense: true,
          filled: true,
          fillColor: fillColor,
          labelText: labelInside?label:null,
          labelStyle: labelInside?
          Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(
            color: labelColor, overflow: overflow,
          ):null,
          errorStyle: Theme.of(Consts.navState.currentContext!).textTheme.bodyText1!.copyWith(color: errorColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: _getBorderRadius(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: _getBorderRadius(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
            borderRadius: _getBorderRadius(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: _getBorderRadius(10),
          ),
          prefixIcon: prefixIcon != null?
          Transform.rotate(
            angle: anglePrefixIcon * pi/180, //set the angel
            child: IconButton(
                icon: Icon(
                  prefixIcon,
                  size: iconSize.r,
                  color: iconColor,
                ),
                onPressed: onPressedPrefixIcon
            ),
          ): (prefixWidget != null) ? prefixWidget : null,
          suffixIcon: suffixIcon != null?
          Transform.rotate(
            angle: angleSuffixIcon * pi/180, //set the angel
            child: IconButton(
                icon: Icon(
                  suffixIcon,
                  size: iconSize,
                  color: iconColor,
                ),
                onPressed: onPressedSuffixIcon
            ),
          ):(suffixWidget != null) ? suffixWidget : null,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          counterText: "",
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    ],
  );
}

Widget csDropdownButton(
    {
      required String label,
      required List<String> items,
      bool labelInside = false,
      double radius = 8,
      int? maxLength,
      IconData? prefixIcon,
      IconData? suffixIcon,
      Color fillColor = const Color(Consts.C_GRAYCOLOR),
      Color borderColor = const Color(Consts.C_BORDERCOLOR),
      Color labelColor = const Color(Consts.C_LABELCOLOR),
      Color textColor = const Color(Consts.C_BLACKCOLOR),
      Color errorColor = const Color(Consts.C_ERRORTEXTCOLOR),
      Color iconColor = const Color(Consts.C_BLACKCOLOR),
      double textFontSize = 14,
      double anglePrefixIcon = 0,
      double angleSuffixIcon = 0,
      TextInputType keyboardType = TextInputType.text,
      EdgeInsetsGeometry? contentPadding,
      void Function()? onPressedPrefixIcon,
      void Function()? onPressedSuffixIcon,
      void Function(String?)? onChanged,
      String? Function(String?)? validator,
      int? maxLines = 1,
      TextInputAction? textInputAction,
    })
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!labelInside)
        Text(label,
          style: TextStyle(
              fontFamily: FontRes.GILROYLIGHT,
              color: labelColor,
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
      if (!labelInside)
        const SizedBox(height: 4,),
      DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        items: items
            .map((item) =>DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        )
        ).toList(),
        //value: items[0],
        style: TextStyle(
            fontFamily: FontRes.GILROYLIGHT,
            color: textColor,
            fontSize: textFontSize,
            fontWeight: FontWeight.normal
        ),
        decoration: InputDecoration(
          contentPadding: contentPadding,
          isDense: true,
          filled: true,
          fillColor: fillColor,
          labelText: labelInside?label:'',
          labelStyle: labelInside?TextStyle(
              fontFamily: FontRes.GILROYLIGHT,
              color: labelColor,
              fontSize: 16,
              fontWeight: FontWeight.normal
          ):null,
          errorStyle: TextStyle(
            fontFamily: FontRes.GILROYLIGHT,
            color: errorColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: _getBorderRadius(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: _getBorderRadius(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: _getBorderRadius(10),
          ),
          focusedErrorBorder: InputBorder.none,
          prefixIcon: prefixIcon != null?
          Transform.rotate(
            angle: anglePrefixIcon * pi/180, //set the angel
            child: IconButton(
                icon: Icon(
                  prefixIcon,
                  size: 24,
                  color: iconColor,
                ),
                onPressed: onPressedPrefixIcon
            ),
          ):null,
          suffixIcon: suffixIcon != null?
          Transform.rotate(
            angle: angleSuffixIcon * pi/180, //set the angel
            child: IconButton(
                icon: Icon(
                  suffixIcon,
                  size: 24,
                  color: iconColor,
                ),
                onPressed: onPressedSuffixIcon
            ),
          ):null,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          counterText: "",
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    ],
  );
}

Widget csTextFieldURL(
    {
      required String label,
      required String url,
      TextEditingController? controller,
      FocusNode? focusNode,
      bool showUrl = true,
      bool readOnly = true,
      IconData? prefixIcon,
      IconData? suffixIcon,
      Color fillColor = const Color(Consts.C_GRAYCOLOR),
      Color borderColor = const Color(Consts.C_BORDERCOLOR),
      Color labelColor = const Color(Consts.C_LABELCOLOR),
      Color textColor = const Color(Consts.C_BLACKCOLOR),
      double anglePrefixIcon = 0,
      double angleSuffixIcon = 0,
      void Function()? onPressedPrefixIcon,
      void Function()? onPressedSuffixIcon,
      void Function(String)? onChanged,
      void Function()? onTap,
      String? Function(String?)? validator
    })
{
  return Stack(
    children: [
      csTextField(
        controller: controller,
        focusNode: focusNode,
        label: label,
        readOnly: readOnly,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        borderColor: borderColor,
        labelColor: labelColor,
        textColor: textColor,
        anglePrefixIcon: anglePrefixIcon,
        angleSuffixIcon: angleSuffixIcon,
        onPressedPrefixIcon: onPressedPrefixIcon,
        onPressedSuffixIcon: onPressedSuffixIcon,
        onChanged: onChanged,
        validator: validator,
      ),
      if (showUrl)
        Positioned(
          top: 34,
          left: prefixIcon != null ? 45 : 12,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: onTap,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: url,
                    style: TextStyle(
                      fontFamily: FontRes.GILROYLIGHT,
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  );
}

Widget csSearch(
    {
      required double width,
      required double height,
      bool searching = false,
      String label = "",
      TextEditingController? controller,
      FocusNode? focusNode,
      Color fillColor = const Color(Consts.C_WHITECOLOR),
      Color borderColor = const Color(Consts.C_BORDERCOLOR),
      Color labelColor = const Color(Consts.C_LABELCOLOR),
      Color textColor = const Color(Consts.C_BLACKCOLOR),
      Color shadowColor = const Color(Consts.C_SHADOWCOLOR),
      Offset shadowOffset = const Offset(0, 5),
      String? hintText,
      Color hintColor = const Color(Consts.C_TEXTCOLOR),
      void Function(String)? onChanged,
      void Function()? onPressed,
      String? Function(String?)? validator
    })
{
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: fillColor,
        borderRadius: _getBorderRadius(10),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(Consts.C_SHADOWCOLOR),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 2),
          )
        ]
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 20),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,

              cursorColor: const Color(Consts.C_BLACKCOLOR),
              style: TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal
              ),
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: const EdgeInsets.only(top: 7),
                hintText: hintText,
                hintStyle: TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    color: hintColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
                labelStyle: TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    color: labelColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                ),
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ),
        !searching? IconButton(
          icon: const Icon(
            FlutterRemix.search_line,
            semanticLabel: Consts.S_SEARCH,
            color: Color(Consts.C_PRIMARYCOLOR),
          ),
          onPressed: onPressed,
        ):
        IconButton(
          icon: const Icon(
            FlutterRemix.close_line,
            semanticLabel: Consts.S_SEARCH,
            color: Color(Consts.C_PRIMARYCOLOR),
          ),
          onPressed: onPressed,
        ),
      ],
    ),
  );
}

Widget csCircleButton(
    {
      required IconData icon,
      required void Function() onPressed,
      bool selected = false,
      double size = 72,
      double borderWidth = 1,
      double? elevation = 3,
    })
{
  Color borderColor = const Color(Consts.C_BORDERCOLOR);
  if (selected) {
    borderColor = const Color(Consts.C_SECUNDARYCOLOR);
    borderWidth++;
  }
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      primary: const Color(Consts.C_WHITECOLOR),
      elevation: elevation,
      side: BorderSide(width: borderWidth, color: borderColor),
    ),
    onPressed: onPressed,
    child: Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: size - 34,
        color: const Color(Consts.C_SECUNDARYCOLOR),
      ),
    ),
  );
}

Widget csCircleButton2(double size, IconData icon) {
  return RawMaterialButton(
    onPressed: () {},
    elevation: 3.0,
    fillColor: const Color(Consts.C_WHITECOLOR),
    padding: const EdgeInsets.all(15.0),
    shape: const CircleBorder(

    ),
    child: Icon(
      icon,
      size: size,
      color: const Color(Consts.C_SECUNDARYCOLOR),
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

Widget csLargeButton(
    {
      required String label,
      required double width,
      required void Function()? onTap,
      Color color = const Color(Consts.C_PRIMARYCOLOR),
      Color textColor = const Color(Consts.C_WHITECOLOR),
      Color? borderColor,
    })
{
  return  GestureDetector(
    onTap: onTap,
    child: Container(
      height: 52,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: borderColor != null?Border.all(
            color: borderColor,
          ):null,
          borderRadius: _getBorderRadius(10),
          boxShadow: const [
            BoxShadow(
              color: Color(Consts.C_SHADOWCOLOR),
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(2, 3),
            )
          ]
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: FontRes.GILROYLIGHT,
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}

Widget csSmallButton(
    {
      required String label,
      double width = 40,
      IconData? icon,
      bool filled = false,
      Color? fillColor,
      Color? textColor,
      Color? borderColor,
      Color? iconColor,
      double fontSize = 16,
      double height = 40,
      GlobalKey? key,
      required void Function()? onTap,
    })
{
  if (filled) {
    fillColor ??= const Color(Consts.C_PRIMARYCOLOR);
    textColor ??= const Color(Consts.C_WHITECOLOR);
    borderColor ??= const Color(Consts.C_ICONCOLOR);
    iconColor ??= const Color(Consts.C_PRIMARYCOLOR);
    borderColor = fillColor;
    iconColor = textColor;
  }
  else {
    fillColor ??= const Color(Consts.C_WHITECOLOR);
    textColor ??= const Color(Consts.C_PRIMARYCOLOR);
    borderColor ??= const Color(Consts.C_ICONCOLOR);
    iconColor ??= const Color(Consts.C_PRIMARYCOLOR);
  }
  return GestureDetector(
    onTap: onTap,
    child: Container(
      key: key,
      width: width.r,
      height: height.r,
      decoration: ShapeDecoration(
          color: filled? fillColor: const Color(Consts.C_WHITECOLOR),
          shape: RoundedRectangleBorder (
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(color: borderColor,)
          )
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              ...[
                Icon(
                  icon,
                  size: 22.r,
                  color: iconColor,
                ),
                SizedBox(width: 10.r,),
              ],
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                color: textColor,
                fontSize: fontSize.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget csSmallButtonExpanded(
    {
      required String label,
      IconData? icon,
      bool filled = false,
      Color? fillColor,
      Color? textColor,
      Color? borderColor,
      Color? iconColor,
      double fontSize = 16,
      double height = 40,
      GlobalKey? key,
      required void Function()? onTap,
    })
{
  if (filled) {
    fillColor ??= const Color(Consts.C_PRIMARYCOLOR);
    textColor ??= const Color(Consts.C_WHITECOLOR);
    borderColor ??= const Color(Consts.C_ICONCOLOR);
    iconColor ??= const Color(Consts.C_PRIMARYCOLOR);
    borderColor = fillColor;
    iconColor = textColor;
  }
  else {
    fillColor ??= const Color(Consts.C_WHITECOLOR);
    textColor ??= const Color(Consts.C_PRIMARYCOLOR);
    borderColor ??= const Color(Consts.C_ICONCOLOR);
    iconColor ??= const Color(Consts.C_PRIMARYCOLOR);
  }
  return GestureDetector(
    onTap: onTap,
    child: Container(
      key: key,
      // width: width.r,
      height: height.r,
      decoration: ShapeDecoration(
          color: filled? fillColor: const Color(Consts.C_WHITECOLOR),
          shape: RoundedRectangleBorder (
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(color: borderColor,)
          )
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              ...[
                Icon(
                  icon,
                  size: 22.r,
                  color: iconColor,
                ),
                SizedBox(width: 10.r,),
              ],
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

double textWidth(String text, TextStyle style) {
  final TextPainter textPainter  = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    maxLines: 1,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size.width + 40;
}

Widget csShipButton(
    {
      required String label,
      bool selected = false,
      required void Function()? onTap,
      IconData? icon
    })
{
  Color textColor = const Color(Consts.C_LABELCOLOR);
  Color borderColor = const Color(Consts.C_BORDERCOLOR);
  if (selected) {
    textColor = const Color(Consts.C_SECUNDARYCOLOR);
    borderColor = const Color(Consts.C_SECUNDARYCOLOR);
  }

  TextStyle style = TextStyle(
    fontFamily: FontRes.GILROYLIGHT,
    color: textColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  double width = textWidth(label, style);

  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: 40,
      decoration: ShapeDecoration(
          color: const Color(Consts.C_GRAYCOLOR),
          shape: RoundedRectangleBorder (
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(color: borderColor,)
          )
      ),
      child: Center(
        child: Wrap(
          children: [
            if(icon != null) Icon(icon, size: 18, color: textColor,),
            Text(label,
              textAlign: TextAlign.center,
              style: style,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget csDivider({required double width}) {
  return Container(
    height: 1,
    width: width.r,
    color: const Color(Consts.C_DIVIDERCOLOR),
  );
}

Future<void> csDialog({
  required BuildContext context,
  required String text,
  required List<LabelFunction> buttons,
  String? titleCheckBox,
  void Function(bool?)? onChangedCheckBox,
  bool? closedOnTouchOutside,
}) async {
  List<Widget> buttonsWidgets = <Widget>[];
  for (var i = 0; i < buttons.length; i++) {
    buttonsWidgets.add(csDivider(width: MediaQuery.of(context).size.width));
    buttonsWidgets.add(
      InkWell(
        splashColor: Colors.transparent,
        onTap: buttons[i].function,
        child: SizedBox(
          height: 44,
          child: Container(
            alignment: Alignment.center,
            child: Text(buttons[i].label, textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  color: buttons[i].color ?? const Color(Consts.C_PRIMARYCOLOR),
                  fontSize: 16,
                  height: 1.36,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  return showDialog<void>(
    barrierDismissible: closedOnTouchOutside ?? true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(

        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(Consts.C_BOTTOMSHEETBGCOLOR).withOpacity(0.95),
            ),
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 12, left: 30, right: 30),
                  child: Text(text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: FontRes.GILROYLIGHT,
                        color: Color(Consts.C_BLACKCOLOR),
                        fontSize: 14,
                        height: 1.36,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Column(
                  children: [
                    if (titleCheckBox != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(titleCheckBox,
                            style: const TextStyle(
                                fontFamily: FontRes.GILROYLIGHT,
                                color: Color(Consts.C_TEXTCOLOR),
                                fontSize: 12,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                          Checkbox(
                              value: true,
                              onChanged: onChangedCheckBox
                          ),
                        ],
                      ),
                    const SizedBox(height: 8,),
                  ],
                ),
                Column(
                  children: buttonsWidgets,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> csDialogCustom({
  required BuildContext context,
  required Widget content,
  required List<LabelFunction> buttons,
}) async {
  List<Widget> buttonsWidgets = <Widget>[];
  for (var i = 0; i < buttons.length; i++) {
    buttonsWidgets.add(csDivider(width: MediaQuery.of(context).size.width));
    buttonsWidgets.add(
      InkWell(
        splashColor: Colors.transparent,
        onTap: buttons[i].function,
        child: SizedBox(
          height: 44,
          child: Container(
            alignment: Alignment.center,
            child: Text(buttons[i].label, textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  color: buttons[i].color ?? const Color(Consts.C_PRIMARYCOLOR),
                  fontSize: 16,
                  height: 1.36,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            content: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(Consts.C_BOTTOMSHEETBGCOLOR).withOpacity(0.92),
                ),
                child: Wrap(
                  children: <Widget>[
                    content,
                    Column(
                      children: buttonsWidgets,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      );
    },
  );
}

Future<void> csBottomSheetMenu(BuildContext context, List<LabelFunction> links) {
  var linksWidgets = <Widget>[];
  for (var i = 0; i < links.length; i++) {
    linksWidgets.add(Column(children: [
      InkWell(
        splashColor: Colors.transparent,
        onTap: links[i].function,
        child: SizedBox(
          height: 56,
          child: ListTile(
            title: Text(links[i].label, textAlign: TextAlign.center, style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                color: Color(Consts.C_PRIMARYCOLOR),
                fontSize: 16,
                height: 1.36,
                fontWeight: FontWeight.w400,),
            ),
          ),
        ),
      ),
      //No mostrar el divider si es el ultimo elemento
      (i == links.length - 1) ? Container() : const Divider(thickness: 0.5, color: Color(Consts.C_BLACKCOLOR), height: 0.5,),
    ],));
  }

  return Get.bottomSheet(Wrap(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: const Color(Consts.C_BOTTOMSHEETBGCOLOR).withOpacity(0.92),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Wrap(
          children: linksWidgets,
        ),
      ),
      InkWell(
        splashColor: Colors.transparent,
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            color: const Color(Consts.C_BOTTOMSHEETBGCOLOR).withOpacity(0.92),
          ),
          margin: const EdgeInsets.all(10),
          child: const ListTile(
            title: Text(Consts.S_BTN_BACK, textAlign: TextAlign.center, style: TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                color: Color(Consts.C_TEXTCOLOR),
                fontSize: 16,
                height: 1.36,
                fontWeight: FontWeight.w400),),
          ),
        ),
      ),
    ],
  ),
      barrierColor: const Color(Consts.C_BLACKCOLOR).withOpacity(0.6)
  );
}

Widget csOnboardingCard({required SvgPicture image, required String text}) {
  return Container(
    width: 257,
    height: 298,
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: const BoxDecoration(
        color: Color(Consts.C_ONBOARDINGCARDCOLOR),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 1),
              blurRadius: 6,
              spreadRadius: 1.5
          )
        ]
    ),
    child: Column(
      children: [
        Expanded(child: image),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          height: 74,
          child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: FontRes.GILROYLIGHT,
                color: Color(Consts.C_BLACKCOLOR),
                fontSize: 16,
                height: 1.36,
                fontWeight: FontWeight.w400),),
        )
      ],
    ),
  );
}

String csObscureEmail(String email, int oscureAmount ) {
  int index = email.indexOf("@");
  if (oscureAmount > index) {
    return email.replaceRange(0, (index/2).round(), '*' * (index/2).round());
  }
  else {
    return email.replaceRange(0, oscureAmount, '*' * oscureAmount);
  }
}

Widget csLoadingOverlay({required Widget child, required bool loading, double size = 90, double offset = 0}) {
  Size screenSize = MediaQuery.of(Consts.navState.currentContext!).size;
  return WillPopScope(
    onWillPop: () async {
      return !loading;
    },
    child: Stack(
      children: [
        child,
        if (loading)
          Positioned(
              top: screenSize.height/2 - size/2 - offset,
              left: screenSize.width/2 - size/2,
              child: Container(
              width: size,
              height: size,
              //color: const Color.fromRGBO(0, 0, 0, 0.6),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.15),
                borderRadius: BorderRadius.circular(8),
              ),

              child: const Center(
                child: CircularProgressIndicator(color: Color(Consts.C_ACCENTCOLOR),),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget csLoadingOverlayScreen({required Widget child, required BuildContext context, required bool loading}) {
  Size size = MediaQuery.of(context).size;
  return WillPopScope(
    onWillPop: () async {
      return !loading;
    },
    child: Stack(
      children: [
        child,
        if (loading) Container(
          width: size.width,
          height: size.height,
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          child: const Center(
            child: CircularProgressIndicator(color: Color(Consts.C_ACCENTCOLOR),),
          ),
        ),
      ],
    ),
  );
}

Widget csImageError({required double size}) {
  return SizedBox(
    height: size,
    width: size,
    child: const Icon(
      FlutterRemix.file_damage_line, color: Color(Consts.C_TEXTCOLOR), size: 40,
    ),
  );
}

/*Future<bool?> csCallNumber(String number) async {
  return await FlutterPhoneDirectCaller.callNumber(number);
}*/

Future<bool?> csCallNumber(String phoneNumber) async {
  return await FlutterPhoneDirectCaller.callNumber(phoneNumber);
}
Future<void> csCallNumber2(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}
Future<void> csSendMail(String url) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: url,
  );
  await launch(launchUri.toString());
}


Widget csEmptyList(String title) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const Icon(
        //   FlutterRemix.brackets_line,
        //   semanticLabel: Consts.S_NOTIFICATIONS,
        //   size: 30,
        //   color: Color(Consts.C_STATUS3),
        // ),
        const SizedBox(height: 10,),
        Text(title,
          style: const TextStyle(
            fontFamily: FontRes.GILROYLIGHT,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(Consts.C_STATUS3),
          ),
        ),
      ],
    ),
  );


}