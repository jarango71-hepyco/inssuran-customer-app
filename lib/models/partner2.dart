class INSSPartner2 {
  String name;
  String email;
  String phone;
  String logo_url;

  INSSPartner2({
    required this.name,
    required this.phone,
    required this.email,
    required this.logo_url,
  });

  factory INSSPartner2.fromJson(Map<String, dynamic> json) {
    return INSSPartner2(
      name: json["name"]??"",
      phone: json["phone"]??"",
      email: json["email"]??"",
      logo_url: json["logo_url"]??"",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name??"",
    "phone": phone??"",
    "email": email??"",
    "logo_url": logo_url??"",
  };
}