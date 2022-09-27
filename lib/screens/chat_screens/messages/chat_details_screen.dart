import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
import 'package:revenge_platform/blocs/chat_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/default_form_field.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/state_widgets.dart';
import 'package:revenge_platform/models/chat.dart';
import 'package:revenge_platform/models/user.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:revenge_platform/screens/profile/profile_home_base.dart';

class ChatDetailsScreen extends StatefulWidget {
  UserModel? userModel;

  ChatDetailsScreen({
    this.userModel,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var messageController = TextEditingController();

  bool _isMessagePresent = false; 
 // message presence in the textfield
  bool _showEmojiPicker = false;

  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0);

  final AudioPlayer _justAudioPlayer = AudioPlayer();
  double _chatBoxHeight = 0.0;

  final Record _record = Record(); 
 //record voice note
  Directory? _audioDirectory; 
 //directory to save audio files
  late double _currAudioPlayingTime;

  int _lastAudioPlayingIndex = 0;

  double _audioPlayingSpeed = 1.0;

  String _totalDuration = '0:00';

  String _loadingTime = '0:00';

  IconData _audioPlayerIcon = Icons.play_arrow_outlined;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        ChatBloc.get(context).getMessages(receiveId: widget.userModel!.uId!);
        return BlocConsumer<ChatBloc, ChatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ChatBloc cubit = ChatBloc.get(context);
            return Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              appBar: AppBar(
                titleSpacing: 0.0,
                elevation: .4,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: InkWell(
                  onTap: () {
                    navigateTo(context, ProfileHomeBase());
                  },
                  child: Row(
                    children: [
                      Stack(children: [
                        if (widget.userModel!.image != '')
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(widget.userModel!.image!),
                          ),
                        if (widget.userModel!.image == '')
                          CircleAvatar(
                            radius: 20.0,
                            child: Text(widget.userModel!.fullName!.substring(0, 3)),
                          ),
                        Positioned(
                          bottom: 0.0,
                          left: 6.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            height: 11,
                            width: 11,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: widget.userModel!.isOnline
                                      ? Colors.greenAccent
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 7,
                                width: 7,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userModel!.fullName!,
                            style: Theme.of(context).textTheme.headline3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "online",
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                ],
              ),
              body: ConditionalBuilder(
                condition: state is! ChatGetMessageLoadingState,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ConditionalBuilder(
                          condition: 1 > 0,
                          builder: (context) => ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message =
                                    ChatBloc.get(context).messages[index];
                                if (userId == message.senderId) {
                                  return buildMessage(context, message, false);
                                }
                                return buildMessage(context, message, true);
                              },
                              separatorBuilder: (context, state) => SizedBox(
                                    height: 15.0,
                                  ),
                              itemCount: ChatBloc.get(context).messages.length),
                          fallback: (context) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SendMessageWidget(),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 15.0, end: 15.0),
                                child: Text(
                                    "Not found any messages, write messages using input field below.",
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.link_rounded,
                                    size: 25.0, color: Colors.blue),
                                onPressed: () {
                                  _chatMediaOptions(context, cubit);
                                }),
                            IconButton(
                                icon: const Icon(Icons.image_outlined,
                                    size: 25.0, color: Colors.blue),
                                onPressed: () async {
                                  final XFile? pickedImage = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50);
                                  if (pickedImage != null) {
                                    Navigator.pop(context);
                                    // _sendImageMessage(imagePath: pickedImage);
                                  }
                                }),
                            IconButton(
                              icon: const Icon(
                                Icons.keyboard_voice_rounded,
                                color: Colors.blue,
                                size: 23.0,
                              ),
                              onPressed: () {},
                            ),
                            Expanded(
                              child: DefaultFormField(
                                controller: messageController,
                                borderColor: Colors.grey.shade400,
                                hintText: "Type message here...",
                                borderWidth: 50,
                                maxLines: null,
                                prefix: Icons.emoji_emotions_outlined,
                                prefixColorIcon: Colors.blue,
                                onChange: (text) {
                                  if (mounted) {
                                    setState(() {
                                      // || _onlyContainSpaceChars(text.toString())
                                      (text.isEmpty)
                                          ? _isMessagePresent = false
                                          : _isMessagePresent = true;
                                    });
                                  }
                                },
                                prefixPressed: () {
                                  if (mounted) {
                                    setState(() {
                                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                                      _showEmojiPicker = !_showEmojiPicker;
                                    });
                                  }
                                },
                                style: const TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1.0,
                                    fontSize: 16.0),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            CircleAvatar(
                              child: MaterialButton(
                                onPressed: () {
                                  if (messageController.value != null &&
                                      messageController.value != '') {
                                    ChatBloc.get(context).sendMessage(
                                      receiveId: widget.userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                      profilePic: widget.userModel!.image!,
                                    );
                                  }
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.send,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.blue,
                              radius: 25,
                            ),
                          ],
                        ),
                      ),
                      if (_showEmojiPicker) _showEmoji(context),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(context, MessageModel model, isSender){
    return Align(
        alignment: isSender
            ? AlignmentDirectional.centerStart
            : AlignmentDirectional.centerEnd,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,  
          children: [
            Container(
              decoration: BoxDecoration(
                  color: !isSender ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(!isSender ? 0.0 : 10),
                    bottomStart: Radius.circular(!isSender ? 10.0 : 0.0),
                    topStart: const Radius.circular(10.0),
                    topEnd: const Radius.circular(10.0),
                  )),
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                model.text!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: !isSender ? Colors.white : Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 3,),
            Text(
              "02:00 am", 
              style: const TextStyle(color: Colors.grey, fontSize: 13.0),
              textAlign: TextAlign.end,  
            ),
          ],
        ),
      );
  }

