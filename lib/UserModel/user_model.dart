class UserModel {
  String uid;
  String userName;
  String cardNo;
  String userEmail;
  String factoryName;
  String floorName;
  String password;
  String section;

  UserModel({
    required this.uid,
    required this.userName,
    required this.cardNo,
    required this.userEmail,
    required this.factoryName,
    required this.floorName,
    required this.password,
    required this.section,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "userName": userName,
        "cardNo": cardNo,
        "userEmail": userEmail,
        "factoryName": factoryName,
        "floorName": floorName,
        "password": password,
        "section" : section,
      };
}
