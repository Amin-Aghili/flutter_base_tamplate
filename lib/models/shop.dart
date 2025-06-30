import 'dart:ui';

class Member {
  int? memberId;
  String? name;
  String? email;
  String? phone;
  String? address;

  Member({
    this.memberId,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  Member.fromJson(Map<String, dynamic> json) {
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

class Todo {
  final String? svgSrc;
  final String? title;
  final Color? color;
  final String? numOfTodo;
  final String? fieldName;

  Todo({
    this.svgSrc,
    this.title,
    this.color,
    this.numOfTodo,
    this.fieldName,
  });

  // Convert from JSON to Todo
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      svgSrc: json['svgSrc'],
      title: json['title'],
      color: ColorConverter.fromJson(json['color']),
      numOfTodo: json['numOfTodo'],
      fieldName: json['fieldName'],
    );
  }

  // Convert from Todo to JSON
  Map<String, dynamic> toJson() {
    return {
      'svgSrc': svgSrc,
      'title': title,
      'color': ColorConverter.toJson(color),
      'numOfTodo': numOfTodo,
      'fieldName': fieldName,
    };
  }
}

class ColorConverter {
  static Color? fromJson(String? json) {
    if (json == null) return null;
    return Color(int.parse(json.replaceFirst('#', '0xFF')));
  }

  static String? toJson(Color? color) {
    if (color == null) return null;
    return '#'
            '${color.a.toInt().toRadixString(16).padLeft(2, '0')}'
            '${color.r.toInt().toRadixString(16).padLeft(2, '0')}'
            '${color.g.toInt().toRadixString(16).padLeft(2, '0')}'
            '${color.b.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}

enum ShippingSteps {
  paymentConfirmation,
  orderPlacement,
  receiving,
  shipping,
  iranPost;
}
