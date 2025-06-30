import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(
    json.decode(str).map((value) => OrderModel.fromJson(value)));

class OrderModel {
  int? orderId;
  int? orderDetailId;
  String? memberName;
  String? productName;
  int? price;
  int? quantity;
  String? packageNumber;
  int? weight;
  String? description;
  String? size;
  String? color;
  String? productImage;
  String? createdAt;
  String? updatedAt;
  String? productUrl;

  OrderModel({
    this.orderId,
    this.orderDetailId,
    this.memberName,
    this.productName,
    this.price,
    this.quantity,
    this.packageNumber,
    this.weight,
    this.description,
    this.size,
    this.color,
    this.productImage,
    this.createdAt,
    this.updatedAt,
    this.productUrl,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderDetailId = json['order_detail_id'];
    memberName = json['member_name'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    packageNumber = json['package_number'];
    weight = json['weight'];
    description = json['description'];
    size = json['size'];
    color = json['color'];
    productImage = json['product_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productUrl = json['product_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_detail_id'] = orderDetailId;
    data['member_name'] = memberName;
    data['product_name'] = productName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['package_number'] = packageNumber;
    data['weight'] = weight;
    data['description'] = description;
    data['size'] = size;
    data['color'] = color;
    data['product_image'] = productImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_url'] = productUrl;
    return data;
  }
}
