class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data= json["data"] != null? UserData.fromJson(json['data']) :null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
//
//   UserData({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.image,
//     this.points,
//     this.credit,
//     this.token
// });

  UserData.fromJson(Map<String, dynamic> json) {
      id = json["id"];
      name = json["name"];
      email= json["email"];
      phone= json["phone"];
      image= json["image"];
      points= json["points"];
      credit= json["credit"];
      token= json["token"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "phone": this.phone,
      "image": this.image,
      "points": this.points,
      "credit": this.credit,
      "token": this.token,
    };
  }


}


