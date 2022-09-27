abstract class VideoStates {}
// --------- MAIN APP --------
class VideoInitialState extends VideoStates {}
class ThumnailImagePickedLoadingState extends VideoStates {}
class ThumnailImagePickedSuccessfullyState extends VideoStates {}
class ThumnailImagePickedFailedState extends VideoStates {}

class VideoPickedLoadingState extends VideoStates {}
class VideoPickedSuccessfullyState extends VideoStates {}
class VideoPickedFailedState extends VideoStates {}
class VideoUploadingLoadingState extends VideoStates {}
class VideoUploadingSuccessfullyState extends VideoStates {}
class VideoUploadingFailedState extends VideoStates {}

class ToggleVideoSettings extends VideoStates {}
class AddNewPlaylistLoadingState extends VideoStates {}
class SelectPlaylist extends VideoStates {}
class ToggleScaduale extends VideoStates {}
class GetVideoDateState extends VideoStates {}
class GetVideoSchaduleTimeState extends VideoStates {}

class AddNewPlaylistSuccessState extends VideoStates {}
class AddNewPlaylistErrorState extends VideoStates {}
class GetPlaylistsLoadingState extends VideoStates {}
class GetPlaylistsSuccessState extends VideoStates {}
class GetPlaylistsErrorState extends VideoStates {
  final String? error;
  GetPlaylistsErrorState(this.error);
}
class UpdatetPlaylistLoadingState extends VideoStates {}
class UpdatetPlaylistSuccessState extends VideoStates {}
class UpdatetPlaylistErrorState extends VideoStates {
   final String? error;
  UpdatetPlaylistErrorState(this.error);
}

class AddNewVideoLoadingState extends VideoStates {}
class AddNewVideoSuccessState extends VideoStates {}
class AddNewVideoErrorState extends VideoStates {
   final String? error;
  AddNewVideoErrorState(this.error);
}