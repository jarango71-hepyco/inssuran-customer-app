class INSSCoverage {
  String id;
  String coverage_type;
  String coverage;
  double amount_limit;
  double amount_percentage;
  String coverage_type_name;

  INSSCoverage({
    required this.id,
    required this.coverage_type,
    required this.coverage,
    required this.amount_limit,
    required this.amount_percentage,
    required this.coverage_type_name,
  });

  factory INSSCoverage.fromJson(Map<String, dynamic> json) {
    return INSSCoverage(
      id: json["id"]??"",
      coverage_type: json["coverage_type"]??"",
      coverage: json["coverage"]??"",
      amount_limit: json["amount_limit"]??0.00,
      amount_percentage: json["amount_percentage"]??0.00,
      coverage_type_name: json["coverage_type_name"]??"",
    );
  }
}