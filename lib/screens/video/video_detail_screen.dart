import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:revenge_platform/components/widgets/channel_info.dart';
import 'package:revenge_platform/screens/layout_of_app.dart';
import 'package:revenge_platform/test_json_data.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  String? thumbnail;
  String? title;
  String? viewCount;
  String? dayAgo;
  String? username;
  String? profile;
  String? subscribeCount;
  String? likeCount;
  String? unlikeCount;
  String? videoUrl;

  VideoDetailPage(
      {Key? key,
      this.thumbnail,
      this.title,
      this.viewCount,
      this.dayAgo,
      this.username,
      this.profile,
      this.subscribeCount,
      this.likeCount,
      this.unlikeCount,
      this.videoUrl})
      : super(key: key);
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  bool isSwitched = true;

  // for video player
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  
  //The values that are passed when changing quality
  Duration? newCurrentPosition;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
    _chewieController!.dispose();
  }

  Future<void> initializePlayer() async {
    _controller =
        VideoPlayerController.asset(widget.videoUrl!);
    await Future.wait([
      _controller!.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    final subtitles = [
      Subtitle(
        index: 0,
        start: Duration.zero,
        end: const Duration(seconds: 10),
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Hello',
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
            TextSpan(
              text: ' from ',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            TextSpan(
              text: 'subtitles',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            )
          ],
        ),
      ),
      Subtitle(
        index: 0,
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 20),
        text: 'Whats up? :)',
        // text: const TextSpan(
        //   text: 'Whats up? :)',
        //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
        // ),
      ),
    ];

    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: true,

      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
          OptionItem(
            onTap: toggleVideo,
            iconData: LineIcons.download,
            title: 'Download',
          ),
          OptionItem(
            onTap: toggleVideo,
            iconData: LineIcons.plus,
            title: 'Save',
          ),
        ];
      },
      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      hideControlsTimer: const Duration(seconds: 1),

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _controller!.pause();
    currPlayIndex = _controller == 0 ? 1 : 0;
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b1c1e),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints.expand(),
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                _chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                    ? Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: Chewie(
                              controller: _chewieController!,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsetsDirectional.only(end: 10),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      LineIcons.heart,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      widget.likeCount.toString(),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      LineIcons.comment,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      widget.unlikeCount.toString(),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Icon(
                                    LineIcons.share,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(
                        width: size.width,
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.thumbnail!),
                                fit: BoxFit.contain)),
                      ),
                Expanded(
                    child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size.width - 80,
                                    child: Text(
                                      widget.title!,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                          height: 1.3),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        LineIcons.angleDown,
                                        color: Colors.white.withOpacity(0.7),
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    widget.viewCount.toString() +
                                        " views ⬤ " +
                                        widget.dayAgo!,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ChannelInfo(
                          channel: null,
                          channelId: "id",
                          isOnVideo: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Up next",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.4),
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Autoplay",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.4),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Switch(
                                      value: isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                      })
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(home_video_detail.length,
                                  (index) {
                                return GestureDetector(
                                  onTap: () {
                                    // _startPlay(home_video_detail[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              (MediaQuery.of(context).size.width -
                                                      50) /
                                                  2,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      home_video_detail[index]
                                                          ['thumnail_img']),
                                                  fit: BoxFit.cover)),
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned(
                                                bottom: 10,
                                                right: 12,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(3.0),
                                                    child: Text(
                                                      home_video_detail[index]
                                                          ['video_duration'],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white
                                                              .withOpacity(0.4)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        130) /
                                                    2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      home_video_detail[index]
                                                          ['title'],
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.9),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.3,
                                                          fontSize: 14),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      home_video_detail[index]
                                                          ['username'],
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.4),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          home_video_detail[index]
                                                              ['view_count'] + " views",
                                                          style: TextStyle(
                                                              color: Colors.white
                                                                  .withOpacity(
                                                                      0.4),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                LineIcons.verticalEllipsis,
                                                color:
                                                    Colors.white.withOpacity(0.4),
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 6, top: 4),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white.withOpacity(.5),),
                  onPressed: () {
                    Navigator.pop(context);
                   
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _clearPrevious() async {
    await _controller!.pause();
    return true;
  }

}
