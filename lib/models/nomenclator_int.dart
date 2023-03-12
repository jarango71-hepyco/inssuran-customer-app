class INSSNomenclatorInteger {
  int id;
  String name;

  INSSNomenclatorInteger({
    required this.id,
    required this.name,
  });

  factory INSSNomenclatorInteger.fromJson(Map<String, dynamic> json) {
    return INSSNomenclatorInteger(
        id: json["id"]??0,
        name: json["name"]??"",
    );
  }

}