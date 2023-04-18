import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../utils/constants.dart';

class PDFViewerPage extends StatefulWidget {
  PDFViewerPage({Key? key, required this.url}) : super(key: key);
  String url;

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("document".tr,
        textAlign: TextAlign.center,
        style: Theme.of(Consts.navState.currentContext!).textTheme.headline2!.copyWith(color: const Color(Consts.C_WHITECOLOR)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
        leading: IconButton(
          icon: const Icon(FlutterRemix.arrow_left_line),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildTitle(context),
        //actions: _buildActions(),
      ),

      body: SfPdfViewerTheme(
        data: SfPdfViewerThemeData(
            backgroundColor: Colors.white,
            progressBarColor: const Color(Consts.C_ACCENTCOLOR)),
            //scrollHeadStyle: const PdfScrollHeadStyle(backgroundColor: Color(Consts.C_ACCENTCOLOR))),
            child: SfPdfViewer.network(
              widget.url,
            ),
        ),
    );
  }
}