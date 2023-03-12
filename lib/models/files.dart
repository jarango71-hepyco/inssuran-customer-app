class INSSFile {
  String id;
  String name;
  String file_type;
  String file;

  INSSFile({
    required this.id,
    required this.name,
    required this.file_type,
    required this.file,
  });

  factory INSSFile.fromJson(Map<String, dynamic> json) {
    return INSSFile(
      id: json["id"]??"",
      name: json["name"]??"",
      file_type: json["file_type"]??"",
      file: json["file"]??"",
    );
  }

}