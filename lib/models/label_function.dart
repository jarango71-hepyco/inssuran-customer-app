import 'package:flutter/cupertino.dart';

class LabelFunction {
  String label;
  Color? color;
  VoidCallback function;

  LabelFunction(this.label, this.function, {this.color});
}