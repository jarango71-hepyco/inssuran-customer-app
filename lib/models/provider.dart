import 'package:inssurancustomer/models/provider_office.dart';
import 'package:inssurancustomer/models/provider_policy.dart';

class INSSProvider {
  String id;
  String name;
  String short_name;
  String ruc;
  String phone;
  String email;
  String address;
  String contact;
  List<INSSProviderOffice> provider_offices;
  List<INSSProviderPolicy> provider_policies;

  INSSProvider({
    required this.id,
    required this.name,
    required this.short_name,
    required this.ruc,
    required this.phone,
    required this.email,
    required this.address,
    required this.contact,
    required this.provider_offices,
    required this.provider_policies,
  });

  factory INSSProvider.fromJson(Map<String, dynamic> json) {
    return INSSProvider(
      id: json["id"]??"",
      name: json["name"]??"",
      short_name: json["short_name"]??"",
      ruc: json["ruc"]??"",
      phone: json["phone"]??"",
      email: json["email"]??"",
      address: json["address"]??"",
      contact: json["contact"]??"",
      provider_offices:  List<INSSProviderOffice>.from(json["provider_offices"].map((po) => INSSProviderOffice.fromJson(po))),
      provider_policies: List<INSSProviderPolicy>.from(json["provider_offices"].map((pp) => INSSProviderPolicy.fromJson(pp))),
    );
  }

}