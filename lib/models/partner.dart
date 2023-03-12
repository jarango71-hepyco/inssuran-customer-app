class INSSPartner {
  String id;
  String name;
  String short_name;
  String identification;
  int country;
  int province;
  int city;
  String street;
  String phone;
  String business_email;
  String slogan;
  String resume;
  String logo;
  String website;
  String twitter;
  String facebook;
  String instagram;
  String tags;
  String layout;

  INSSPartner({
    required this.id,
    required this.name,
    required this.short_name,
    required this.identification,
    required this.country,
    required this.province,
    required this.city,
    required this.street,
    required this.phone,
    required this.business_email,
    required this.slogan,
    required this.resume,
    required this.logo,
    required this.website,
    required this.twitter,
    required this.facebook,
    required this.instagram,
    required this.tags,
    required this.layout
  });

  factory INSSPartner.fromJson(Map<String, dynamic> json) {
    return INSSPartner(
      id: json["id"]??"",
      name: json["name"]??"",
      short_name: json["short_name"]??"",
      identification: json["identification"]??"",
      country: json["country"]??0,
      province: json["province"]??0,
      city: json["city"]??0,
      street: json["street"]??"",
      phone: json["phone"]??"",
      business_email: json["business_email"]??"",
      slogan: json["slogan"]??"",
      resume: json["resume"]??"",
      logo: json["logo"]??"",
      website: json["website"]??"",
      twitter: json["twitter"]??"",
      facebook: json["facebook"]??"",
      instagram: json["instagram"]??"",
      tags: json["tags"]??"",
      layout: json["layout"]??"",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id??"",
    "name": name??"",
    "short_name": short_name??"",
    "identification": identification??"",
    "country": country??0,
    "province": province??0,
    "city": city??0,
    "street": street??"",
    "phone": phone??"",
    "business_email": business_email??"",
    "slogan": slogan??"",
    "resume": resume??"",
    "logo": logo??"",
    "website": website??"",
    "twitter": twitter??"",
    "facebook": facebook??"",
    "instagram": instagram??"",
    "tags": tags??"",
    "layout": layout??""
  };
}