class User {
  String user_id;
  String full_name;
  String email;
  bool has_partner;
  String? partner_id;
  String language;
  bool valid_subscription;
  String refresh;
  String access;

  User({
    required this.user_id,
    required this.full_name,
    required this.email,
    required this.has_partner,
    required this.partner_id,
    required this.language,
    required this.valid_subscription,
    required this.refresh,
    required this.access,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        user_id: json['user_id'],
        full_name: json['full_name'],
        email: json['email'],
        has_partner: json['has_partner'],
        partner_id: json['partner_id']??"",
        language: json['language'],
        valid_subscription: json['valid_subscription'],
        refresh: json['refresh'],
        access: json['access']
   );
  }

  Map<String, dynamic> toJson() => {
    "user_id": user_id,
    "full_name": full_name,
    "email": email,
    "has_partner": has_partner,
    "email": email,
    "partner_id": partner_id??"",
    "language": language,
    "valid_subscription": valid_subscription,
    "refresh": refresh,
    "access": access
  };
}