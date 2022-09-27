// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:bubble/bubble.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:fl_toast/fl_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttericon/entypo_icons.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:open_file/open_file.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pfile_picker/pfile_picker.dart';
// import 'package:pinch_zoom/pinch_zoom.dart';
// import 'package:record/record.dart';
// import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
// import 'package:revenge_platform/components/constants/constants.dart';
// import 'package:revenge_platform/components/constants/enum_generator.dart';
// import 'package:revenge_platform/components/styles/colors.dart';
// import 'package:revenge_platform/data/online_database_management/cloud_data_management.dart';
// import 'package:revenge_platform/data/sqlite_management/local_database_management.dart';
// import 'package:revenge_platform/models/call.dart';
// import 'package:revenge_platform/models/previous_message.dart';
// import 'package:revenge_platform/screens/chat_screens/call_screens/call_screen.dart';
// import 'package:revenge_platform/screens/preview/image_preview.dart';

// class ChatDetailsScreen extends StatefulWidget {
//   final String username; //connection username
//   final String profilePic;

//   const ChatDetailsScreen({Key? key, required this.username, required this.profilePic})
//       : super(key: key);

//   @override
//   State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
// }

// class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
//   bool _isLoading = false;
//   bool _isMessagePresent = false; // message presence in the textfield
//   bool _showEmojiPicker = false;
//   double _chatBoxHeight = 0.0;
//   String _hintText = 'Type here';
//   List<bool> _conversationMessageHolder = [];
//   List<Map<String, String>> _allconversationMessages = [];
//   List<ChatMessageType> _chatMessageCategoryHolder = [];
//   final ScrollController _scrollController =
//       ScrollController(initialScrollOffset: 0.0);

//   TextEditingController _messageController = TextEditingController();

//   final AudioPlayer _justAudioPlayer = AudioPlayer();
//   final Record _record = Record(); //record voice note
//   Directory? _audioDirectory; //directory to save audio files
//   late double _currAudioPlayingTime;
//   int _lastAudioPlayingIndex = 0;
//   double _audioPlayingSpeed = 1.0;
//   String _totalDuration = '0:00';
//   String _loadingTime = '0:00';
//   IconData _audioPlayerIcon = Icons.play_arrow_outlined;
//   Stream<DocumentSnapshot<Map<String, dynamic>>>? _stream;


//   double _amountToScroll(ChatMessageType messageType) {
//     switch (messageType) {
//       case ChatMessageType.text:
//         return 46.0;
//       case ChatMessageType.image:
//         return 331;
//       case ChatMessageType.video:
//         return 76.0;
//       case ChatMessageType.document:
//         return 57.0;
//       case ChatMessageType.audio:
//         return 66.0;
//       case ChatMessageType.none:
//         return 31.0;
//     }
//   }

//   @override
//   void initState() {
//     _loadPreviousStoredMessages(); //laod previous messages from local
//     _getConnectionEmail();
//     _fetchIncomingMessages();
//     _takePermissionForStorage();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _stream!.listen((event) {}).cancel();
//     _justAudioPlayer.dispose();
//     _record.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;

//     if (_chatBoxHeight == 0.0) {
//       _chatBoxHeight = _size.height - 175;
//     }
//     return WillPopScope(
//       onWillPop: () async {
//         if (_showEmojiPicker) {
//           setState(() {
//             _showEmojiPicker = false;
//           });
//           return false;
//         } else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: _appBar(),
//         body: LoadingOverlay(
//           isLoading: _isLoading,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
//             child: ListView(
//               shrinkWrap: true,
//               children: <Widget>[
//                 SizedBox(
//                     width: double.maxFinite,
//                     height: _chatBoxHeight,
//                     child: _allconversationMessages.isEmpty
//                         ? const Center(
//                             child: Text(
//                               'No Messages yet!',
//                               style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 18.0,
//                                   letterSpacing: 1.0),
//                             ),
//                           )
//                         : ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             //    shrinkWrap: true,
//                             itemCount: _allconversationMessages.length,
//                             controller: _scrollController,
//                             itemBuilder: (itemBuilderContext, index) {
//                               return Column(
//                                   //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                         margin:
//                                             _conversationMessageHolder[index]
//                                                 ? EdgeInsets.only(
//                                                     right: _size.width / 3)
//                                                 : EdgeInsets.only(
//                                                     left: _size.width / 3),
//                                         alignment:
//                                             _conversationMessageHolder[index]
//                                                 ? Alignment.centerLeft
//                                                 : Alignment.centerRight,
//                                         child: _chatMessageCategoryHolder[
//                                                     index] ==
//                                                 ChatMessageType.image
//                                             ? _imageMessage(context, index)
//                                             : _chatBubble(
//                                                 isSender:
//                                                     _conversationMessageHolder[
//                                                             index]
//                                                         ? false
//                                                         : true,
//                                                 child: _messageTypeSelector(
//                                                     itemBuilderContext,
//                                                     index))),
//                                     _conversationMessageTime(
//                                         _allconversationMessages[index]
//                                             .values
//                                             .first,
//                                         index),
//                                   ]);
//                             })),
//                 //type and send message
//                 _typeAndSendMessage(),
//                 //show emoji picker
//                 _showEmojiPicker ? _showEmoji() : const Center()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// //appBar
//   AppBar _appBar() {
//     return AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, size: 22.0, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(
//               context,
//             );
//           },
//         ),
//         elevation: 0.0,
//         title: Row(children: <Widget>[
//           //user picture
//           GestureDetector(
//               child: CircleAvatar(
//                   radius: 22.0,
//                   backgroundColor: Colors.transparent,
//                   backgroundImage: FileImage(File(widget.profilePic))),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     PageTransition(
//                         type: PageTransitionType.fade,
//                         child: ImageViewScreen(
//                           imagePath: widget.profilePic,
//                           imageProviderCategory:
//                               ImageProviderCategory.fileImage,
//                         )));
//               }),

//           const SizedBox(width: 8.0),
//           //username
//           Text(
//               widget.username.length <= 12
//                   ? widget.username
//                   : widget.username.replaceRange(12, widget.username.length,
//                       '...'), //ensure title length is no more than 12
//               style: const TextStyle(
//                   color: Colors.black, letterSpacing: 1.0, fontSize: 18.0)),
//         ]),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.call_outlined, color: Colors.black, size: 18.0),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon:
//                 const Icon(Icons.videocam_outlined, color: Colors.black, size: 18.0),
//             onPressed: () async {
//               final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//               String? connectionMail =
//                   await _localDatabase.getParticularFieldDataFromImportantTable(
//                       userName: widget.username,
//                       getField:
//                           GetFieldForImportantDataLocalDatabase.userEmail);

