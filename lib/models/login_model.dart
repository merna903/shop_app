class LoginModel
{
  late bool status;
  String? massage;
  UserData? data;
  LoginModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    massage = json['message'];
    if(json['data']==null) {
      data = null;
    } else {
      data = UserData.fromJson(json['data']);
    }
  }
}

class UserData
{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credits;
  late String token;

  UserData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credits = json['credit'];
    token = json['token'];
  }
}