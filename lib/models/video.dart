import 'package:firebase_auth/firebase_auth.dart';
import 'package:revenge_platform/models/video_settings.dart';

class Video {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? videolUrl;
  String? thumbnailUrl;
  String? duration;
  String? publishDate;
  String? publishTime;
  int? viewCount;
  int? likes;
  int? dislikes;
  int? shares;
  VideoSettings? videoSettings;

  Video({
    required this.userId,
    required this.title,
    required this.description,
    required this.videolUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.publishDate,
    required this.publishTime,
    required this.viewCount,
    required this.likes,
    required this.dislikes,
    required this.shares,
    required this.videoSettings,
  });

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    videolUrl = json['videolUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    duration = json['duration'];
    publishDate = json['publishDate'];
    publishTime = json['publishTime'];
    viewCount = json['viewCount'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    shares = json['shares'];
    videoSettings = VideoSettings.fromJson(Map<String,dynamic>.from(json["videoSettings"]));
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'userId' : userId,
      'title' : title,
      'videolUrl' : videolUrl,
      'thumbnailUrl' : thumbnailUrl,
      'duration' : duration,
      'publishDate' : publishDate,
      'publishTime' : publishTime,
      'viewCount' : viewCount,
      'likes' : likes,
      'dislikes' : dislikes,
      'shares' : shares,
      'videoSettings' : videoSettings!.toMap(),
    };
  }
}