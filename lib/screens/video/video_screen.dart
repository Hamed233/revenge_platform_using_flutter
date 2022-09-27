import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_text/custom_text.dart';
import 'package:custom_text/custom_text_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/extensions/context.dart';
import 'package:revenge_platform/components/extensions/extensions.dart';
import 'package:revenge_platform/components/video_component.dart';
import 'package:revenge_platform/components/widgets/build_comment_box.dart';
import 'package:revenge_platform/components/widgets/channel_info.dart';
import 'package:revenge_platform/components/widgets/description_widgets.dart';
import 'package:revenge_platform/components/widgets/get_circular_progress_indicator.dart';
import 'package:revenge_platform/components/widgets/icon_with_bottom_label.dart';
import 'package:revenge_platform/components/widgets/popover.dart';
import 'package:revenge_platform/components/widgets/ps_body.dart';
import 'package:revenge_platform/components/widgets/show_download_widget.dart';
import 'package:revenge_platform/components/widgets/video_player.dart';
import 'package:revenge_platform/components/widgets/vlc_player.dart'
    as vlc_player;
import 'package:revenge_platform/providers/liked_list.dart';
import 'package:revenge_platform/providers/playlist.dart';
import 'package:share_plus/share_plus.dart';

import "package:timeago/timeago.dart" as timeago;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
    required this.video,
    this.videoId,
    this.loadData = false,
  })
  : assert(
          videoId != null || video != null,
          "VideoId and video both can't be null",
        ),
        super(key: key);

  final Video? video;
  final String? videoId;
  final bool loadData;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();

    final isLiked = null;

    void updateLike() {
      isLiked!.value = !isLiked.value;

      if (isLiked.value) {
        // likedList.addVideo(videoData!.url);
      } else {
        // likedList.removeVideo(videoData!.url);
      }
    }

    return Scaffold(
      body: Container(
    child: Column(
      children: [
        Container(
          height: 350,
          width: double.infinity,
          child: Image.asset("assets/images/app_logo.png"),
        ),
        Flexible(
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding:
                        const EdgeInsets
                            .all(
                      12,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          "Title",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '200 views',
                            ),
                            Text(
                              ' . 12 days ago',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        iconWithBottomLabel(
                          icon: 
                          // isLiked
                          //         .value
                          //     ? Icons
                          //         .thumb_up
                          //     : 
                              Icons
                                  .thumb_up_outlined,
                          onPressed:
                              updateLike,
                          label: "899",
                        ),
                        iconWithBottomLabel(
                          icon: Icons
                              .share_outlined,
                          onPressed: () {
                            // Share.share(
                            //   videoData
                            //       .url,
                            // );
                          },
                          label: "share",
                        ),
                        iconWithBottomLabel(
                          icon: Icons
                              .download_outlined,
                          // onPressed: downloadsSideWidget
                          //             .value !=
                          //         null
                          //     ? () =>
                          //         downloadsSideWidget.value =
                          //             null
                          //     : () {
                          //         commentSideWidget.value =
                          //             null;
                          //         downloadsSideWidget.value =
                          //             ShowDownloadsWidget(
                          //           manifest:
                          //               snapshot.data,
                          //           downloadsSideWidget:
                          //               downloadsSideWidget,
                          //           // videoData:
                          //           //     videoData,
                          //         );
                          //       },
                          label: "download",
                        ),
                        iconWithBottomLabel(
                          icon:
                              Icons.copy,
                          onPressed: () {
                            // Clipboard
                            //     .setData(
                            //   ClipboardData(
                            //     text: videoData
                            //         .url,
                            //   ),
                            // );
                            BotToast
                                .showText(
                              text: "copiedToClipboard",
                            );
                          },
                          label: "copy link",
                        ),
                        iconWithBottomLabel(
                          icon: LucideIcons
                              .listPlus,
                          onPressed: () {
                            showPopoverWB<
                                dynamic>(
                              context:
                                  context,
                              cancelText: "done",
                              hideConfirm:
                                  true,
                              controller:
                                  _textController,
                              title: "save",
                              hint: "createNew",
                              onConfirm:
                                  () {
                                // ref
                                //     .read(
                                //       playlistProvider.notifier,
                                //     )
                                //     .addPlaylist(
                                //       _textController.value.text,
                                //     );
                                _textController
                                        .value =
                                    TextEditingValue
                                        .empty;
                              },
                              // builder:
                                  // (ctx) =>
                                //       PlaylistPopup(
                                // videoData:
                                //     videoData,
                              // ),
                            );
                          },
                          label: "save",
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ChannelInfo(
                    channel: null,
                    channelId: "id",
                    isOnVideo: true,
                  ),
                  const Divider(
                    height: 4,
                  ),
                  const SizedBox(height: 30,),
                  Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 20,
                      padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              mainAxisExtent: 310,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0),
                      itemBuilder:
                          (BuildContext context, int index) {
                        return const VideoComponent();
                      }),
                  ),
                  // ListTile(
                  //   onTap: commentsSnapshot
                  //               .data ==
                  //           null
                  //       ? null
                  //       : commentSideWidget
                  //                   .value !=
                  //               null
                  //           ? () => commentSideWidget
                  //                   .value =
                  //               null
                  //           : () {
                  //               downloadsSideWidget
                  //                       .value =
                  //                   null;
                  //               commentSideWidget
                  //                       .value =
                  //                   CommentsWidget(
                  //                 onClose:
                  //                     () =>
                  //                         commentSideWidget.value = null,
                  //                 replyComment:
                  //                     replyComment,
                  //                 snapshot:
                  //                     commentsSnapshot,
                  //               );
                  //             },
                  //   title: Text(
                  //     "comments",
                  //   ),
                  //   trailing: Text(
                  //     (commentsSnapshot
                  //                     .data !=
                  //                 null
                  //             ? commentsSnapshot
                  //                 .data!
                  //                 .totalLength
                  //             : 0)
                  //         .formatNumber,
                  //   ),
                  // ),
                  const Divider(
                    height: 4,
                  ),
                  // if (Platform.isAndroid)
                  //   DescriptionWidget(
                  //     video: videoData,
                  //   ),
                ],
              ),
              // if (Platform.isAndroid) ...[
              //   if (commentSideWidget
              //           .value !=
              //       null)
              //     commentSideWidget
              //         .value!,
              //   if (downloadsSideWidget
              //           .value !=
              //       null)
              //     downloadsSideWidget
              //         .value!
              // ],
            ],
          ),
        ),
      ],
    ),
  ),
    );
  }
  // @override
  // bool get wantKeepAlive => true;
}

