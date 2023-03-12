
import 'nomenclator_string.dart';

class INSSVehicle {
  String id;
  String brand;
  String model;
  int year;
  String color;
  String plate;
  String version;
  INSSNomenclatorString owner;
  double prima;
  bool is_active;

  INSSVehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.plate,
    required this.version,
    required this.owner,
    required this.prima,
    required this.is_active,
  });

  factory INSSVehicle.fromJson(Map<String, dynamic> json) {
    return INSSVehicle(
      id: json["id"]??"",
      brand: json["brand"]??"",
      model: json["model"]??"",
      year: json["year"]??0,
      color: json["color"]??"",
      plate: json["plate"]??"",
      version: json["version"]??"",
      owner: INSSNomenclatorString.fromJson(json["owner"]),
      prima: json["prima"]??0.0,
      is_active: json["is_active"]??false,
    );
  }

}