//               String? connectionProfilePicUrl =
//                   await _localDatabase.getParticularFieldDataFromImportantTable(
//                       userName: widget.username,
//                       getField: GetFieldForImportantDataLocalDatabase
//                           .profileImageUrl);

//               String? currentUsername =
//                   await _localDatabase.getUserNameForAnyUser(
//                       _firebaseAuth.currentUser!.email.toString());

//               String? currentUserProfilePicUrl =
//                   await _localDatabase.getParticularFieldDataFromImportantTable(
//                       userName: currentUsername!,
//                       getField: GetFieldForImportantDataLocalDatabase
//                           .profileImageUrl);

//               Call call = Call(
//                   callerId: _firebaseAuth.currentUser!.email.toString(),
//                   callerName: currentUsername,
//                   receiverId: connectionMail!,
//                   receiverName: widget.username,
//                   receiverPic: connectionProfilePicUrl!,
//                   callerPic: currentUserProfilePicUrl!,
//                   channeId: Random().nextInt(1000).toString());

//               bool callMade = await CloudStoreDataManagement().makeCall(call);
//               if (callMade) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CallScreen(call: call)));
//               }
//             },
//           ),
//         ]);
//   }

// //media file icon Button
//   Widget reusableMediaIconButton(
//       {required String title,
//       required Color bgColor,
//       required IconData icon,
//       required Function() onPressed}) {
//     return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       CircleAvatar(
//           radius: 20.0,
//           backgroundColor: bgColor,
//           child: IconButton(
//               onPressed: onPressed,
//               icon: Icon(
//                 icon,
//                 size: 20.0,
//                 color: Colors.white,
//               ))),
//       const SizedBox(height: 2.0),
//       Text(
//         title,
//         style: const TextStyle(color: Colors.grey, fontSize: 12.0),
//       )
//     ]);
//   }

// //send media files
//   void _chatMediaOptions() {
//     showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(40.0)),
//               elevation: 5.0,
//               backgroundColor: Colors.white,
//               content: SizedBox(
//                 height:
//                     (MediaQuery.of(context).orientation == Orientation.portrait)
//                         ? MediaQuery.of(context).size.height / 3
//                         : MediaQuery.of(context).size.height / 6,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             //send video file
//                             reusableMediaIconButton(
//                                 title: 'Video',
//                                 bgColor: Colors.red,
//                                 icon: Icons.video_collection,
//                                 onPressed: () async {
//                                   if (mounted) {
//                                     setState(() {
//                                       _isLoading = true;
//                                     });
//                                   }
//                                   final pickedVideo = await ImagePicker()
//                                       .pickVideo(
//                                           source: ImageSource.gallery,
//                                           maxDuration:
//                                               const Duration(seconds: 15));

//                                   if (pickedVideo != null) {
//                                     // final uint8list =
//                                     //     await VideoThumbnail.thumbnailData(
//                                     //   video: pickedVideo.path,
//                                     //   imageFormat: ImageFormat.JPEG,
//                                     //   maxWidth:
//                                     //       128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//                                     //   quality: 25,
//                                     // );

//                                     Navigator.pop(context);
//                                     _sendVideoMessage(
//                                         videoPath: pickedVideo,
//                                         thumbnailPath: 'uint8list');
//                                   }
//                                   if (mounted) {
//                                     setState(() {
//                                       _isLoading = false;
//                                     });
//                                   }
//                                 }),

//                             //snap and send video file
//                             reusableMediaIconButton(
//                                 title: 'Cam Video',
//                                 bgColor: Colors.red,
//                                 icon: Icons.camera_rounded,
//                                 onPressed: () async {
//                                   if (mounted) {
//                                     setState(() {
//                                       _isLoading = true;
//                                     });
//                                   }
//                                   final pickedVideo = await ImagePicker()
//                                       .pickVideo(
//                                           source: ImageSource.camera,
//                                           maxDuration:
//                                               const Duration(seconds: 15));

//                                   if (pickedVideo != null) {
//                                     // final uint8list =
//                                     //     await VideoThumbnail.thumbnailData(
//                                     //   video: pickedVideo.path,
//                                     //   imageFormat: ImageFormat.JPEG,
//                                     //   maxWidth:
//                                     //       128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//                                     //   quality: 25,
//                                     // );
//                                     Navigator.pop(context);
//                                     _sendVideoMessage(
//                                         videoPath: pickedVideo,
//                                         thumbnailPath: 'unit8list');
//                                   }
//                                   if (mounted) {
//                                     setState(() {
//                                       _isLoading = false;
//                                     });
//                                   }
//                                 }),

//                             //send doc file
//                             reusableMediaIconButton(
//                                 title: 'Document',
//                                 bgColor: Colors.brown,
//                                 icon: Entypo.doc,
//                                 onPressed: () async {
//                                   await _pickDocFileFromStorage();
//                                 }),
//                           ]),
//                       const SizedBox(height: 15.0),
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             //send image file
//                             reusableMediaIconButton(
//                                 title: 'Image',
//                                 bgColor: Colors.green,
//                                 icon: Icons.image_rounded,
//                                 onPressed: () async {
//                                   final XFile? pickedImage = await ImagePicker()
//                                       .pickImage(
//                                           source: ImageSource.gallery,
//                                           imageQuality: 50);
//                                   if (pickedImage != null) {
//                                     Navigator.pop(context);
//                                     _sendImageMessage(imagePath: pickedImage);
//                                   }
//                                 }),
//                             //send image captured from camera
//                             reusableMediaIconButton(
//                                 title: 'Cam image',
//                                 bgColor: Colors.blue,
//                                 icon: Icons.camera_alt_rounded,
//                                 onPressed: () async {
//                                   final pickedImage = await ImagePicker()
//                                       .pickImage(
//                                           source: ImageSource.camera,
//                                           imageQuality: 50);
//                                   if (pickedImage != null) {
//                                     Navigator.pop(context);
//                                     _sendImageMessage(imagePath: pickedImage);
//                                   }
//                                 }),
//                             //send audio file
//                             reusableMediaIconButton(
//                                 title: 'Audio',
//                                 bgColor: Colors.yellow,
//                                 icon: Entypo.music,
//                                 onPressed: () async {
//                                   await _sendAudioFile();
//                                 }),
//                           ])
//                     ]),
//               ),
//             ));
//   }

// //reformats time with a seperator
//   Widget _timeFormat(String time) {
//     //start hour less than 10 with 0
//     if (int.parse(time.split(':')[0]) < 10) {
//       time = time.replaceRange(0, time.indexOf(':'), "0${time.split(":")[0]}");
//     }
//     //start minute less than 10 with 0
//     if (int.parse(time.split(':')[1]) < 10) {
//       time = time.replaceRange(
//           time.indexOf(":") + 1, time.length, "0${time.split(":")[1]}");
//     }
//     return Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13.0));
//   }

