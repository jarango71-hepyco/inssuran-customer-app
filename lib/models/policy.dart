import 'files.dart';

class INSSPolicy {
  String id;
  String policy_number;
  String policy_name;
  String date_start;
  String date_end;
  String policy_type_name;
  String branch;
  String branch_name;
  String provider;
  String provider_name;
  int provider_office;
  String amount;
  String certificate_number;
  int payment_day;
  String payment_frequency;
  String deductible;
  String contractor_name;
  bool is_insured;
  int notification_limit;
  String net_grant;
  String total_grant;
  double commission;
  String condition;
  String condition_deductible;
  String state;
  List<INSSFile> files;

  INSSPolicy({
    required this.id,
    required this.policy_number,
    required this.policy_name,
    required this.date_start,
    required this.date_end,
    required this.policy_type_name,
    required this.branch,
    required this.branch_name,
    required this.provider,
    required this.provider_name,
    required this.provider_office,
    required this.amount,
    required this.certificate_number,
    required this.payment_day,
    required this.payment_frequency,
    required this.deductible,
    required this.contractor_name,
    required this.is_insured,
    required this.notification_limit,
    required this.net_grant,
    required this.total_grant,
    required this.commission,
    required this.condition,
    required this.condition_deductible,
    required this.state,
    required this.files
  });

  factory INSSPolicy.fromJson(Map<String, dynamic> json) {
    return INSSPolicy(
      id: json["id"]??"",
      policy_number: json["policy_number"]??"",
      policy_name: json["policy_name"]??"",
      date_start: json["date_start"]??"",
      date_end: json["date_end"]??"",
      policy_type_name: json["policy_type_name"]??0,
      branch: json["branch"]??0,
      branch_name: json["branch_name"]??0,
      provider: json["provider"]??0,
      provider_name: json["provider_name"]??"",
      provider_office: json["provider_office"]??0,
      amount: json["amount"]??"",
      certificate_number: json["certificate_number"]??"",
      payment_day: json["payment_day"]??0,
      payment_frequency: json["payment_frequency"]??"",
      deductible: json["deductible"]??"",
      contractor_name: json["contractor_name"]??"",
      is_insured: json["is_insured"]??false,
      notification_limit: json["notification_limit"]??0,
      net_grant: json["net_grant"]??"",
      total_grant: json["total_grant"]??"",
      commission: json["commission"]??0.0,
      condition: json["condition"]??"",
      condition_deductible: json["condition_deductible"]??"",
      state: json["state"]??"",
      files: List<INSSFile>.from(json["files"].map((po) => INSSFile.fromJson(po))),
    );
  }

  factory INSSPolicy.from(INSSPolicy other) {
    return INSSPolicy(
      id: other.id,
      policy_number: other.policy_number,
      policy_name: other.policy_name,
      date_start: other.date_start,
      date_end: other.date_end,
      policy_type_name: other.policy_type_name,
      branch: other.branch,
      branch_name: other.branch_name,
      provider: other.provider,
      provider_name: other.provider_name,
      provider_office: other.provider_office,
      amount: other.amount,
      certificate_number: other.certificate_number,
      payment_day: other.payment_day,
      payment_frequency: other.payment_frequency,
      deductible: other.deductible,
      contractor_name: other.contractor_name,
      is_insured: other.is_insured,
      notification_limit: other.notification_limit,
      net_grant: other.net_grant,
      total_grant: other.total_grant,
      commission: other.commission,
      condition: other.condition,
      condition_deductible: other.condition_deductible,
      state: other.state,
      files: other.files
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id??"",
    "policy_number": policy_number??"",
    "policy_name": policy_name??"",
    "date_start": date_start??"",
    "date_end": date_end??"",
    "policy_type": policy_type_name??0,
    "branch": branch??0,
    "provider": provider??0,
    "provider_name": provider_name??"",
    "provider_office": provider_office??0,
    "amount": amount??"",
    "certificate_number": certificate_number??"",
    "payment_day": payment_day??0,
    "payment_frequency": payment_frequency??"",
    "deductible": deductible??"",
    //"contractor": contractor??"",
    "contractor_name": contractor_name??"",
    "is_insured": is_insured??false,
    "notification_limit": notification_limit??0,
    "net_grant": net_grant??"",
    "total_grant": total_grant??"",
    "commission": commission??0,
    "condition": condition??"",
    "condition_deductible": condition_deductible??"",
    "state": state??"",
  };
}