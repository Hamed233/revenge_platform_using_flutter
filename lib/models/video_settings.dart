import 'package:firebase_auth/firebase_auth.dart';

class VideoSettings {
  bool closeComments = false;
  bool closeFeedback = false;
  bool suitableForChildren = true;

  VideoSettings({
     this.closeComments = false,
     this.closeFeedback= false,
     this.suitableForChildren = true,
  });

  VideoSettings.fromJson(Map<String, dynamic> json) {
    closeComments = json['closeComments']??false;
    closeFeedback = json['closeFeedback']??false;
    suitableForChildren = json['suitableForChildren']??true;
  }

  Map<String, dynamic> toMap() {
    return {
      'closeComments' : closeComments,
      'closeFeedback' : closeFeedback,
      'suitableForChildren' : suitableForChildren,
    };
  }
}