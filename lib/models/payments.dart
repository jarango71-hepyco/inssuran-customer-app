
class INSSPayment {
  String id;
  String policy;
  String policy_policy_number;
  String policy_provider;
  String policy_branch;
  String policy_contractor;
  String contractor;
  String payment_date;
  String payment_method_name;
  bool is_paid;
  String invoice_number;
  String state;
  String state_name;

  INSSPayment({
    required this.id,
    required this.policy,
    required this.policy_policy_number,
    required this.contractor,
    required this.payment_date,
    required this.payment_method_name,
    required this.is_paid,
    required this.invoice_number,
    required this.state,
    required this.state_name,
    required this.policy_provider,
    required this.policy_branch,
    required this.policy_contractor,
  });

  factory INSSPayment.fromJson(Map<String, dynamic> json) {
    return INSSPayment(
      id: json["id"]??"",
      policy_policy_number: json["policy_policy_number"]??"",
      policy: json["policy"]??"",
      contractor: json["contractor"]??"",
      payment_date: json["payment_date"]??"",
      payment_method_name: json["payment_method_name"]??"",
      is_paid: json["is_paid"]??false,
      invoice_number: json["invoice_number"]??"",
      state: json["state"]??"",
      state_name: json["state_name"]??"",
      policy_provider: json["policy_provider"]??"",
      policy_branch: json["policy_branch"]??"",
      policy_contractor: json["policy_contractor"]??"",
    );
  }

}