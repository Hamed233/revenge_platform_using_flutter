import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:revenge_platform/blocs/video_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/models/playlist.dart';
import 'package:revenge_platform/models/video.dart';
import 'package:revenge_platform/models/video_settings.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:video_player/video_player.dart';

class VideoBloc extends Cubit<VideoStates> {
  VideoBloc() : super(VideoInitialState());

  static VideoBloc get(context) => BlocProvider.of(context);

  DateTime today = DateTime.now();
  late String? sceduleTime = DateFormat('hh:mm a')
      .format(today.add(const Duration(minutes: 30)))
      .toString();
  late String sceduleDate = DateFormat('dd-MM-yyyy').format(today).toString();

  void getVideoDate(date) {
    sceduleDate = DateFormat('dd-MM-yyyy').format(date).toString();
    emit(GetVideoDateState());
  }

  void getSchaduleTime(time) {
    sceduleTime = time;
    emit(GetVideoSchaduleTimeState());
  }

  // Upload thumnail of video
  File? imageThumnail;
  final pickerImageThumnail = ImagePicker();
  String? imageUrl;
  Future selectAndUploadThumn() async {
    emit(ThumnailImagePickedLoadingState());

    final pickedImage =
        await pickerImageThumnail.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageThumnail = File(pickedImage.path);
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'vedioThumnails/users/$userId/${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}/${Uri.file(pickedImage.path).pathSegments.last}')
          .putFile(imageThumnail!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          imageUrl = value;
          emit(ThumnailImagePickedSuccessfullyState());
        }).catchError((error) {
          emit(ThumnailImagePickedFailedState());
          print(error.toString());
        });
      });
    } else {
      emit(ThumnailImagePickedFailedState());
    }
  }

  // Upload video
  File? video;
  final pickerVideo = ImagePicker();
  String? videoUrl;
  VideoPlayerController? videoPlayerController;

  Future selectAndUploadVideo() async {

    final pickedVideo =
        await pickerVideo.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      emit(VideoPickedLoadingState());
      video = File(pickedVideo.path);
      videoPlayerController = VideoPlayerController.asset(video!.path)..initialize();
      initializePlayer();

      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'vedios/users/$userId/${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}/${Uri.file(pickedVideo.path).pathSegments.last}')
          .putFile(video!)
          .then((value) {
            emit(VideoUploadingLoadingState());
        value.ref.getDownloadURL().then((value) {
          videoUrl = value;
          print(videoUrl);
          emit(VideoUploadingSuccessfullyState());
        }).catchError((error) {
          emit(VideoUploadingFailedState());
          print(error.toString());
        });
      }).catchError((err) {
        print(err);
      });
    } else {
      emit(VideoPickedFailedState());
    }
  }

  Future<void> initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.file(video!);
    await Future.wait([
      videoPlayerController!.initialize(),
    ]);
  }
  // Video Settings options
  bool closedComments = false;
  bool closedFeedback = false;
  bool suitableForChildren = true;

  void toggleVideoSettings(val, toggleWhat) {
    if (toggleWhat == 'comments') {
      closedComments = !closedComments;
    } else if (toggleWhat == 'feedback') {
      closedFeedback = !closedFeedback;
    } else if (toggleWhat == 'suitableChildren') {
      suitableForChildren = !suitableForChildren;
    }

    emit(ToggleVideoSettings());
  }

  Playlist? playlistModel;
  String? selectedPlaylist;
  List<Playlist> playlists = [];
  // Select Playlist
  void selectPlaylist(playlist) {
    selectedPlaylist = playlist;
    emit(SelectPlaylist());
  }

  // Get playlists
  void getPlaylists() {
    emit(GetPlaylistsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("playlists")
        .orderBy("datetime")
        .get()
        .then((value) {
      playlists = [];
      value.docs.forEach((element) {
        playlists.add(Playlist.fromJson(element.data()));
        // print(playlists);
      });
      emit(GetPlaylistsSuccessState());
    }).catchError((err) {
      print(err.toString());
    });
  }

  // add new playlist
  Future<void> addNewPlayList(Playlist model) async {
    emit(AddNewPlaylistLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('playlists')
        .add(model.toMap())
        .then((value) {
      emit(AddNewPlaylistSuccessState());
    }).catchError((error) {
      emit(AddNewPlaylistErrorState());
    });
  }

  Future updatePlaylist(Playlist model) async {
    emit(UpdatetPlaylistLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("playlists")
        .doc(model.title)
        .update({
      "title": model.title,
      "description": model.description,
    }).then((value) {
      emit(UpdatetPlaylistSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdatetPlaylistErrorState(error.toString()));
    });
  }

  // Scaduale video
  bool isScaduale = false;

  void toggleScaduale(val) {
    isScaduale = val;
    emit(ToggleScaduale());
  }

  Future uploadVideo(title, description, playlist, type, duration, videoUrl,
      thumbnailUrl, VideoSettings videoSettings, userId) async {
    emit(AddNewVideoLoadingState());
    Video model = Video(
        userId: userId,
        title: title,
        description: description,
        videolUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        duration: duration,
        publishDate: DateFormat('dd-MM-yyyy').format(today).toString(),
        publishTime: DateFormat('hh:mm a').format(today).toString(),
        viewCount: 30,
        likes: 34,
        dislikes: 3,
        shares: 4,
        videoSettings: videoSettings);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('videos')
        .add(model.toMap())
        .then((value) {
      emit(AddNewVideoSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddNewVideoErrorState(error.toString()));
    });
  }
}
