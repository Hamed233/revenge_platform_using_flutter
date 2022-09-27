import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revenge_platform/blocs/chat_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/constants/enum_generator.dart';
import 'package:revenge_platform/data/online_database_management/cloud_data_management.dart';
import 'package:revenge_platform/models/chat.dart';
import 'package:revenge_platform/models/user.dart';

import '../../data/sqlite_management/local_database_management.dart';

class ChatBloc extends Cubit<ChatStates> {
  ChatBloc() : super(ChatInitialState());
  
  static ChatBloc get(context) => BlocProvider.of(context);
  final LocalDatabase localDatabase = LocalDatabase();

  // UserModel? userModel;

  List<UserModel> users = [];

  void getUsers()
  {
      users = [];
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
            value.docs.forEach((element) {
              if(element.data()['uId'] != userId) {
                users.add(UserModel.fromJson(element.data()));
              }
            });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  Future<void> sendMessage({
    required String receiveId,
    required String dateTime,
    required String text,
    required String profilePic,
}) async {
    MessageModel model = MessageModel(
      text: text,
      senderId: userId,
      receiverId: receiveId,
      dateTime: dateTime,
    );

    // Set my chat
    FirebaseFirestore.instance
    .collection('users')
    .doc(userId)
    .collection('chats')
    .doc(receiveId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState());
    });

    // Set Receiver Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveId)
        .collection('chats')
        .doc(receiveId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState());
    });

    final String _messageTime = "${DateTime.now().hour}:${DateTime.now().minute}";


        //store current user's text message locally using the connection's username
    await localDatabase.insertMessageInUserTable(
        profilePic: profilePic,
        receiveId: receiveId,
        actualMessage: text,
        chatMessageTypes: ChatMessageType.text,
        messageHolderType: MessageHolderType.me,
        messageDateLocal: DateTime.now().toString().split(" ")[0],
        messageTimeLocal: _messageTime);

  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiveId,
  }) {
    
    emit(ChatGetMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(receiveId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });

          emit(ChatGetMessageSuccessState());
    });
  }

  final Dio dio = Dio(); //to download files
    String _connectionEmail = '';
  final FirestoreFieldConstants _firestoreFieldConstants =
      FirestoreFieldConstants();
  final CloudStoreDataManagement _cloudStoreDataManagement =
      CloudStoreDataManagement();
  final LocalDatabase _localDatabase = LocalDatabase();





