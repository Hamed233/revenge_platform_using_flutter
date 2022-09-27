class OpinionsModel {
  String? opinionId;
  String? ownerId;
  String? postId;
  String? opinion;
  String? userName;
  String? profilePic;

  OpinionsModel({
    this.opinionId,
    this.ownerId,
    this.postId,
    this.opinion,
    this.userName,
    this.profilePic,
  });

  OpinionsModel.fromJson(Map<String, dynamic> data) {
    opinionId = data['opinionId'];
    ownerId = data['ownerId'];
    postId = data['postId'];
    opinion = data['opinion'];
    userName = data['userName'];
    profilePic = data['profilePic'];
  }

}