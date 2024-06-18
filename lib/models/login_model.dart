class LoginModel {
  bool? status;
  bool? privilage;
  Token? token;
  String? phone;
  String? message;

  LoginModel({this.status, this.privilage, this.token, this.phone,this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    privilage = json['privilage'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    phone = json['phone'];
    message=json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['privilage'] = privilage;
    data['message']=message;
    if (token != null) {
      data['token'] = token!.toJson();
    }
    data['phone'] = phone;
    return data;
  }
}

class Token {
  String? refresh;
  String? access;

  Token({this.refresh, this.access});

  Token.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}
