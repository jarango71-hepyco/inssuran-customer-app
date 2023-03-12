class INSSProviderOffice {
  String id;
  int office;

  INSSProviderOffice({
    required this.id,
    required this.office,
  });

  factory INSSProviderOffice.fromJson(Map<String, dynamic> json) {
    return INSSProviderOffice(
      id: json["id"]??"",
      office: json["office"]??0,
    );
  }

}