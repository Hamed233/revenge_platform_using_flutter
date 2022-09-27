import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/components/bottom_sheets/sheets.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/data/sqlite_management/local_database_management.dart';
import 'package:revenge_platform/models/interests.dart';
import 'package:revenge_platform/models/user.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';
import 'package:revenge_platform/screens/chat_screens/chats.dart';
import 'package:revenge_platform/screens/hire/category_hire_screen.dart';
import 'package:revenge_platform/screens/hire/hire_home_screen.dart';
import 'package:revenge_platform/screens/home/home_screen.dart';
import 'package:revenge_platform/screens/layout_of_app.dart';
import 'package:revenge_platform/screens/top/top_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  final LocalDatabase localDatabase = LocalDatabase();

  List<Widget> mainScreens = [
    const HomeScreen(),
    const TopScreen(),
    Container(),
    HireHomeScreen(),
    Chats(),
    // TasksScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    if (currentIndex == 4) {
      ChatBloc().getUsers();
    }
    emit(AppChangeBottomNavState());
  }

  bool isDark = false;

  changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(
              key: CacheHelperKeys.themeOfAppModeKey, value: isDark)
          .then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ChangePasswordVisibilityState());
  }

  // Select interests
  List selectedIntersts = [];
  bool isSelected = false;

  void toggleSelectInterest(InterestModel item) {
    selectedIntersts.contains(item.title)
        ? selectedIntersts.remove(item.title)
        : selectedIntersts.add(item.title);
    emit(ToggleSelectedIntersts());
  }

  Future storeInterestsToDB() async {
    emit(StoreInterestsToDBLoadingState());
    // List interests = [];
    // selectedIntersts.forEach((element) {
    //   interests.add(element.title);
    // });
    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "userInterests": selectedIntersts,
    }).then((value) {
      emit(StoreInterestsToDBSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StoreInterestsToDBErrorState(error.toString()));
    });
  }

  UserModel? userModel;

  void getUserData() {
    if (userId != '') {
      emit(GetUserDataLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data()!);
        emit(GetUserDataSuccessState());
      }).catchError((error) {
        emit(GetUserDataErrorState(error.toString()));
        print("err" + error.toString());
      });
    }
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AppRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      createUser(
        uId: value.user!.uid,
        name: name,
        email: email,
        password: password,
      );

      //get user account registration date
      final String currentDate = DateFormat('dd-MM-yy').format(DateTime.now());

      //get user account registration time
      final String currentTime = DateFormat('hh:mm a').format(DateTime.now());

      ///calling [LocalDatabase] methods to create and insert new user data into a table

      //creates table for important primary user data
      await localDatabase
          .createTableToStoreImportantData(); // get error when register second!!!

      //inserts data into the table
      await localDatabase.insertOrUpdateDataForThisAccount(
        userName: name,
        userMail: email,
        userId: value.user!.uid,
        userBio: "",
        userAccCreationDate: currentDate,
        userAccCreationTime: currentTime,
        profileImagePath: "",
        profileImageUrl: "",
        purpose: "insert",
      );
    }).catchError((error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Email already used. Go to login page.";
          print(error);
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Server error, please try again later.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          emit(AppRegisterErrorState(error));
          break;
        default:
          error = "Register failed. Please try again.";
          emit(AppRegisterErrorState(error));
          break;
      }
      print(error.toString());
      emit(AppRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String password,
    required String uId,
  }) async {
    //Returns the default FCM token for this device.
    final String? _getToken = await FirebaseMessaging.instance.getToken();

    UserModel model = UserModel(
      fullName: name,
      email: email,
      emailBusiness: "",
      password: password,
      phone: "",
      uId: uId,
      image: "",
      cover: "",
      bio: "",
      isEmailVerified: false,
      isOnline: false,
      date: DateTime.now().toIso8601String(),
      token: _getToken,
      totalconnections: "",
      connections: {},
      connectionRequest: [],
      status: [],
      userInterests: [],
      // user_settings: UserNormalSettings(),
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId.toString())
        .set(model.toMap())
        .then((value) {
      emit(AppRegisterSuccessState());
    }).catchError((error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Email already used. Go to login page.";
          print(error);
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Server error, please try again later.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          emit(AppRegisterErrorState(error));
          break;
        default:
          error = "Register failed. Please try again.";
          emit(AppRegisterErrorState(error));
          break;
      }
      print(error.toString());
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.toString());
      emit(AppLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Email already used. Go to login page.";
          print(error);
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Server error, please try again later.";
          emit(AppRegisterErrorState(error));
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          emit(AppRegisterErrorState(error));
          break;
        default:
          error = "Register failed. Please try again.";
          emit(AppRegisterErrorState(error));
          break;
      }
      print(error.toString());
      emit(AppLoginErrorState(error.toString()));
    });
  }

  //sending media files to connection
  Future<String?> uploadMediaToStorage(File filePath,
      {required String reference}) async {
    try {
      String? downLoadUrl;

      final String fileName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}';

      final Reference firebaseStorageRef =
          FirebaseStorage.instance.ref(reference).child(fileName);

      print('Firebase Storage Reference: $firebaseStorageRef');

      final UploadTask uploadTask = firebaseStorageRef.putFile(filePath);

      await uploadTask.whenComplete(() async {
        print("Media Uploaded");
        downLoadUrl = await firebaseStorageRef.getDownloadURL();
        print("Download Url: $downLoadUrl}");
      });

      return downLoadUrl!;
    } catch (e) {
      print("Error: Firebase Storage Exception is: ${e.toString()}");
      return null;
    }
  }

  // UserModel? userData;

  // Future userInfo(userId)
  //  async {
  //   emit(GetUserDataLoadingState());
  //   FirebaseFirestore.instance.collection("users").doc(userId).get().then((value) {
  //     userData = UserModel.fromMap(value.data()!);
  //     normalUserSettings = userData!.user_settings!;
  //     emit(GetUserDataSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetUserDataErrorState(error.toString()));
  //   });
  // }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage(userId) async {
    emit(ProfileImagePickedLoadingState());

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .update({"image": value}).then((value) {
            // userInfo(userId);
            emit(ProfileImagePickedSuccessState());
          }).catchError((error) {
            emit(ProfileImagePickedErrorState());
            print(error.toString());
          });
        });
      });
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }

  Future updateUserInfo(userId, {email, username, password, whoIs}) async {
    emit(UpdatetUserDataLoadingState());
    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "username": username,
      "email": email,
      "password": password,
      "whoIs": whoIs,
    }).then((value) {
      // userInfo(userId);
      emit(UpdatetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdatetUserDataErrorState(error.toString()));
    });
  }

