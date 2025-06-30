class AuthModel {
  final int userId;
  final int shopId;
  final String token;

  AuthModel({
    required this.userId,
    required this.shopId,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['user_id'],
      shopId: json['shop_id'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'shop_id': shopId,
      'token': token,
    };
  }
}