        //reformats time with a seperator
  Widget _timeFormat(String time) {
    //start hour less than 10 with 0
    if (int.parse(time.split(':')[0]) < 10) {
      time = time.replaceRange(0, time.indexOf(':'), "0${time.split(":")[0]}");
    }
    //start minute less than 10 with 0
    if (int.parse(time.split(':')[1]) < 10) {
      time = time.replaceRange(
          time.indexOf(":") + 1, time.length, "0${time.split(":")[1]}");
    }
    return Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13.0));
  }

  //media file icon Button
  Widget reusableMediaIconButton(
      {required String title,
      required Color bgColor,
      required IconData icon,
      required Function() onPressed}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircleAvatar(
          radius: 20.0,
          backgroundColor: bgColor,
          child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 20.0,
                color: Colors.white,
              ))),
      const SizedBox(height: 2.0),
      Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 12.0),
      )
    ]);
  }

  Widget _showEmoji(context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
        height: 250,
        width: _size.width,
        child: EmojiPicker(
          onEmojiSelected: (category, emoji) {
            if (mounted) {
              setState(() {
                messageController.text += emoji.emoji;
                messageController.text.isEmpty
                    ? _isMessagePresent = false
                    : _isMessagePresent = true;
              });
            }
          },
          onBackspacePressed: () {},
          config: const Config(
              columns: 7,
              emojiSizeMax: 28.0,
              verticalSpacing: 0,
              horizontalSpacing: 0.0,
              initCategory: Category.RECENT,
              bgColor: Colors.white,
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              progressIndicatorColor: Colors.blue,
              showRecentsTab: true,
              recentsLimit: 28,
              // noRecentsStyle: TextStyle(fontSize: 20, color: Colors.black),
              // noRecentsText: 'no recents',
              categoryIcons: CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL),
        ));
  }

  //send media files
  void _chatMediaOptions(context, cubit) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 5.0,
              backgroundColor: Colors.white,
              content: SizedBox(
                height:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? MediaQuery.of(context).size.height / 3
                        : MediaQuery.of(context).size.height / 6,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //send video file
                            reusableMediaIconButton(
                                title: 'Video',
                                bgColor: Colors.red,
                                icon: Icons.video_collection,
                                onPressed: () async {
                                  // if (mounted) {
                                  //   // setState(() {
                                  //   //   _isLoading = true;
                                  //   // });
                                  // }
                                  final pickedVideo = await ImagePicker()
                                      .pickVideo(
                                          source: ImageSource.gallery,
                                          maxDuration:
                                              const Duration(seconds: 15));

                                  if (pickedVideo != null) {
                                    // final uint8list =
                                    //     await VideoThumbnail.thumbnailData(
                                    //   video: pickedVideo.path,
                                    //   imageFormat: ImageFormat.JPEG,
                                    //   maxWidth:
                                    //       128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                                    //   quality: 25,
                                    // );

                                    Navigator.pop(context);
                                    cubit.sendVideoMessage(
                                        videoPath: pickedVideo,
                                        thumbnailPath: 'uint8list');
                                  }
                                  // if (mounted) {
                                  //   setState(() {
                                  //     _isLoading = false;
                                  //   });
                                  // }
                                }),

                            //snap and send video file
                            reusableMediaIconButton(
                                title: 'Cam Video',
                                bgColor: Colors.red,
                                icon: Icons.camera_rounded,
                                onPressed: () async {
                                  // if (mounted) {
                                  //   setState(() {
                                  //     _isLoading = true;
                                  //   });
                                  // }
                                  final pickedVideo = await ImagePicker()
                                      .pickVideo(
                                          source: ImageSource.camera,
                                          maxDuration:
                                              const Duration(seconds: 15));

                                  if (pickedVideo != null) {
                                    // final uint8list =
                                    //     await VideoThumbnail.thumbnailData(
                                    //   video: pickedVideo.path,
                                    //   imageFormat: ImageFormat.JPEG,
                                    //   maxWidth:
                                    //       128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                                    //   quality: 25,
                                    // );
                                    Navigator.pop(context);
                                    cubit.sendVideoMessage(
                                        videoPath: pickedVideo,
                                        thumbnailPath: 'unit8list');
                                  }
                                  // if (mounted) {
                                  //   setState(() {
                                  //     _isLoading = false;
                                  //   });
                                  // }
                                }),

                            //send doc file
                            reusableMediaIconButton(
                                title: 'Document',
                                bgColor:Colors.brown,
                                icon: Entypo.doc,
                                onPressed: () async {
                                  // await _pickDocFileFromStorage();
                                }),
                          ]),
                      const SizedBox(height: 15.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //send image file
                            reusableMediaIconButton(
                                title: 'Image',
                                bgColor: Colors.green,
                                icon: Icons.image_rounded,
                                onPressed: () async {
                                  final XFile? pickedImage = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50);
                                  if (pickedImage != null) {
                                    Navigator.pop(context);
                                    // _sendImageMessage(imagePath: pickedImage);
                                  }
                                }),
                            //send image captured from camera
                            reusableMediaIconButton(
                                title: 'Cam image',
                                bgColor: Colors.blue,
                                icon: Icons.camera_alt_rounded,
                                onPressed: () async {
                                  final pickedImage = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 50);
                                  if (pickedImage != null) {
                                    Navigator.pop(context);
                                    // _sendImageMessage(imagePath: pickedImage);
                                  }
                                }),
                            //send audio file
                            reusableMediaIconButton(
                                title: 'Audio',
                                bgColor: Colors.yellow,
                                icon: Entypo.music,
                                onPressed: () async {
                                  // await _sendAudioFile();
                                }),
                          ])
                    ]),
              ),
            ));
  }
}
