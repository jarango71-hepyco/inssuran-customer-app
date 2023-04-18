class User {
  String id;
  String name;
  String identification_type;
  String identification;
  String pinCode;
  String legal_type;
  String phone;
  String email;
  String street;
  String province_name;
  String city_name;
  int country;
  int province;
  int city;

  User({
    required this.id,
    required this.name,
    required this.identification_type,
    required this.identification,
    required this.pinCode,
    required this.legal_type,
    required this.phone,
    required this.email,
    required this.street,
    required this.province_name,
    required this.city_name,
    required this.country,
    required this.province,
    required this.city
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id']??"",
        name: json['name']??"",
        identification_type: json['identification_type']??"",
        identification: json['identification']??"",
        pinCode: json['pinCode']??"",
        legal_type: json['legal_type']??"",
        phone: json['phone']??"",
        email: json['email']??"",
        street: json['street']??"",
        province_name: json['province_name']??"",
        city_name: json['city_name']??"",
        country: json['country']??0,
        province: json['province']??0,
        city: json['city']??0,
   );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "identification_type": identification_type,
    "identification": identification,
    "pinCode": pinCode,
    "legal_type": legal_type,
    "phone": phone??"",
    "email": email,
    "street": street,
    "province_name": province_name,
    "city_name": city_name,
    "country": country,
    "province": province,
    "city": city
  };
}