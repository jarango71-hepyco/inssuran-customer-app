import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import '../../models/payments.dart';
import '../../res/i_font_res.dart';
import '../../utils/constants.dart';


class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({Key? key, required this.payment}) : super(key: key);
  final INSSPayment payment;

  @override
  State<StatefulWidget> createState() => _StatePaymentDetailPage();
}

class _StatePaymentDetailPage extends State<PaymentDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("walletinfo".tr,
        textAlign: TextAlign.center,
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(Consts.C_PRIMARYCOLOR),
        leading: IconButton(
          icon: const Icon(FlutterRemix.arrow_left_line),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildTitle(context),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10,),
              Center(
                child: Text(widget.payment.policy_policy_number,
                  style: const TextStyle(
                    fontFamily: FontRes.GILROYLIGHT,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(Consts.C_PRIMARYCOLOR),
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              // Información del vehiculo
              const SizedBox(height: 10,),
              Text("  ${"description".tr}",
                //textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: FontRes.GILROYLIGHT,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(Consts.C_PRIMARYCOLOR),
                ),
              ),
              const SizedBox(height: 5,),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: _getBorderRadius(10),
                  ),
                  color: Colors.white,
                  elevation: 2,
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text("contractor".tr,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(widget.payment.policy_contractor,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text("company".tr,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(widget.payment.policy_provider,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text("branch".tr,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(widget.payment.policy_branch,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text("payment-method".tr,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(widget.payment.payment_method_name,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text("paymentdate".tr,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(widget.payment.payment_date,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text("state".tr,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(widget.payment.state_name,
                          style: Theme.of(Consts.navState.currentContext!).textTheme.headline3!.copyWith(color: const Color(Consts.C_PRIMARYCOLOR)),
                        ),
                      ),

                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}