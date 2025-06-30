class ShopInfoModel {
  int? shopId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? customColor;
  String? customLogo;
  int? normalRate;
  int? specialRate;
  int? liraPrice;
  int? transportPrice;

  ShopInfoModel({
    this.shopId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.customColor,
    this.customLogo,
    this.normalRate,
    this.specialRate,
    this.liraPrice,
    this.transportPrice,
  });

  ShopInfoModel.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    customColor = json['custom_color'];
    customLogo = json['custom_logo'];
    normalRate = json['normal_rate'];
    specialRate = json['special_rate'];
    liraPrice = json['lira_price'];
    transportPrice = json['transport_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shop_id'] = shopId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['address'] = address;
    data['custom_color'] = customColor;
    data['custom_logo'] = customLogo;
    data['normal_rate'] = normalRate;
    data['special_rate'] = specialRate;
    data['lira_price'] = liraPrice;
    data['transport_price'] = transportPrice;
    return data;
  }
}
