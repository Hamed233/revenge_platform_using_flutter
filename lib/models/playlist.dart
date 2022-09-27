
class Playlist {
  String? userId;
  String? title;
  String? description;
  String? datetime;

  Playlist({
     this.userId,
     this.title,
     this.description,
     this.datetime,
  });

  Playlist.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    datetime = json['datetime'].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'userId' : userId,
      'title' : title,
      'description' : description,
      'datetime' : datetime,
    };
  }
}