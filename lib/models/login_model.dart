import 'package:shop_app/Screens/login/cubit_login.dart';

class ShoploginModel {
  bool? status;
  String? Message;
  userData? data;
  ShoploginModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    Message = json['message'];
    data = (json['data']!= null) ? userData.fromJson(json['data']): null;
  }
}

class userData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? Point;
  int? credit;
  String? token;
  userData({
    this.token,
    this.email,
    this.image,
    this.credit,
    this.id,
    this.name,
    this.phone,
    this.Point,
  });
  userData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
    credit = json['credit'];
    phone = json['phone'];
    Point = json['Point'];

  }
}
