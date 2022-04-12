class ConnectModel {

  String? LawyerID;
  String? userID;


  ConnectModel({ this.LawyerID, this.userID});

  ConnectModel.fromJson(Map<String, dynamic> json) {
    LawyerID = json['LawyerID'];
    userID = json['userID'];

  }

  Map<String, dynamic> toMap() {
    return {
      'LawyerID': LawyerID,
      'userID': userID,

    };
  }
}
