class INSSCustomer {
  String id;
  String name;
  String insured_type;
  String identification_type;
  String identification;
  String legal_type;
  String pin_code;
  String birthday;
  String phone;
  String email;
  String sex_name;
  int country;
  int province;
  int city;
  String street;
  bool is_active;
  String partner;
  int age;
  String country_name;
  String province_name;
  String city_name;
  String partner_name;
  String insured_type_name;
  String legal_type_name;

  INSSCustomer({
    required this.id,
    required this.name,
    required this.insured_type,
    required this.identification_type,
    required this.identification,
    required this.legal_type,
    required this.pin_code,
    required this.birthday,
    required this.phone,
    required this.email,
    required this.sex_name,
    required this.country,
    required this.province,
    required this.city,
    required this.street,
    required this.is_active,
    required this.partner,
    required this.age,
    required this.country_name,
    required this.province_name,
    required this.city_name,
    required this.partner_name,
    required this.insured_type_name,
    required this.legal_type_name
  });

  factory INSSCustomer.fromJson(Map<String, dynamic> json) {
    return INSSCustomer(
      id: json["id"]??"",
      name: json["name"]??"",
      insured_type: json["insured_type"]??"",
      identification_type: json["identification_type"]??"",
      identification: json["identification"]??"",
      legal_type: json["legal_type"]??"",
      pin_code: json["pin_code"]??"",
      birthday: json["birthday"]??"",
      phone: json["phone"]??"",
      email: json["email"]??"",
      sex_name: json["sex_name"]??"",
      country: json["country"]??0,
      province: json["province"]??0,
      city: json["city"]??0,
      street: json["street"]??"",
      is_active: json["is_active"]??"",
      partner: json["partner"]??"",
      age: json["age"]??0,
      country_name: json["country_name"]??"",
      province_name: json["province_name"]??"",
      city_name: json["city_name"]??"",
      partner_name: json["partner_name"]??"",
      insured_type_name: json["insured_type_name"]??"",
      legal_type_name: json["legal_type_name"]??"",
    );
  }

}