//   //message time UI
//   Widget _conversationMessageTime(String time, int index) {
//     return Container(
//       alignment: _conversationMessageHolder[index]
//           ? Alignment.centerLeft
//           : Alignment.centerRight,
//       margin: _conversationMessageHolder[index]
//           ? const EdgeInsets.only(
//               left: 5.0,
//               bottom: 5.0,
//               top: 5.0,
//             )
//           : const EdgeInsets.only(
//               right: 5.0,
//               bottom: 5.0,
//               top: 5.0,
//             ),
//       child: _timeFormat(time),
//     );
//   }

// //text message UI
//   Widget _textMessage(BuildContext context, int index) {
//     return Text(_allconversationMessages[index].keys.first,
//         style: const TextStyle(
//             fontSize: 15.0,
//             letterSpacing: 1.0,
//             wordSpacing: 1.0,
//             color: Colors.white));
//   }

// //image message UI
//   Widget _imageMessage(BuildContext context, int index) {
//     return GestureDetector(
//         child: Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.only(top: 6.0),
//             height: 300.0,
//             child: PinchZoom(
//               child:
//                   Image.file(File(_allconversationMessages[index].keys.first)),
//               resetDuration: const Duration(milliseconds: 100),
//               maxScale: 2.5,
//               onZoomStart: () {
//                 print('Start zooming');
//               },
//               onZoomEnd: () {
//                 print('Stop zooming');
//               },
//             )),
//         onTap: () {
//           Navigator.push(
//               context,
//               PageTransition(
//                   type: PageTransitionType.fade,
//                   child: Center(
//                     child: ImageViewScreen(
//                         imagePath: _allconversationMessages[index].keys.first,
//                         imageProviderCategory: ImageProviderCategory.fileImage),
//                   )));
//         });
//   }

//   //video message UI
//   Widget _videoMessage(BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () async {
//         //show available video players on device
//         final OpenResult openResult =
//             await OpenFile.open(_allconversationMessages[index].keys.first);
//         openFileResultStatus(openResult: openResult);
//       },
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             const Icon(Icons.video_file, size: 20.0, color: Colors.white),
//             const SizedBox(width: 20.0),
//             Expanded(
//                 child: Text(
//               _allconversationMessages[index].keys.first.split('/').last,
//               style: const TextStyle(color: Colors.white, letterSpacing: 1.0),
//             ))
//           ]),
//     );
//   }

//   //document message UI
//   Widget _documentMessage(BuildContext context, int index) {
//     return GestureDetector(
//         onTap: () async {
//           //show available doc viewers on device
//           final OpenResult openResult =
//               await OpenFile.open(_allconversationMessages[index].keys.first);
//           openFileResultStatus(openResult: openResult);
//         },
//         onLongPress: () async {},
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               const SizedBox(width: 20.0),
//               const Icon(Entypo.doc_text, size: 20, color: Colors.white),
//               const SizedBox(width: 20.0),
//               Expanded(
//                   child: Text(
//                 _allconversationMessages[index].keys.first.split('/').last,
//                 style: const TextStyle(color: Colors.white, letterSpacing: 1.0),
//               ))
//             ]));
//   }

//   //audio message UI
//   Widget _audioMessage(
//     BuildContext context,
//     int index,
//   ) {
//     return Row(
//       children: [
//         const SizedBox(
//           width: 13.0,
//         ),

//         //audio speed
//         Padding(
//           padding: const EdgeInsets.only(right: 11.0),
//           child: GestureDetector(
//             child: _lastAudioPlayingIndex != index
//                 ? const Icon(Icons.music_note, color: Colors.white, size: 20.0)
//                 : Text(
//                     '${_audioPlayingSpeed.toString().contains('.0') ? _audioPlayingSpeed.toString().split('.')[0] : _audioPlayingSpeed}x',
//                     style: const TextStyle(color: Colors.white, fontSize: 18.0),
//                   ),
//             onTap: () {
//               // print('Audio Play Speed Tapped');
//               if (mounted) {
//                 setState(() {
//                   if (_audioPlayingSpeed != 3.0) {
//                     _audioPlayingSpeed += 0.5;
//                   } else {
//                     _audioPlayingSpeed = 1.0;
//                   }

//                   _justAudioPlayer.setSpeed(_audioPlayingSpeed);
//                 });
//               }
//             },
//           ),
//         ),

//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(right: 5.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(
//                     top: 26.0,
//                   ),
//                   child: LinearPercentIndicator(
//                     percent: _justAudioPlayer.duration == null
//                         ? 0.0
//                         : _lastAudioPlayingIndex == index
//                             ? _currAudioPlayingTime /
//                                         _justAudioPlayer
//                                             .duration!.inMicroseconds
//                                             .ceilToDouble() <=
//                                     1.0
//                                 ? _currAudioPlayingTime /
//                                     _justAudioPlayer.duration!.inMicroseconds
//                                         .ceilToDouble()
//                                 : 0.0
//                             : 0,
//                     backgroundColor: Colors.white,
//                     progressColor: Colors.blue,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 7.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             _lastAudioPlayingIndex == index
//                                 ? _loadingTime
//                                 : '0:00',
//                             style: const TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.centerRight,
//                           child: Text(
//                             _lastAudioPlayingIndex == index
//                                 ? _totalDuration
//                                 : '',
//                             style: const TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         //play/pause button
//         GestureDetector(
//           onLongPress: () => _audioPlayButtonOnLongPressedAction(),
//           onTap: () => _audioPlayButtonOnTapAction(index),
//           child: Icon(
//             index == _lastAudioPlayingIndex
//                 ? _audioPlayerIcon
//                 : Icons.play_arrow_rounded,
//             color: Colors.white,
//             size: 20.0,
//           ),
//         ),
//       ],
//     );
//   }

//   //send text message
//   void _sendText() async {
//     if (mounted) {
//       setState(() {
//         _isLoading = true;
//       });
//     }

//     final String _messageTime =
//         "${DateTime.now().hour}:${DateTime.now().minute}";

//     //send  message data  to connected user on cloud firestore
//     await _cloudStoreDataManagement.sendMessageToConnection(
//         chatMessageType: ChatMessageType.text,
//         connectionUserName: widget.username,
//         sendMessageData: {
//           ChatMessageType.text.toString(): {
//             _messageController.text: _messageTime
//           }
//         });