//send video message
  void sendVideoMessage(
      {required var videoPath, required String thumbnailPath}) async {
    // try {
      // if (mounted) {
      //   setState(() {
      //     _isLoading = true;
      //   });
      // }

      final String _messageTime =
          "${DateTime.now().hour}:${DateTime.now().minute}";

      //upload video file and get the remote file path
      // final String? downloadedVideoPath = await _cloudStoreDataManagement
      //     .uploadMediaToStorage(File(videoPath.path), reference: 'chatVideos/');

      //upload video thumbnail file and get the remote file path
      // final String? downloadedVideoThumbnailPath =
      //     await _cloudStoreDataManagement.uploadMediaToStorage(
      //         File(thumbnailPath),
      //         reference: 'chatVideosThumbnail/');

      //send message data including remote file path to firestore
    //   if (downloadedVideoPath != null) {
    //     await _cloudStoreDataManagement.sendMessageToConnection(
    //         connectionUserName: widget.username,
    //         sendMessageData: {
    //           ChatMessageType.video.toString(): {
    //             "${downloadedVideoPath.toString()} + ${downloadedVideoThumbnailPath.toString()}":
    //                 _messageTime
    //           }
    //         },
    //         chatMessageType: ChatMessageType.video);
    //   }

    //   if (mounted) {
    //     setState(() {
    //       _allconversationMessages
    //           .add({File(videoPath.path).path: _messageTime});

    //       print(" video file :    ${File(videoPath.path).path.toString()}");

    //       _chatMessageCategoryHolder.add(ChatMessageType.video);
    //       _conversationMessageHolder.add(false);
    //       // _scrollController.jumpTo(_scrollController.position.maxScrollExtent +
    //       //     _amountToScroll(ChatMessageType.video));
    //     });
    //   }

    //   //save audio file path, message time
    //   await _localDatabase.insertMessageInUserTable(
    //       profilePic: widget.profilePic,
    //       userName: widget.username,
    //       // actualMessage:downloadedVideoPath.toString() + downloadedThumbnailPath.toString()
    //       actualMessage: File(videoPath.path).path,
    //       chatMessageTypes: ChatMessageType.video,
    //       messageHolderType: MessageHolderType.me,
    //       messageDateLocal: DateTime.now().toString().split(" ")[0],
    //       messageTimeLocal: _messageTime);

    //   if (mounted) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   }
    // } catch (e) {
    //   print('error in sending video message ${e.toString()}');
    // }
  }

  //send image message
  void sendImageMessage({required var imagePath}) async {
    try {
      // if (mounted) {
      //   setState(() {
      //     _isLoading = true;
      //   });
      // }

      final String _messageTime =
          "${DateTime.now().hour}:${DateTime.now().minute}";

      //upload file and get the remote file path
      // final String? downloadedImagePath = await _cloudStoreDataManagement
      //     .uploadMediaToStorage(File(imagePath.path), reference: 'chatImage/');

      //send message data including remote file path to firestore
      // if (downloadedImagePath != null) {
      //   await _cloudStoreDataManagement.sendMessageToConnection(
      //       connectionUserName: widget.username,
      //       sendMessageData: {
      //         ChatMessageType.image.toString(): {
      //           downloadedImagePath.toString(): _messageTime
      //         }
      //       },
      //       chatMessageType: ChatMessageType.image);
      // }

      // if (mounted) {
      //   setState(() {
      //     _allconversationMessages.add({imagePath.path: _messageTime});

      //     _chatMessageCategoryHolder.add(ChatMessageType.image);
      //     _conversationMessageHolder.add(false);
      //     // _scrollController.jumpTo(_scrollController.position.maxScrollExtent +
      //     //     _amountToScroll(ChatMessageType.image));
      //   });
      // }

      //save audio file path, message time to local
      // await _localDatabase.insertMessageInUserTable(
      //     profilePic: widget.profilePic,
      //     userName: widget.username,
      //     actualMessage: imagePath.path.toString(),
      //     chatMessageTypes: ChatMessageType.image,
      //     messageHolderType: MessageHolderType.me,
      //     messageDateLocal: DateTime.now().toString().split(" ")[0],
      //     messageTimeLocal: _messageTime);

      // if (mounted) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }
    } catch (e) {
      print('error in sending image file ${e.toString()}');
    }
  }

  //
  void _audioPlayButtonOnTapAction(int index) async {
    try {
      // _justAudioPlayer.positionStream.listen((event) {
      //   if (mounted) {
      //     setState(() {
      //       _currAudioPlayingTime = event.inMicroseconds.ceilToDouble();
      //       _loadingTime =
      //           '${event.inMinutes} : ${event.inSeconds > 59 ? event.inSeconds % 60 : event.inSeconds}';
      //     });
      //   }
      // });
      // //listen for end of file
      // _justAudioPlayer.playerStateStream.listen((event) {
      //   if (event.processingState == ProcessingState.completed) {
      //     _justAudioPlayer.stop(); //stop the player
      //     if (mounted) {
      //       setState(() {
      //         _loadingTime = '0:00'; //reset the play time to 0.00
      //         _audioPlayerIcon = Icons.play_arrow_rounded;
      //       });
      //     }
      //   }
      // });

      // if (_lastAudioPlayingIndex != index) {
      //   await _justAudioPlayer
      //       .setFilePath(_allconversationMessages[index].keys.first);

      //   if (mounted) {
      //     setState(() {
      //       _lastAudioPlayingIndex = index;
      //       _totalDuration =
      //           '${_justAudioPlayer.duration!.inMinutes} : ${_justAudioPlayer.duration!.inSeconds > 59 ? _justAudioPlayer.duration!.inSeconds % 60 : _justAudioPlayer.duration!.inSeconds}';
      //       _audioPlayerIcon = Icons.pause;
      //       _audioPlayingSpeed = 1.0;
      //       _justAudioPlayer.setSpeed(_audioPlayingSpeed);
      //     });
      //   }

      //   await _justAudioPlayer.play();
      // } else {
      //   //print(_justAudioPlayer.processingState);
      //   if (_justAudioPlayer.processingState == ProcessingState.idle) {
      //     await _justAudioPlayer
      //         .setFilePath(_allconversationMessages[index].keys.first);

      //     if (mounted) {
      //       setState(() {
      //         _lastAudioPlayingIndex = index;
      //         _totalDuration =
      //             '${_justAudioPlayer.duration!.inMinutes} : ${_justAudioPlayer.duration!.inSeconds}';
      //         _audioPlayerIcon = Icons.pause;
      //       });
      //     }

      //     await _justAudioPlayer.play();
      //   } else if (_justAudioPlayer.playing) {
      //     if (mounted) {
      //       setState(() {
      //         _audioPlayerIcon = Icons.play_arrow_rounded;
      //       });
      //     }

      //     await _justAudioPlayer.pause();
      //   } else if (_justAudioPlayer.processingState == ProcessingState.ready) {
      //     if (mounted) {
      //       setState(() {
      //         _audioPlayerIcon = Icons.pause;
      //       });
      //     }

      //     await _justAudioPlayer.play();
      //   } else if (_justAudioPlayer.processingState ==
      //       ProcessingState.completed) {}
      // }
    } catch (e) {
      // print('Audio Playing Error');
      // await showPlatformToast(
      //   child: const Text('Audio file not found'),
      //   context: context,
      // );
    }
  }

  //
  void audioPlayButtonOnLongPressedAction() async {
    // if (_justAudioPlayer.playing) {
    //   await _justAudioPlayer.stop();

    //   if (mounted) {
    //     setState(() {
    //       // print('Audio Play Completed');
    //       _justAudioPlayer.stop();
    //       if (mounted) {
    //         setState(() {
    //           _loadingTime = '0:00';
    //           _audioPlayerIcon = Icons.play_arrow_rounded;
    //           _lastAudioPlayingIndex = -1;
    //         });
    //       }
    //     });
    //   }
    // }
  }






  //manage incoming media files
  // void manageIncomingMediaMessages(
  //     var mediaMessage, ChatMessageType chatMessageType) async {
  //   String refName = ""; //local storage folder name
  //   String extension = "";
  //   late String thumbnailFileRemotePath;

  //   String videoThumbnailLocalPath = "";

  //   String actualFileRemotePath = chatMessageType == ChatMessageType.video ||
  //           chatMessageType == ChatMessageType.document
  //       ? mediaMessage.keys.first.toString().split("+")[0]
  //       : mediaMessage.keys.first.toString();

  //   if (chatMessageType == ChatMessageType.image) {
  //     refName = "/Images/";
  //     extension = '.png';
  //   } else if (chatMessageType == ChatMessageType.video) {
  //     refName = "/Videos/";
  //     extension = '.mp4';
  //     thumbnailFileRemotePath =
  //         mediaMessage.keys.first.toString().split("+")[1];
  //   } else if (chatMessageType == ChatMessageType.document) {
  //     refName = "/Documents/";
  //     extension = mediaMessage.keys.first.toString().split("+")[1];
  //   } else if (chatMessageType == ChatMessageType.audio) {
  //     refName = "/Audio/";
  //     extension = '.mp3';
  //   }

  //   // if (mounted) {
  //   //   setState(() {
  //   //     _isLoading = true;
  //   //   });
  //   // }

  //   final Directory? directory = await getExternalStorageDirectory();
  //   print('Directory Path: ${directory!.path}');

  //   final storageDirectory = await Directory(directory.path + refName)
  //       .create(); // Create New Folder about the desire location

  //   final String mediaFileLocalPath =
  //       "${storageDirectory.path}${DateTime.now().toString().split(" ").join("")}$extension";

  //   if (chatMessageType == ChatMessageType.video) {
  //     final storageDirectory = await Directory(directory.path + "/.Thumbnails/")
  //         .create(); // Create New Folder about the desire location

  //     videoThumbnailLocalPath =
  //         "${storageDirectory.path}${DateTime.now().toString().split(" ").join("")}.png";
  //   }

  //   try {
  //     print("Media Saved Path: $mediaFileLocalPath");

  //     await dio
  //         .download(actualFileRemotePath, mediaFileLocalPath)
  //         .whenComplete(() async {
  //       if (chatMessageType == ChatMessageType.video) {
  //         await dio
  //             .download(thumbnailFileRemotePath, videoThumbnailLocalPath)
  //             .whenComplete(() async {
  //           await _storeAndShowIncomingMediaMessageData(
  //               mediaFileLocalPath:
  //                   "$videoThumbnailLocalPath+$mediaFileLocalPath",
  //               chatMessageTypes: chatMessageType,
  //               mediaMessage: mediaMessage);
  //         });
  //       } else {
  //         await _storeAndShowIncomingMediaMessageData(
  //             mediaFileLocalPath: mediaFileLocalPath,
  //             chatMessageTypes: chatMessageType,
  //             mediaMessage: mediaMessage);
  //       }
  //     });
  //   } catch (e) {
  //     print("Error in Media Downloading: ${e.toString()}");
  //   }
  // }

  //   //store media mssages locally
  // Future<void> _storeAndShowIncomingMediaMessageData(
  //     {required String mediaFileLocalPath,
  //     required ChatMessageType chatMessageTypes,
  //     required var mediaMessage}) async {
  //   try {
  //     await _localDatabase.insertMessageInUserTable(
  //         profilePic: widget.profilePic,
  //         userName: widget.username,
  //         actualMessage: mediaFileLocalPath,
  //         chatMessageTypes: chatMessageTypes,
  //         messageHolderType: MessageHolderType.connectedUsers,
  //         messageDateLocal: DateTime.now().toString().split(" ")[0],
  //         messageTimeLocal: mediaMessage.values.first.toString());

  //     if (mounted) {
  //       setState(() {
  //         _allconversationMessages.add({
  //           mediaFileLocalPath: mediaMessage.values.first.toString(),
  //         });
  //         _chatMessageCategoryHolder.add(chatMessageTypes);
  //         _conversationMessageHolder.add(true);

  //         _scrollController.jumpTo(_scrollController.position.maxScrollExtent +
  //             _amountToScroll(chatMessageTypes));
  //       });
  //     }
  //   } catch (e) {
  //     print("Error: _storeAndShowIncomingMediaMessageData: ${e.toString()}");
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  //   //get connected user's mail from the importDataTable record using their email
  // void _getConnectionEmail() async {
  //   final String? getUserEmail =
  //       await _localDatabase.getParticularFieldDataFromImportantTable(
  //           userName: widget.username,
  //           getField: GetFieldForImportantDataLocalDatabase.userEmail);

  //   if (mounted) {
  //     setState(() {
  //       _connectionEmail = getUserEmail.toString();
  //     });
  //   }
  // }

  
  // //load previous  messages
  // void _loadPreviousStoredMessages() async {
  //   // double positionToScroll = 100.0;

  //   try {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //     }

  //     List<PreviousMessageStructure> _storedPreviousMessages =
  //         await _localDatabase.getAllPreviousMessages(widget.username);

  //     if (_storedPreviousMessages.isNotEmpty) {
  //       for (int i = 0; i < _storedPreviousMessages.length; i++) {
  //         final PreviousMessageStructure _previousMessage =
  //             _storedPreviousMessages[i];
  //         if (mounted) {
  //           setState(() {
  //             _allconversationMessages.add({
  //               _previousMessage.actualMessage: _previousMessage.messageTime,
  //             });
  //             _chatMessageCategoryHolder.add(_previousMessage.messageType);
  //             _conversationMessageHolder.add(_previousMessage.messageHolder ==
  //                     MessageHolderType.me.toString()
  //                 ? false
  //                 : true);

  //             // positionToScroll += _amountToScroll(_previousMessage.messageType);
  //           });
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("Previous Messages Fetching Error in ChatDetailsScreen: ${e.toString()}");
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }

    //  if (mounted) {
    //    setState(() {
    //      print("position to scroll : $positionToScroll");
    //       _scrollController.jumpTo(
    //           _scrollController.position.maxScrollExtent + positionToScroll);
    //     });
    //   }
  }

  //get permission for storage
  // void takePermissionForStorage() async {
  //   var status = await Permission.storage.request();
  //   if (status == PermissionStatus.granted) {
  //     {
  //       _makeDirectoryForRecordings();
  //     }
  //   } else {
  //     await showPlatformToast(
  //       child: const Text('Some problems may have occured'),
  //       context: context,
  //     );
  //   }
  // }

  // void _makeDirectoryForRecordings() async {
  //   final Directory? directory = await getExternalStorageDirectory();

  //   _audioDirectory = await Directory(directory!.path + '/Recordings/')
  //       .create(); // This directory will create Once in whole Application
  // }
// }