import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:revenge_platform/models/interests.dart';

class CacheHelperKeys {
  static const themeOfAppModeKey = "isDark";
  static const userIdKey = "userId";
  static const profileVideosSortBy = "videosSortBy";
  static const onBoardingKey = "onBoarding";
}

class Resources {
  // ICON BOTTOM NAVIGATION BAR ASSETS
  static const String dashboardActive = 'assets/svg/dashboard-active.svg';
  static const String dashboardInactive = 'assets/svg/dashboard-inactive.svg';

  static const String tasksActive = 'assets/svg/tasks-active.svg';
  static const String tasksInactive = 'assets/svg/tasks-inactive.svg';
  static const String tasksWhite = 'assets/svg/tasks-white.svg';

  static const String notesActive = 'assets/svg/notes-active.svg';
  static const String notesInactive = 'assets/svg/notes-inactive.svg';
  static const String notesWhite = 'assets/svg/notes-white.svg';

  static const String bagActive = 'assets/svg/bag_active.svg';
  static const String bagInactive = 'assets/svg/bag_inactive.svg';

  static const String calendarActive = 'assets/svg/calendar_active.svg';
  static const String calendarInactive = 'assets/svg/calendar_inactive.svg';

  static const String projectsActive = 'assets/svg/projects_active.svg';
  static const String projectsInactive = 'assets/svg/projects_inactive.svg';

  static const String avatarActive = 'assets/svg/avatar_active.svg';
  static const String avatarInactive = 'assets/svg/avatar_inactive.svg';

  static const String profileActive = 'assets/svg/profile_active.svg';
  static const String profileInactive = 'assets/svg/profile_inactive.svg';

  static const String cupActive = 'assets/svg/cup-active.svg';
  static const String cupInactive = 'assets/svg/cup-inactive.svg';

  // SVG ASSETS
  static const String icon_outlined = 'assets/svg/icon_outlined.svg';
  static const String tasksListWhite = 'assets/svg/tasks-list-white.svg';
  static const String on_board_1 = 'assets/svg/on_board_1.svg';
  static const String on_board_2 = 'assets/svg/on_board_2.svg';
  static const String on_board_3 = 'assets/svg/on_board_3.svg';
  static const String clock = 'assets/svg/clock.svg';
  static const String date = 'assets/svg/date.svg';
  static const String trash = 'assets/svg/trash.svg';
  static const String complete = 'assets/svg/complete.svg';
  static const String empty = 'assets/svg/empty.svg';
  static const String day = 'assets/svg/day.svg';
  static const String week = 'assets/svg/week.svg';
  static const String month = 'assets/svg/month.svg';
  static const String halfYear = 'assets/svg/half_year.svg';
  static const String year = 'assets/svg/year.svg';
  static const String staticTasks = 'assets/svg/static.svg';
  static const String basicTitle = 'assets/svg/basics.svg';
  static const String planTitle = 'assets/svg/plans.svg';
  static const String pomodoroTimer = 'assets/svg/pomodorotimer.svg';
  static const String pomodoroTimerGrey = 'assets/svg/pomodorotimer_grey.svg';

  // Social
  static const String facebook = 'assets/svg/facebook.svg';
  static const String twitter = 'assets/svg/twitter.svg';
  static const String google = 'assets/svg/google.svg';

  // IMAGE ASSETS
  static const String avatarImage = 'assets/img/avatar.jpg';

// LOTTIE ASSETS
  static const String appLoading = 'assets/lottie/loading-circles.json';
  static const String emptyNotifications =
      'assets/lottie/empty-notifications.json';
  static const String emptySearch = 'assets/lottie/empty-search.json';
  static const String emptyChats = 'assets/lottie/emptyChats.json';
  static const String error = 'assets/lottie/error.json';
  static const String garbage = 'assets/lottie/garbage.json';
  static const String thinking = 'assets/lottie/thinking.json';
  static const String peopleCommunicating =
      'assets/lottie/group-of-people-communicating.json';
  static const String twoPersonCommunicating =
      'assets/lottie/two-person-message.json';
  static const String sendMessage = 'assets/lottie/send-message.json';

  // VIDEOS
  static const String videoLoading = 'assets/lottie/video-upload-loading.json';
  static const String videoCameraSelfiDevice =
      'assets/lottie/video-camera-selfie-video-device-upload-video.json';
  static const String videoMarketing = 'assets/lottie/video-marketing.json';
  static const String videoExplainer = 'assets/lottie/video-explainer.json';
  static const String videoUploadMobile =
      'assets/lottie/video-upload-in-a-mobile.json';
}

class FormatDate {
  static const String dayMonthYear = 'dd, MMM yyyy';
  static const String deadline = 'HH:mm, MMM dd, yyyy';
  static const String monthYear = 'MMMM, yyyy';
  static const String dayDate = 'EEE, dd';
}

final mobVideoPlatforms = kIsWeb || Platform.isAndroid || Platform.isIOS;
const mobileWidth = 800;

List<String> filterList = [
  "Music",
  "Flutter",
  "Mixes",
  "Angular",
  "Java",
  "Computer programming",
  "Gaming",
  "Live",
  "Helth tips",
  "Files",
  "Website developers",
  "Electrical Enginereing",
  "Recently uploaded",
  "New to you",
  "Vollyball",
  "Cambat sports",
  "JavaScript",
  "Mobile phones",
  "Gadegts",
  "Trailers",
];

//firestore field constants
class FirestoreFieldConstants {
  final String bio = "bio";
  final String status = "status";
  final String connectionRequest = "connection_request";
  final String connections = "connections";
  final String creationDate = "creation_date";
  final String creationTime = "creation_time";
  final String phoneNumber = "phone_number";
  final String profilePic = "profile_pic";
  final String token = "token";
  final String totalConnections = "total_connections";
  final String userName = "username";
  final String call = "call";
}

enum GetFieldForImportantDataLocalDatabase {
  userName,
  userEmail,
  id,
  profileImagePath,
  profileImageUrl,
  bio,
  wallPaper,
  mobileNumber,
  notification,
  accountCreationDate,
  accountCreationTime,
}

String userId = '';
List<InterestModel> interestsList = [
  InterestModel(isChosen: false, title: "programming", icon: "👨‍💻"), 
  InterestModel(isChosen: false, title: "hacking", icon: "🥷"), 
  InterestModel(isChosen: false, title: "design", icon: "🖼️"), 
  InterestModel(isChosen: false, title: "football", icon:"⚽️"), 
  InterestModel(isChosen: false, title: "tennis", icon:"🎾"), 
  InterestModel(isChosen: false, title: "basketball", icon:"🏀"), 
  InterestModel(isChosen: false, title: "gym", icon:"🏋️"), 
  InterestModel(isChosen: false, title: "riding", icon:"🚴‍♀️"), 
  InterestModel(isChosen: false, title: "music", icon:"🎧"), 
  InterestModel(isChosen: false, title: "cooking", icon:"🥘"), 
  InterestModel(isChosen: false, title: "fashion", icon:"👚"), 
  InterestModel(isChosen: false, title: "engineering", icon:"👨🏻‍🚒"), 
];