//     if (mounted) {
//       setState(() {
//         _allconversationMessages.add({
//           _messageController.text: _messageTime,
//         });
//         _chatMessageCategoryHolder.add(ChatMessageType.text);
//         _conversationMessageHolder.add(false);
//         _isMessagePresent = false;
//         _showEmojiPicker = false; //ermoves the emoji picker
//         if (_chatBoxHeight == MediaQuery.of(context).size.height - 163 - 250) {
//           _chatBoxHeight += 250.0;
//         }
//         SystemChannels.textInput
//             .invokeMethod('TextInput.hide'); //hides the keyboard

//         // _scrollController.jumpTo(_scrollController.position.maxScrollExtent +
//         //     _amountToScroll(ChatMessageType.text));
//       });

//       //store current user's text message locally using the connection's username
//       await _localDatabase.insertMessageInUserTable(
//           profilePic: widget.profilePic,
//           userName: widget.username,
//           actualMessage: _messageController.text,
//           chatMessageTypes: ChatMessageType.text,
//           messageHolderType: MessageHolderType.me,
//           messageDateLocal: DateTime.now().toString().split(" ")[0],
//           messageTimeLocal: _messageTime);

//       _messageController.clear(); //clears the typed message

//     }

//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   //record voice note
//   void _recordVoiceNote() async {
//     try {
//       if (!await Permission.microphone.status.isGranted) {
//         final microphoneStatus = await Permission.microphone.request();
//         if (microphoneStatus != PermissionStatus.granted) {
//           await showPlatformToast(
//             child: const Text('Microphone permission required to record'),
//             context: context,
//           );
//         }
//       } //if request is granted
//       else {
//         //Checks if there's valid recording session. So if session is paused, this method will still return [true].
//         if (await _record.isRecording()) {
//           if (mounted) {
//             setState(() {
//               _hintText = 'Type Here...';
//             });
//           }
//           final String? recordedFilePath =
//               await _record.stop(); //stops recording and saves path

//           print("recorded voice note path : $recordedFilePath");
//           if (recordedFilePath != null) {
//             _sendVoiceNote(recordedFilePath);
//           }
//         } else {
//           if (mounted) {
//             setState(() {
//               _hintText = 'Recording....';
//             });
//           }
//           //Starts new recording session.
//           await _record
//               .start(
//                 path: '${_audioDirectory!.path}${DateTime.now()}.aac',
//               )
//               .then((value) => print("Recording"));
//         }
//       }
//     } catch (e) {
//       print("error in recording voice note ${e.toString()}");
//     }
//   }

//   //pick doc file from storage
//   Future<void> _pickDocFileFromStorage() async {
//     List<String> allowedExtensions = [
//       'pdf',
//       'doc',
//       'docx',
//       'ppt',
//       'pptx',
//       'c',
//       'ccp',
//       'py',
//       'text'
//     ];

//     try {
//       final FilePickerResult? filePickerResult = await FilePicker.platform
//           .pickFiles(
//               type: FileType.custom, allowedExtensions: allowedExtensions);

//       //if file has been selected
//       if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
//         Navigator.pop(context);
//         filePickerResult.files.forEach((file) async {
//           //if file extension is allowed
//           if (allowedExtensions.contains(file.extension)) {
//             if (mounted) {
//               setState(() {
//                 _isLoading = true;
//               });
//             }
//             final String _messageTime =
//                 '${DateTime.now().hour}:${DateTime.now().minute}';

//             //upload file and get the remote file path
//             final String? downloadedDocumentPath =
//                 await _cloudStoreDataManagement.uploadMediaToStorage(
//                     File(File(file.path.toString()).path),
//                     reference: 'chatDocuments/');

//             //send message data including remote file path to firestore
//             if (downloadedDocumentPath != null) {
//               await _cloudStoreDataManagement.sendMessageToConnection(
//                   connectionUserName: widget.username,
//                   sendMessageData: {
//                     ChatMessageType.document.toString(): {
//                       "${downloadedDocumentPath.toString()} + ${file.extension}":
//                           _messageTime
//                     }
//                   },
//                   chatMessageType: ChatMessageType.document);
//             }

//             if (mounted) {
//               setState(() {
//                 _allconversationMessages
//                     .add({File(file.path.toString()).path: _messageTime});
//                 _chatMessageCategoryHolder.add(ChatMessageType.document);
//                 _conversationMessageHolder.add(false);
//                 // _scrollController.jumpTo(
//                 //     _scrollController.position.maxScrollExtent +
//                 //         _amountToScroll(ChatMessageType.document));
//               });

//               //save audio file path, message time
//               await _localDatabase.insertMessageInUserTable(
//                   profilePic: widget.profilePic,
//                   userName: widget.username,
//                   actualMessage: File(file.path.toString()).path,
//                   chatMessageTypes: ChatMessageType.document,
//                   messageHolderType: MessageHolderType.me,
//                   messageDateLocal: DateTime.now().toString().split(" ")[0],
//                   messageTimeLocal: _messageTime);
//             }

//             if (mounted) {
//               setState(() {
//                 _isLoading = false;
//               });
//             }
//           } else {
//             await showPlatformToast(
//               child: const Text('Document format is not supported'),
//               context: context,
//             );
//           }
//         });
//       }
//     } catch (e) {
//       await showPlatformToast(
//         child: const Text('Some error occured'),
//         context: context,
//       );
//     }
//   }

//   //send voice note
//   Future<void> _sendVoiceNote(String recordedFilePath) async {
//     try {
//       //stop current playing audio file when a new audio file enters
//       if (_justAudioPlayer.duration != null) {
//         if (mounted) {
//           setState(() {
//             _justAudioPlayer.stop();
//             _audioPlayerIcon = Icons.play_arrow_rounded;
//           });
//         }
//       }

//       // set path of avoice note file to be played
//       await _justAudioPlayer.setFilePath(recordedFilePath);

//       //check if audio length is greater than 20mins
//       if (_justAudioPlayer.duration!.inMinutes > 20) {
//         await showPlatformToast(
//           child: const Text(
//               'Audio file duration can\'t be greater than 20 minutes'),
//           context: context,
//         );
//       } else {
//         //get messsage time
//         final String _messageTime =
//             "${DateTime.now().hour}:${DateTime.now().minute}";

//         //upload file and get the remote file path
//         final String? downloadedAudioPath = await _cloudStoreDataManagement
//             .uploadMediaToStorage(File(recordedFilePath),
//                 reference: 'chatAudio/');

//         //send message data including remote file path to firestore
//         if (downloadedAudioPath != null) {
//           await _cloudStoreDataManagement.sendMessageToConnection(
//               connectionUserName: widget.username,
//               sendMessageData: {
//                 ChatMessageType.audio.toString(): {
//                   downloadedAudioPath.toString(): _messageTime
//                 }
//               },
//               chatMessageType: ChatMessageType.audio);
//         }

