class INSSPlace {
  int id;
  String name;
  String code;
  int parent;

  INSSPlace({
    required this.id,
    required this.name,
    required this.code,
    required this.parent,
  });

  factory INSSPlace.fromJson(Map<String, dynamic> json) {
    return INSSPlace(
      id: json["id"]??0,
      name: json["name"]??"",
      code: json["code"]??"",
      parent: json["parent"]??"",
    );
  }

}