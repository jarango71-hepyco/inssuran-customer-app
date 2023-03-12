class INSSNomenclatorString {
  String id;
  String name;

  INSSNomenclatorString({
    required this.id,
    required this.name,
  });

  factory INSSNomenclatorString.fromJson(Map<String, dynamic> json) {
    return INSSNomenclatorString(
      id: json["id"]??"",
      name: json["name"]??"",
    );
  }

}