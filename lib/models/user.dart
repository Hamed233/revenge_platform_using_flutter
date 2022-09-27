class UserModel
{
  String? uId;
  String? fullName;
  String? email;
  String? emailBusiness;
  String? password;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? date;
  String? token;
  String? totalconnections = "";
  Map? connections = {};
  List? connectionRequest = [];
  List? status = [];
  List? userInterests = [];
  bool isOnline = false;
  bool isEmailVerified = false;

  UserModel({
    this.fullName,
    this.email,
    this.emailBusiness,
    this.password,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.date,
    this.token,
    this.totalconnections,
    this.connections,
    this.connectionRequest,
    this.status,
    this.userInterests,
    this.isOnline = false,
    this.isEmailVerified = false,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    emailBusiness = json['emailBusiness'];
    password = json['password'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    date = json['date'];
    token = json['token'];
    totalconnections = json['totalconnections'];
    connections = json['connections'];
    connectionRequest = json['connectionRequest'];
    status = json['status'];
    userInterests = json['userInterests'];
    isOnline = json['isOnline'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName' : fullName,
      'email' : email,
      'emailBusiness' : emailBusiness,
      'password' : password,
      'phone' : phone,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
      'uId' : uId,
      'date' : date,
      'token' : token,
      'totalconnections' : totalconnections,
      'connections' : connections,
      'connectionRequest' : connectionRequest,
      'status' : status,
      'userInterests' : userInterests,
      'isOnline' : isOnline,
      'isEmailVerified' : isEmailVerified,
    };
  }
}