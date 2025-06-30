import 'dart:convert';

List<MemberModel> memberModelFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((value) => MemberModel.fromJson(value)));

class MemberModel {
  int? memberId;
  String? name;
  String? email;
  String? phone;
  String? address;

  MemberModel({
    this.memberId,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_id'] = memberId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