//         if (mounted) {
//           setState(() {
//             _allconversationMessages.add({recordedFilePath: _messageTime});
//             _chatMessageCategoryHolder.add(ChatMessageType.audio);
//             _conversationMessageHolder.add(false);
//             // _scrollController.jumpTo(
//             //     _scrollController.position.maxScrollExtent +
//             //         _amountToScroll(ChatMessageType.audio));
//           });

//           //save audio file path, message time
//           await _localDatabase.insertMessageInUserTable(
//               profilePic: widget.profilePic,
//               userName: widget.username,
//               actualMessage: recordedFilePath,
//               chatMessageTypes: ChatMessageType.audio,
//               messageHolderType: MessageHolderType.me,
//               messageDateLocal: DateTime.now().toString().split(" ")[0],
//               messageTimeLocal: _messageTime);
//         }
//       }
//     } catch (e) {
//       await showPlatformToast(
//         child: const Text(' error in sending voice note'),
//         context: context,
//       );
//     }
//   }

//   //send voicenote and audio file
//   Future<void> _sendAudioFile() async {
//     try {
//       //allowed extensions
//       final List<String> _allowedExtensions = [
//         'mp3',
//         'm4a',
//         'wav',
//         'ogg',
//         'aac'
//       ];
//       //show file picker for audio files
//       final FilePickerResult? _audioFilePickerResult =
//           await FilePicker.platform.pickFiles(
//         type: FileType.audio,
//       );

//       Navigator.pop(context);

//       //if file has been selected, search all the elements for allowedExtensions
//       if (_audioFilePickerResult != null) {
//         _audioFilePickerResult.files.forEach((element) async {
//           //check if audio file extension is allowed
//           if (_allowedExtensions.contains(element.extension)) {
//             //stop current playing audio file when a new audio file enters
//             if (_justAudioPlayer.duration != null) {
//               if (mounted) {
//                 setState(() {
//                   _justAudioPlayer.stop();
//                   _audioPlayerIcon = Icons.play_arrow_rounded;
//                 });
//               }
//             }

//             // set path of audio file to be played
//             await _justAudioPlayer.setFilePath(element.path.toString());

//             //check if audio length is greater than 20mins
//             if (_justAudioPlayer.duration!.inMinutes > 20) {
//               await showPlatformToast(
//                 child: const Text(
//                     'Audio file duration can\'t be greater than 20 minutes'),
//                 context: context,
//               );
//             } else {
//               if (mounted) {
//                 setState(() {
//                   _isLoading = true;
//                 });
//               }

//               //get messsage time
//               final String _messageTime =
//                   "${DateTime.now().hour}:${DateTime.now().minute}";

//               //upload file and get the remote file path
//               final String? downloadedAudioPath =
//                   await _cloudStoreDataManagement.uploadMediaToStorage(
//                       File(element.path.toString()),
//                       reference: 'chatAudio/');

//               //send message data including remote file path to firestore
//               if (downloadedAudioPath != null) {
//                 await _cloudStoreDataManagement.sendMessageToConnection(
//                     connectionUserName: widget.username,
//                     sendMessageData: {
//                       ChatMessageType.audio.toString(): {
//                         downloadedAudioPath.toString(): _messageTime
//                       }
//                     },
//                     chatMessageType: ChatMessageType.audio);
//               }

//               if (mounted) {
//                 setState(() {
//                   _allconversationMessages
//                       .add({element.path.toString(): _messageTime});
//                   _chatMessageCategoryHolder.add(ChatMessageType.audio);
//                   _conversationMessageHolder.add(false);
//                   // _scrollController.jumpTo(
//                   //     _scrollController.position.maxScrollExtent +
//                   //         _amountToScroll(ChatMessageType.audio));
//                 });

//                 //save audio file path, message time
//                 await _localDatabase.insertMessageInUserTable(
//                     profilePic: widget.profilePic,
//                     userName: widget.username,
//                     actualMessage: element.path.toString(),
//                     chatMessageTypes: ChatMessageType.audio,
//                     messageHolderType: MessageHolderType.me,
//                     messageDateLocal: DateTime.now().toString().split(" ")[0],
//                     messageTimeLocal: _messageTime);
//               }

//               if (mounted) {
//                 setState(() {
//                   _isLoading = false;
//                 });
//               }
//             }
//           } else {
//             await showPlatformToast(
//               child: const Text('extension not allowed'),
//               context: context,
//             );
//           }
//         });
//       }
//     } catch (e) {
//       await showPlatformToast(
//         child: const Text(' error in sending audio'),
//         context: context,
//       );
//     }
//   }

//   //send video message
//   void _sendVideoMessage(
//       {required var videoPath, required String thumbnailPath}) async {
//     try {
//       if (mounted) {
//         setState(() {
//           _isLoading = true;
//         });
//       }

//       final String _messageTime =
//           "${DateTime.now().hour}:${DateTime.now().minute}";

//       //upload video file and get the remote file path
//       final String? downloadedVideoPath = await _cloudStoreDataManagement
//           .uploadMediaToStorage(File(videoPath.path), reference: 'chatVideos/');

//       //upload video thumbnail file and get the remote file path
//       final String? downloadedVideoThumbnailPath =
//           await _cloudStoreDataManagement.uploadMediaToStorage(
//               File(thumbnailPath),
//               reference: 'chatVideosThumbnail/');

//       //send message data including remote file path to firestore
//       if (downloadedVideoPath != null) {
//         await _cloudStoreDataManagement.sendMessageToConnection(
//             connectionUserName: widget.username,
//             sendMessageData: {
//               ChatMessageType.video.toString(): {
//                 "${downloadedVideoPath.toString()} + ${downloadedVideoThumbnailPath.toString()}":
//                     _messageTime
//               }
//             },
//             chatMessageType: ChatMessageType.video);
//       }

//       if (mounted) {
//         setState(() {
//           _allconversationMessages
//               .add({File(videoPath.path).path: _messageTime});

//           print(" video file :    ${File(videoPath.path).path.toString()}");

//           _chatMessageCategoryHolder.add(ChatMessageType.video);
//           _conversationMessageHolder.add(false);
//           // _scrollController.jumpTo(_scrollController.position.maxScrollExtent +
//           //     _amountToScroll(ChatMessageType.video));
//         });
//       }

//       //save audio file path, message time
//       await _localDatabase.insertMessageInUserTable(
//           profilePic: widget.profilePic,
//           userName: widget.username,
//           // actualMessage:downloadedVideoPath.toString() + downloadedThumbnailPath.toString()
//           actualMessage: File(videoPath.path).path,
//           chatMessageTypes: ChatMessageType.video,
//           messageHolderType: MessageHolderType.me,
//           messageDateLocal: DateTime.now().toString().split(" ")[0],
//           messageTimeLocal: _messageTime);

