
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/blocs/profile_bloc/states.dart';
import 'package:revenge_platform/components/bottom_sheets/sheets.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';
import 'package:revenge_platform/screens/home/home_screen.dart';
import 'package:revenge_platform/screens/layout_of_app.dart';
import 'package:revenge_platform/screens/profile/feed_profile_tab.dart';
import 'package:revenge_platform/screens/profile/hire_me/profile_hire_me_tab.dart';
import 'package:revenge_platform/screens/profile/profile_posts_tab.dart';
import 'package:revenge_platform/screens/profile/profile_tasks_tab.dart';
import 'package:revenge_platform/screens/profile/profile_videos_tab.dart';
import 'package:revenge_platform/screens/top/top_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../screens/profile/profile_playlists_tab.dart';

class ProfileBloc extends Cubit<ProfileStates> {
  ProfileBloc() : super(ProfileInitialState());

  static ProfileBloc get(context) => BlocProvider.of(context);

  int currentTabIndex = 0;

  List<Widget> tabScreens = <Widget>[
    FeedProfileTab(),
    VideosProfileTab(),
    PlaylistsProfileTab(),
    PostsProfileTab(),
    TasksProfileTab(),
    HireMeTab(),
  ];

  void changeTabNav(int index) {
    currentTabIndex = index;
    emit(ProfileChangeTabNavState());
  }

  // Sort Videos by
  String? sortType = CacheHelper.getData(key: CacheHelperKeys.profileVideosSortBy);
  void sortBy(_sortType)  {
    emit(GetNewSortLoading());

    CacheHelper.saveData(
      key: CacheHelperKeys.profileVideosSortBy,
      value: _sortType,
    ).then((value) {
      sortType = CacheHelper.getData(key: CacheHelperKeys.profileVideosSortBy);
      emit(GetNewSortSuccessfuly());
    }).catchError((error) {
      emit(GetNewSortFailed());
    });
    // getTaskList(sortBy: sortType);
  }


  // File? profileImage;
  // var picker = ImagePicker();

  // Future<void> getProfileImage(userId) async {

  //   emit(ProfileImagePickedLoadingState());

  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if(pickedFile != null) {
  //     profileImage = File(pickedFile.path);
  //     firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
  //       .putFile(profileImage!).then((value) {
  //         value.ref.getDownloadURL().then((value) {
  //           FirebaseFirestore.instance.collection("users").doc(userId).update({"image": value}).then((value) {
  //             // userInfo(userId);
  //             emit(ProfileImagePickedSuccessState());
  //           }).catchError((error) {
  //             emit(ProfileImagePickedErrorState());
  //             print(error.toString());
  //           });
  //         });
  //       });
  //   } else {
  //     emit(ProfileImagePickedErrorState());
  //   }
  // }

  
}