// void uploadProfileImage() {
//     emit(SocialUserUpdateLoadingState());
//     firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('users/${Uri.file(profileImage.path).pathSegments.last}')
//         .putFile(profileImage)
//         .then((value) {
//       value.ref.getDownloadURL()
//           .then((value) {
//         // emit(SocialUploadProfileImageSuccessState());
//         print(value);
//         updateUser(
//             name: name,
//             phone: phone,
//             bio: bio,
//             image: value,
//         );
//       }).catchError((error) {
//         emit(SocialUploadProfileImageErrorState());
//       });
//     }).catchError((error) {
//       emit(SocialUploadProfileImageErrorState());
//     });
//   }

  Future resetPassword(email) async {
    emit(ResetPasswordLoading());
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      emit(ResetPasswordSuccessful());
    }).catchError((error) {
      emit(ResetPasswordFailed(error.toString()));
    });
  }

  Future signOut(context) async {
    var isSignWith = CacheHelper.getData(key: "isLoginWith");

    emit(SignoutLoading());
    CacheHelper.removeData(
      key: CacheHelperKeys.userIdKey,
    ).then((value) async {
      FirebaseAuth.instance.signOut();
      BottomSheets.showCustomSnackBar(context,
          content: "Signout Successfully",
          bgColor: Colors.green,
          textColor: Colors.white);
      navigateTo(
        context,
        AppLayout(),
      );

      emit(SignoutSuccessful());
    }).catchError((err) {
      print(err.toString());
    });
  }
}