//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('error in sending video message ${e.toString()}');
//     }
//   }

//   //send image message
//   void _sendImageMessage({required var imagePath}) async {
//     try {
//       if (mounted) {
//         setState(() {
//           _isLoading = true;
//         });
//       }

//       final String _messageTime =
//           "${DateTime.now().hour}:${DateTime.now().minute}";

//       //upload file and get the remote file path
//       final String? downloadedImagePath = await _cloudStoreDataManagement
//           .uploadMediaToStorage(File(imagePath.path), reference: 'chatImage/');

//       //send message data including remote file path to firestore
//       if (downloadedImagePath != null) {
//         await _cloudStoreDataManagement.sendMessageToConnection(
//             connectionUserName: widget.username,
//             sendMessageData: {
//               ChatMessageType.image.toString(): {
//                 downloadedImagePath.toString(): _messageTime
//               }
//             },
//             chatMessageType: ChatMessageType.image);
//       }

//       if (mounted) {
//         setState(() {
//           _allconversationMessages.add({imagePath.path: _messageTime});

//           _chatMessageCategoryHolder.add(ChatMessageType.image);
//           _conversationMessageHolder.add(false);
//           // _scrollController.jumpTo(_scrollController.position.maxScrollExtent +
//           //     _amountToScroll(ChatMessageType.image));
//         });
//       }

//       //save audio file path, message time to local
//       await _localDatabase.insertMessageInUserTable(
//           profilePic: widget.profilePic,
//           userName: widget.username,
//           actualMessage: imagePath.path.toString(),
//           chatMessageTypes: ChatMessageType.image,
//           messageHolderType: MessageHolderType.me,
//           messageDateLocal: DateTime.now().toString().split(" ")[0],
//           messageTimeLocal: _messageTime);

//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('error in sending image file ${e.toString()}');
//     }
//   }

//   //
//   void _audioPlayButtonOnTapAction(int index) async {
//     try {
//       _justAudioPlayer.positionStream.listen((event) {
//         if (mounted) {
//           setState(() {
//             _currAudioPlayingTime = event.inMicroseconds.ceilToDouble();
//             _loadingTime =
//                 '${event.inMinutes} : ${event.inSeconds > 59 ? event.inSeconds % 60 : event.inSeconds}';
//           });
//         }
//       });
//       //listen for end of file
//       _justAudioPlayer.playerStateStream.listen((event) {
//         if (event.processingState == ProcessingState.completed) {
//           _justAudioPlayer.stop(); //stop the player
//           if (mounted) {
//             setState(() {
//               _loadingTime = '0:00'; //reset the play time to 0.00
//               _audioPlayerIcon = Icons.play_arrow_rounded;
//             });
//           }
//         }
//       });

//       if (_lastAudioPlayingIndex != index) {
//         await _justAudioPlayer
//             .setFilePath(_allconversationMessages[index].keys.first);

//         if (mounted) {
//           setState(() {
//             _lastAudioPlayingIndex = index;
//             _totalDuration =
//                 '${_justAudioPlayer.duration!.inMinutes} : ${_justAudioPlayer.duration!.inSeconds > 59 ? _justAudioPlayer.duration!.inSeconds % 60 : _justAudioPlayer.duration!.inSeconds}';
//             _audioPlayerIcon = Icons.pause;
//             _audioPlayingSpeed = 1.0;
//             _justAudioPlayer.setSpeed(_audioPlayingSpeed);
//           });
//         }

//         await _justAudioPlayer.play();
//       } else {
//         //print(_justAudioPlayer.processingState);
//         if (_justAudioPlayer.processingState == ProcessingState.idle) {
//           await _justAudioPlayer
//               .setFilePath(_allconversationMessages[index].keys.first);

//           if (mounted) {
//             setState(() {
//               _lastAudioPlayingIndex = index;
//               _totalDuration =
//                   '${_justAudioPlayer.duration!.inMinutes} : ${_justAudioPlayer.duration!.inSeconds}';
//               _audioPlayerIcon = Icons.pause;
//             });
//           }

//           await _justAudioPlayer.play();
//         } else if (_justAudioPlayer.playing) {
//           if (mounted) {
//             setState(() {
//               _audioPlayerIcon = Icons.play_arrow_rounded;
//             });
//           }

//           await _justAudioPlayer.pause();
//         } else if (_justAudioPlayer.processingState == ProcessingState.ready) {
//           if (mounted) {
//             setState(() {
//               _audioPlayerIcon = Icons.pause;
//             });
//           }

//           await _justAudioPlayer.play();
//         } else if (_justAudioPlayer.processingState ==
//             ProcessingState.completed) {}
//       }
//     } catch (e) {
//       // print('Audio Playing Error');
//       await showPlatformToast(
//         child: const Text('Audio file not found'),
//         context: context,
//       );
//     }
//   }

//   //
//   void _audioPlayButtonOnLongPressedAction() async {
//     if (_justAudioPlayer.playing) {
//       await _justAudioPlayer.stop();

//       if (mounted) {
//         setState(() {
//           // print('Audio Play Completed');
//           _justAudioPlayer.stop();
//           if (mounted) {
//             setState(() {
//               _loadingTime = '0:00';
//               _audioPlayerIcon = Icons.play_arrow_rounded;
//               _lastAudioPlayingIndex = -1;
//             });
//           }
//         });
//       }
//     }
//   }

//   //select message type i.e text, image, video
//   Widget _messageTypeSelector(BuildContext context, int index) {
//     if (_chatMessageCategoryHolder[index] == ChatMessageType.text) {
//       return _textMessage(context, index);
//     }
//     // else if (_chatMessageCategoryHolder[index] == ChatMessageType.image) {
//     //   return _imageMessage(context, index);
//     // }
//     else if (_chatMessageCategoryHolder[index] == ChatMessageType.video) {
//       return _videoMessage(context, index);
//     } else if (_chatMessageCategoryHolder[index] == ChatMessageType.document) {
//       return _documentMessage(context, index);
//     } else if (_chatMessageCategoryHolder[index] == ChatMessageType.audio) {
//       return _audioMessage(context, index);
//     }
//     return const Center();
//   }

