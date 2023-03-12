class INSSProviderPolicy {
  String id;
  String policy;

  INSSProviderPolicy({
    required this.id,
    required this.policy,
  });

  factory INSSProviderPolicy.fromJson(Map<String, dynamic> json) {
    return INSSProviderPolicy(
      id: json["id"]??"",
      policy: json["policy"]??"",
    );
  }

}