//     return Column(
//       children: [
//         AdwHeaderBar(
//           actions: AdwActions(
//             onClose: widget.onClose ?? context.back,
//             onHeaderDrag: appWindow?.startDragging,
//             onDoubleTap: appWindow?.maximizeOrRestore,
//           ),
//           style: const HeaderBarStyle(
//             autoPositionWindowButtons: false,
//           ),
//           start: [
//             if (currentPage.value == 1)
//               AdwHeaderButton(
//                 onPressed: () {
//                   pageController.animateToPage(
//                     0,
//                     duration: const Duration(milliseconds: 200),
//                     curve: Curves.easeInOut,
//                   );
//                   widget.replyComment.value = null;
//                 },
//                 icon: Icon(
//                   Icons.chevron_left,
//                   color: Theme.of(context).textTheme.bodyText1!.color,
//                 ),
//               )
//             else
//               const SizedBox(),
//           ],
//           // title: Text(
//           //   (currentPage.value == 0)
//           //       ? '${(widget.snapshot.data != null ? widget.snapshot.data!.totalLength : 0).formatNumber} ${context.locals.comments.toLowerCase()}'
//           //       : context.locals.replies,
//           // ),
//         ),
//         Expanded(
//           child: Container(
//             color: context.theme.canvasColor,
//             child: WillPopScope(
//               child: PageView.builder(
//                 onPageChanged: (index) => currentPage.value = index,
//                 controller: pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 2,
//                 itemBuilder: (_, index) => [
//                   ListView.builder(
//                     controller: controller,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: _currentPage.value!.length + 1,
//                     itemBuilder: (ctx, idx) {
//                       final comment = idx != _currentPage.value!.length
//                           ? _currentPage.value![idx]
//                           : null;
//                       return idx == _currentPage.value!.length
//                           ? getCircularProgressIndicator()
//                           : BuildCommentBox(
//                               // comment: comment!,
//                               onReplyTap: () {
//                                 widget.replyComment.value = comment;
//                                 pageController.animateToPage(
//                                   1,
//                                   duration: const Duration(milliseconds: 200),
//                                   curve: Curves.easeInOut,
//                                 );
//                               },
//                             );
//                     },
//                   ),
//                   showReplies(
//                     context,
//                     widget.replyComment.value,
//                     EdgeInsets.symmetric(
//                       horizontal: widget.onClose != null ? 16 : 0,
//                     ),
//                   ),
//                 ][index],
//               ),
//               onWillPop: () async {
//                 if (widget.replyComment.value != null) {
//                   await pageController.animateToPage(
//                     0,
//                     duration: const Duration(milliseconds: 200),
//                     curve: Curves.easeInOut,
//                   );
//                   widget.replyComment.value = null;
//                 } else {
//                   context.back();
//                 }
//                 return false;
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => throw UnimplementedError();

//   // @override
//   // bool get wantKeepAlive => true;
// }

// Widget showReplies(BuildContext context, Comment? comment, EdgeInsets padding) {
//   final yt = YoutubeExplode();
//   Future<CommentsList?>? getReplies() async {
//     if (comment == null) return null;
//     final replies = await yt.videos.commentsClient.getReplies(Netw);
//     yt.close();
//     return replies;
//   }

//   return comment != null
//       ? ListView(
//           controller: ScrollController(),
//           padding: padding,
//           children: [
//             BuildCommentBox(
//               // comment: comment,
//               onReplyTap: null,
//               isInsideReply: true,
//             ),
//             FutureBuilder<List<Comment>?>(
//               future: getReplies(),
//               builder: (context, snapshot) {
//                 return snapshot.data != null
//                     ? Container(
//                         padding: const EdgeInsets.only(left: 50),
//                         child: Column(
//                           children: [
//                             // for (Comment reply in snapshot.data!)
//                             //   BuildCommentBox(
//                             //     comment: reply,
//                             //     onReplyTap: null,
//                             //     isInsideReply: true,
//                             //   ),
//                           ],
//                         ),
//                       )
//                     : getCircularProgressIndicator();
//               },
//             ),
//           ],
//         )
//       : getCircularProgressIndicator();
// }