// //open file result status
//   void openFileResultStatus({required OpenResult openResult}) async {
//     if (openResult.type == ResultType.permissionDenied) {
//       await showPlatformToast(
//         child: const Text('permission denied to open file'),
//         context: context,
//       );
//     } else if (openResult.type == ResultType.noAppToOpen) {
//       await showPlatformToast(
//         child: const Text('no app found to open'),
//         context: context,
//       );
//     } else if (openResult.type == ResultType.error) {
//       await showPlatformToast(
//         child: const Text('error in opening file'),
//         context: context,
//       );
//     } else if (openResult.type == ResultType.fileNotFound) {
//       await showPlatformToast(
//         child: const Text('Sorry, file not found'),
//         context: context,
//       );
//     }
//   }

// //type and send message
//   Widget _typeAndSendMessage() {
//     return SizedBox(
//       width: double.maxFinite,
//       height: 80.0,
//       child: Row(children: [
//         const SizedBox(width: 10.0),
//         Expanded(
//           child: Container(
//             decoration: const BoxDecoration(
//                 color: Color.fromARGB(26, 63, 2, 142),
//                 borderRadius: BorderRadius.all(Radius.circular(30.0))),
//             child: TextField(
//                 maxLines: null,
//                 controller: _messageController,
//                 onTap: () {
//                   if (mounted) {
//                     setState(() {
//                       // _chatBoxHeight += 300;
//                       _showEmojiPicker = false;
//                     });
//                   }
//                 },
//                 onChanged: (text) {
//                   if (mounted) {
//                     setState(() {
//                       // || _onlyContainSpaceChars(text.toString())
//                       (text.isEmpty)
//                           ? _isMessagePresent = false
//                           : _isMessagePresent = true;
//                     });
//                   }
//                 },
//                 style: const TextStyle(
//                     color: Colors.black, letterSpacing: 1.0, fontSize: 16.0),
//                 decoration: InputDecoration(
//                   prefixIcon: IconButton(
//                       icon: const Icon(Icons.emoji_emotions_outlined,
//                           size: 25.0, color: Color.fromARGB(255, 43, 148, 235)),
//                       onPressed: () {
//                         if (mounted) {
//                           setState(() {
//                             SystemChannels.textInput
//                                 .invokeMethod('TextInput.hide');

//                             if (_chatBoxHeight !=
//                                 MediaQuery.of(context).size.height -
//                                     175 -
//                                     250) {
//                               _chatBoxHeight -= 250.0;
//                             } else {
//                               _chatBoxHeight += 250.0;
//                             }
//                             _showEmojiPicker = !_showEmojiPicker;
//                           });
//                         }
//                       }),
//                   suffixIcon: IconButton(
//                       icon: const Icon(Icons.link_rounded,
//                           size: 25.0, color: Colors.blue),
//                       onPressed: () {
//                         _chatMediaOptions();
//                       }),
//                   hintText: _hintText,
//                   // fillColor: Colors.blue,
//                   //filled: true,
//                   focusColor: null,

//                   hintStyle: const TextStyle(
//                       color: Colors.grey, fontSize: 18.0, letterSpacing: 1.0),
//                   enabledBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                       borderSide: BorderSide(color: Colors.transparent)),
//                   focusedBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                       borderSide: BorderSide(color: Colors.transparent)),
//                 )),
//           ),
//         ),
//         const SizedBox(width: 10.0),
//         //send text message button
//         Container(
//           decoration:
//               const BoxDecoration(gradient: kGradient, shape: BoxShape.circle),
//           child: IconButton(
//               onPressed: () {
//                 _isMessagePresent ? ChatBloc.get(context).sendMessage(
//                                           receiveId: userModel!.uId!,
//                                           dateTime: DateTime.now().toString(),
//                                           text: _messageController.text,
//                                           profilePic: userModel!.!
//                                       ) : _recordVoiceNote();
//               },
//               icon: _isMessagePresent
//                   ? const Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 23.0,
//                     )
//                   : const Icon(
//                       Icons.keyboard_voice_rounded,
//                       color: Colors.white,
//                       size: 23.0,
//                     )),
//         ),

//         const SizedBox(width: 10.0),
//       ]),
//     );
//   }

//   //show emoji
//   Widget _showEmoji() {
//     Size _size = MediaQuery.of(context).size;
//     return SizedBox(
//         height: 250,
//         width: _size.width,
//         child: EmojiPicker(
//           onEmojiSelected: (category, emoji) {
//             if (mounted) {
//               setState(() {
//                 _messageController.text += emoji.emoji;
//                 _messageController.text.isEmpty
//                     ? _isMessagePresent = false
//                     : _isMessagePresent = true;
//               });
//             }
//           },
//           onBackspacePressed: () {},
//           config: const Config(
//               columns: 7,
//               emojiSizeMax: 28.0,
//               verticalSpacing: 0,
//               horizontalSpacing: 0.0,
//               initCategory: Category.RECENT,
//               bgColor: Colors.white,
//               indicatorColor: Colors.blue,
//               iconColor: Colors.grey,
//               iconColorSelected: Colors.blue,
//               progressIndicatorColor: Colors.blue,
//               showRecentsTab: true,
//               recentsLimit: 28,
//               noRecentsStyle: TextStyle(fontSize: 20, color: Colors.black),
//               noRecentsText: 'no recents',
//               categoryIcons: CategoryIcons(),
//               buttonMode: ButtonMode.MATERIAL),
//         ));
//   }

//   //chat bubble
//   Widget _chatBubble({required bool isSender, required Widget child}) {
//     if (isSender) {
//       return Bubble(
//         margin: const BubbleEdges.only(top: 10),
//         nip: BubbleNip.rightTop,
//         color: kOutGoingMessage,
//         child: child,
//       );
//     } else {
//       return Bubble(
//         margin: const BubbleEdges.only(top: 10),
//         nip: BubbleNip.leftTop,
//         color: kInComingMessage,
//         child: child,
//       );
//     }
//   }

//   //check if the message field contains only space characters
//   // bool _onlyContainSpaceChars(String message) {
//   //   List<bool> list = [];
//   //   bool isOnlySpaceChars = false;

//   //   for (int i = 0; i < message.length; i++) {
//   //     if (message[i] == " ") {
//   //       list.add(true);
//   //     } else {
//   //       list.add(false);
//   //     }
//   //   }

//   //   if (!list.contains(false)) {
//   //     isOnlySpaceChars = true;
//   //   }

//   //   return isOnlySpaceChars;
//   // }
// }





// // import 'dart:io';

// // import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:just_audio/just_audio.dart';
// // import 'package:record/record.dart';
// // import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
// // import 'package:revenge_platform/blocs/chat_bloc/states.dart';
// // import 'package:revenge_platform/components/constants/constants.dart';
// // import 'package:revenge_platform/components/default_form_field.dart';
// // import 'package:revenge_platform/components/styles/colors.dart';
// // import 'package:revenge_platform/components/widgets/state_widgets.dart';
// // import 'package:revenge_platform/models/chat.dart';
// // import 'package:revenge_platform/models/user.dart';

