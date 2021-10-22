class BmobUser {
  String? userName;
  String? password;
  String? name;
  String? objectId;
  String? email;
  String? sessionToken;

  BmobUser({
    this.userName,
    this.password,
    this.name,
    this.objectId,
    this.email,
    this.sessionToken,
  });

  factory BmobUser.fromJson(Map<String, dynamic> json, {String? password}) {
    return BmobUser(
      userName: json['username'],
      email: json['email'],
      name: json['name'],
      objectId: json['objectId'],
      sessionToken: json['sessionToken'],
      password: password,
    );
  }

  Map<String, dynamic> toJson() => {
        "username": userName,
        "name": name,
        "password": password,
        "email": email,
        "objectId": objectId,
        "sessionToken": sessionToken,
      };

  Map<String, dynamic> toLogin() => {
        "username": userName,
        "password": password,
      };

  Map<String, dynamic> toRegister() => {
        "username": userName,
        "password": password,
        "name": name,
        "email": email,
      };

  Map<String, dynamic> toChange() => {
        "password": password,
        "email": email,
        "name": name,
      };
}
