class UserModel {
  final int id;
  final String? role;
  final String username;
  final String email;
  final String phone;
  final String? whatsapp;
  final String? advertiserName;
  final String? advertiserType;
  final String? advertiserLogo; // <-- حقل جديد

  UserModel({
    required this.id,
    this.role,
    required this.username,
    required this.email,
    required this.phone,
    this.whatsapp,
    this.advertiserName,
    this.advertiserType,
    this.advertiserLogo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      role: json['role'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      whatsapp: json['whatsapp'],
      advertiserName: json['advertiser_name'],
      advertiserType: json['advertiser_type'],
      advertiserLogo: json['advertiser_logo'],
    );
  }
}