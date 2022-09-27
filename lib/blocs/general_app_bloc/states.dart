abstract class AppStates {}
// --------- MAIN APP --------
class ChangePasswordVisibilityState extends AppStates {}
class AppInitialState extends AppStates {}
class AppChangeModeState extends AppStates {}
class AppChangeBottomNavState extends AppStates {}
class BottomNavigationIsVisible extends AppStates {}
class ToggleSelectedIntersts extends AppStates {}
class StoreInterestsToDBLoadingState extends AppStates {}
class StoreInterestsToDBSuccessState extends AppStates {}
class StoreInterestsToDBErrorState extends AppStates {
  late final String error;
  StoreInterestsToDBErrorState(this.error);
}

class GettingNotificationsLoading extends AppStates {}
class GettingNotificationsDone extends AppStates {}
class NotificationsOpendIsLoading extends AppStates {}
class NotificationsIsOpend extends AppStates {}

// Login & Register & User Data
class AppLoginSuccessState extends AppStates {
  final String uId;
  AppLoginSuccessState(this.uId);
}
class AppLoginLoadingState extends AppStates {}
class AppLangChangedState extends AppStates {}
class AppLoginErrorState extends AppStates {
  late final String error;
  AppLoginErrorState(this.error);
}

class SignInWithGoogleLoading extends AppStates {}
class SignInWithGoogleSuccessful extends AppStates {}
class SignInWithGoogleFailed extends AppStates {
  final String error;
  SignInWithGoogleFailed(this.error);
}

class SignInWithFBLoading extends AppStates {}
class SignInWithFBSuccessful extends AppStates {}
class SignInWithFBFailed extends AppStates {
  final String error;
  SignInWithFBFailed(this.error);
}

class ResetPasswordLoading extends AppStates {}
class ResetPasswordSuccessful extends AppStates {}
class ResetPasswordFailed extends AppStates {
  final String error;
  ResetPasswordFailed(this.error);
}

class SignInWithTwitterLoading extends AppStates {}
class SignInWithTwitterSuccessful extends AppStates {}
class SignInWithTwitterFailed extends AppStates {
  final String error;
  SignInWithTwitterFailed(this.error);
}

class SignoutLoading extends AppStates {}
class SignoutSuccessful extends AppStates {}
class ProfileImagePickedSuccessState extends AppStates {}
class ProfileImagePickedErrorState extends AppStates {}
class ProfileImagePickedLoadingState extends AppStates {}

// Get User Data
class GetUserDataSuccessState extends AppStates {
}
class GetUserDataLoadingState extends AppStates {}
class GetUserDataErrorState extends AppStates {
  late final String error;
  GetUserDataErrorState(this.error);
}

class UpdatetUserDataLoadingState extends AppStates {
}
class UpdatetUserDataSuccessState extends AppStates {}
class UpdatetUserDataErrorState extends AppStates {
  late final String error;
  UpdatetUserDataErrorState(this.error);
}

// Register
class AppRegisterSuccessState extends AppStates {}
class AppRegisterLoadingState extends AppStates {}
class AppRegisterErrorState extends AppStates {
  late final String error;
  AppRegisterErrorState(this.error);
}

class GettingGeneralDataLoading extends AppStates {}
class RetrieveGeneralDataFromDatabase extends AppStates {}
class UpdateGeneralUserSettingsLoading extends AppStates {}
