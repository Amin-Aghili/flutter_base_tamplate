import 'dart:convert';

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(
    json.decode(str).map((value) => PaymentModel.fromJson(value)));

class PaymentModel {
  int? paymentId;
  int? orderId;
  String? name;
  int? amount;
  String? referenceCode;
  int? isValid;

  PaymentModel(
      {this.paymentId,
      this.orderId,
      this.name,
      this.amount,
      this.referenceCode,
      this.isValid});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    orderId = json['order_id'];
    name = json['name'];
    amount = json['amount'];
    referenceCode = json['reference_code'];
    isValid = json['isValid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['order_id'] = orderId;
    data['name'] = name;
    data['amount'] = amount;
    data['reference_code'] = referenceCode;
    data['isValid'] = isValid;
    return data;
  }
}
