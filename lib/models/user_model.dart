class UsersModel {
  String? userID;
  String? username;
  String? email;
  String? phone;
  bool? lawyer;
  String? category;
  String? yearsExp;
  String? dates;
  int? rate;
  String? photo;
  String? info;

  UsersModel(
      this.userID,
      this.email,
      this.username,
      this.phone,
      this.lawyer,
      this.category,
      this.yearsExp,
      this.dates,
      this.rate,
      this.photo,
      this.info);

  UsersModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    userID = json['userID'];
    phone = json['phone'];
    lawyer = json['lawyer'];
    category = json['category'];
    yearsExp = json['yearsExp'];
    dates = json['dates'];

    rate = json['rate'];
    photo = json['photo'];
    info = json['info'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'userID': userID,
      'phone': phone,
      'lawyer': lawyer,
      'category': category,
      'yearsExp': yearsExp,
      'dates': dates,
      'rate': rate,
      'photo': photo,
      'info': info,
    };
  }
}
