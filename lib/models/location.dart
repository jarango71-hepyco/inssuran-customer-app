class INSSLocation {
  int id;
  String name;

  INSSLocation({
    required this.id,
    required this.name,
  });

  factory INSSLocation.fromJson(Map<String, dynamic> json) {
    return INSSLocation(
        id: json["id"]??0,
        name: json["name"]??"",
    );
  }

}