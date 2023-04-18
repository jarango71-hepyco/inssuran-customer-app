import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:inssurancustomer/pages/home/pdfviewer.dart';
import '../../models/policy.dart';
import '../../utils/constants.dart';


class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key, required this.policy}) : super(key: key);
  final INSSPolicy? policy;

  @override
  State<StatefulWidget> createState() => _StateDocumentsPage();
}

class _StateDocumentsPage extends State<DocumentsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: _getBorderRadius(10),
                  ),
                  color: Colors.white,
                  elevation: 2,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*const SizedBox(height: 5,),
                      ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(widget.policy.files[0].name,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(height: 8,),*/
                      _listDocuments()
                    ],
                  )
              ),
            ],
          ),
        ),
    );
  }

  Widget _listDocuments() {
    return ListView.builder(
      shrinkWrap: true,
      //itemExtent: 55,
      itemCount: widget.policy!.files.length,
      itemBuilder: (context, index) {
        return ListTile(
          //dense: true,
          minLeadingWidth: 3.0,
          visualDensity: VisualDensity.compact,
          leading: const Icon(FlutterRemix.file_pdf_line, color: Color(Consts.C_PRIMARYCOLOR), size: 20),
          title: Text(widget.policy!.files[index].name,
            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR), decoration: TextDecoration.underline),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PDFViewerPage(url: Consts.appDomain+widget.policy!.files[index].file),
            ),);
          },
        );
      },
    );
  }

  Widget _listDocuments1() {
    return ListView.builder(
      shrinkWrap: true,
      //itemExtent: 55,
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          //dense: true,
          minLeadingWidth: 3.0,
          visualDensity: VisualDensity.compact,
          leading: const Icon(FlutterRemix.file_pdf_line, color: Color(Consts.C_PRIMARYCOLOR), size: 20),
          title: Text("Documento ${index + 1}.pdf",
            style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR), decoration: TextDecoration.underline),
          ),
          onTap: () {
            /*Navigator.push(context, MaterialPageRoute(
              builder: (context) => PDFViewerPage(url: widget.policy.files[index].file),
            ),);*/
          },
        );
      },
    );
  }

}