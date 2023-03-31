import 'package:flutter/cupertino.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

import '../res/i_font_res.dart';
import 'common_controls.dart';

class csDropDownField extends StatefulWidget {
  csDropDownField({Key? key, required this.label, required this.items, this.initialValue, this.fillColor,
    this.separatorItemHeight = 8, this.onChanged, this.validator}) : super(key: key);

  String label;
  List<DropdownItem> items;
  String? initialValue;
  double separatorItemHeight;
  Color? fillColor;
  String? Function(String?)? validator;
  void Function(DropdownItem)? onChanged;

  @override
  csDropDownFieldState createState() => csDropDownFieldState();
}


class csDropDownFieldState extends State<csDropDownField> {
  final _fieldKey = GlobalKey();
  late FocusNode _focusNode;
  late LayerLink _layerLink;
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;
  
  static const double paddingValue = 12.0;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _layerLink = LayerLink();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        closeMenu();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    closeMenu();
    _focusNode.dispose();
  }

  void openMenu() {
    if (!_isMenuOpen) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
      _isMenuOpen = true;
    }
  }

  void closeMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry =  null;
      _isMenuOpen = false;
    }
  }

  Size calcTextHeight(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  double _textHeight(String text, TextStyle style, double width) {
    Size size = calcTextHeight(text, style);
    int linesCount = (size.width/width).ceil();
    return size.height*linesCount + widget.separatorItemHeight*linesCount;
  }

  void clear() {
    setState(() {
      widget.initialValue = '';
    });
  }

  Widget _getList(double width, TextStyle style) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(paddingValue),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.items.length, (index) {
              return GestureDetector(
                onTap: () {
                  if (_overlayEntry != null) {
                    closeMenu();
                  }
                  //_controller.text = widget.items[index].text;
                  setState(() {
                    widget.initialValue = widget.items[index].text;
                  });
                  widget.onChanged!(widget.items[index]);
                },
                child: AbsorbPointer(
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        child: Text(widget.items[index].text,style: style),
                      ),
                      SizedBox(height: widget.separatorItemHeight,),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    var style = const TextStyle(
      fontFamily: FontRes.GILROYLIGHT,
      color: Color(Consts.C_PRIMARYCOLOR),
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );

    final renderBox = _fieldKey.currentContext?.findRenderObject() as RenderBox;
    var size = renderBox.size;
    final pos = renderBox.localToGlobal(Offset.zero);

    double computedMaxHeight = paddingValue * 2.0;
    for (var item in widget.items) {
      double itemHeight = _textHeight(item.text, style, size.width - paddingValue * 2.0);
      computedMaxHeight += itemHeight;
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double? height;
    double? bottom;
    double? left;
    double offsetY = size.height + paddingValue * 2.0;

    double availableHeightDown = screenHeight - pos.dy - size.height;
    //double availableHeightDown = screenHeight - (pos.dy + size.height + 8);
    double availableHeightUp = screenHeight - (availableHeightDown + size.height + 8);

    if (computedMaxHeight > availableHeightDown) {
      if (availableHeightUp > availableHeightDown) {
        left = pos.dx;
        if (computedMaxHeight > availableHeightUp) {
          bottom = screenHeight - pos.dy - paddingValue;
          height = availableHeightUp - size.height + paddingValue;
          offsetY = -(availableHeightUp - AppBar().preferredSize.height);
        }
        else {
          offsetY = -(computedMaxHeight - paddingValue * 2.0 + 8);
        }
      }
      else {
        height = availableHeightDown - paddingValue;
      }
    }

    return OverlayEntry(
        builder: (context) => Positioned(
          left: left,
          bottom: bottom,
          width: size.width,
          height: height,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: true,
            offset: Offset(0.0, offsetY),
            child: _getList(size.width, style)
        ),//: _getList(size.width, style)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (!_isMenuOpen) {
            openMenu();
          } else {
            closeMenu();
          }
        },
        child: Stack(
          children: [
            csTextField(
              key: _fieldKey,
              autofocus: true,
              label: widget.label,
              focusNode: _focusNode,
              fillColor: widget.fillColor ?? const Color(Consts.C_GRAYCOLOR),
              readOnly: true,
              suffixIcon: FlutterRemix.arrow_down_s_line,
              labelColor: const Color(Consts.C_TEXTCOLOR),
              //validator: widget.validator,
              onPressedSuffixIcon: () {
                if (!_isMenuOpen) {
                  openMenu();
                } else {
                  closeMenu();
                }
              },
            ),
            Positioned(
              top: 36,
              left: 12,
              right: 38,
              child: Text(widget.initialValue??'',
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  color: Color(Consts.C_BLACKCOLOR),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DropdownItem {
  String value;
  String text;

  DropdownItem(
  {
    required  this.value,
    required this.text,
  });
}