// // class ChatDetailsScreen extends StatelessWidget {

// //   UserModel? userModel;

// //   ChatDetailsScreen({
// //     this.userModel,
// //   });

// //   var messageController = TextEditingController();
// //  bool _isMessagePresent = false; // message presence in the textfield
// //   bool _showEmojiPicker = false;
// //     final ScrollController _scrollController =
// //       ScrollController(initialScrollOffset: 0.0);
// //       final AudioPlayer _justAudioPlayer = AudioPlayer();
      
// //   final Record _record = Record(); //record voice note
// //   Directory? _audioDirectory; //directory to save audio files
// //   late double _currAudioPlayingTime;
// //   int _lastAudioPlayingIndex = 0;
// //   double _audioPlayingSpeed = 1.0;
// //   String _totalDuration = '0:00';
// //   String _loadingTime = '0:00';
// //   IconData _audioPlayerIcon = Icons.play_arrow_outlined;


// //   @override
// //   Widget build(BuildContext context) {
// //     return Builder(
// //       builder: (BuildContext context) {
// //         ChatBloc.get(context).getMessages(receiveId: userModel!.uId!);
// //         return BlocConsumer<ChatBloc, ChatStates>(
// //           listener: (context, state) {},
// //           builder: (context, state) {
// //             return Scaffold(
// //               backgroundColor: Theme.of(context).cardColor,
// //               appBar: AppBar(
// //                 titleSpacing: 0.0,
// //                 elevation: .4,
// //                 leading: IconButton(
// //                   icon: Icon(Icons.arrow_back_ios),
// //                   onPressed: () => Navigator.pop(context),
// //                 ),
// //                 title: InkWell(
// //                   onTap: () {},
// //                   child: Row(
// //                     children: [
// //                         Stack(
// //                           children: [
// //                           if(userModel!.image != '')
// //                              CircleAvatar(
// //                               radius: 20.0,
// //                               backgroundImage: NetworkImage(userModel!.image!),
// //                             ),

// //                            if(userModel!.image == '')
// //                               CircleAvatar(
// //                                 radius: 20.0,
// //                                 child: Text(userModel!.fullName!.substring(0, 3)),
// //                               ),

// //                             Positioned(
// //                               bottom: 0.0,
// //                               left: 6.0,
// //                               child: Container(
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white,
// //                                   borderRadius: BorderRadius.circular(6),
// //                                 ),
// //                                 height: 11,
// //                                 width: 11,
// //                                 child: Center(
// //                                   child: Container(
// //                                     decoration: BoxDecoration(
// //                                       color: userModel!.isOnline
// //                                           ?Colors.greenAccent
// //                                           :Colors.grey,
// //                                       borderRadius: BorderRadius.circular(6),
// //                                     ),
// //                                     height: 7,
// //                                     width: 7,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ]
// //                         ),
// //                       SizedBox(
// //                         width: 15.0,
// //                       ),
// //                       Column(
// //                         mainAxisAlignment: MainAxisAlignment.start,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                               userModel!.fullName!,
// //                               style: Theme.of(context).textTheme.headline3,
// //                               overflow: TextOverflow.ellipsis,
// //                           ),
// //                           Text(
// //                               "online",
// //                               style: Theme.of(context).textTheme.caption,
// //                               overflow: TextOverflow.ellipsis,
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 actions: [
// //                   IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
// //                 ],
// //               ),
// //               body: ConditionalBuilder(
// //                 condition: state is! ChatGetMessageLoadingState,
// //                 builder: (context) => ConditionalBuilder(
// //                   condition: 1 > 0,
// //                   builder: (context) => Padding(
// //                     padding: const EdgeInsets.all(20.0),
// //                     child: Column(
// //                       children:
// //                       [
// //                         Expanded(
// //                           child: ListView.separated(
// //                             physics: BouncingScrollPhysics(),
// //                               itemBuilder: (context, index) {
// //                                 var message = ChatBloc.get(context).messages[index];
// //                                 if(userId == message.senderId) {
// //                                   return buildMessage(context, message, false);
// //                                 }
// //                                 return buildMessage(context, message, true);
// //                               },
// //                               separatorBuilder: (context, state) => SizedBox(
// //                                 height: 15.0,
// //                               ),
// //                               itemCount: ChatBloc.get(context).messages.length
// //                           ),
// //                         ),
// //                         Container(
// //                           child: Row(
// //                             children: [
// //                               Expanded(
// //                                 child: DefaultFormField(
// //                                   controller: messageController,
// //                                   borderColor: Colors.grey.shade400,
// //                                   hintText: "Type message here...",
// //                                   borderWidth: 20,
// //                                   validate: (String? msg) {
// //                                     if(msg != null && msg != '') {
// //                                       return 'false';
// //                                     }
// //                                     return "true";
// //                                   },
// //                                 ),
// //                               ),
// //                               const SizedBox(width: 7,),
// //                               CircleAvatar(
// //                                 child: MaterialButton(
// //                                   onPressed: () {
// //                                     if(messageController.value != null && messageController.value != '') {
// //                                       ChatBloc.get(context).sendMessage(
// //                                           receiveId: userModel!.uId!,
// //                                           dateTime: DateTime.now().toString(),
// //                                           text: messageController.text
// //                                       );
// //                                     }
// //                                   },
// //                                   child: Icon(
// //                                     Icons.send,
// //                                     size: 20.0,
// //                                     color: Colors.white,
// //                                   ),
// //                                 ),
// //                                 backgroundColor: Colors.blue,
// //                                 radius: 25,
// //                               ),
// //                             ],
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                   fallback: (context) => Center(child: EmptyChatsWidget(),),
// //                 ),
// //                   fallback: (context) => Center(child: CircularProgressIndicator(),),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   Widget buildMessage(context, MessageModel model, isSender) =>  Align(
// //     alignment: isSender ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd,
// //     child: Container(
// //       decoration: BoxDecoration(
// //           color: !isSender ? Colors.blue : Colors.grey[300],
// //           borderRadius: const BorderRadiusDirectional.only(
// //             bottomEnd: Radius.circular(10.0),
// //             topStart: Radius.circular(10.0),
// //             topEnd: Radius.circular(10.0),
// //           )
// //       ),
// //       padding: const EdgeInsets.symmetric(
// //         vertical: 5.0,
// //         horizontal: 10.0,
// //       ),
// //       child: Text(
// //         model.text!,
// //         style: Theme.of(context).textTheme.bodyText2!.copyWith(
// //           color: !isSender ? Colors.white : Colors.black
// //         ),
// //       ),

// //     ),
// //   );
// // }
