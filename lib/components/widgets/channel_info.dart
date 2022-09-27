import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/channel_logo.dart';

class ChannelInfo extends StatefulHookWidget {
  const ChannelInfo({
    Key? key,
    required this.channel,
    this.channelId,
    this.textColor,
    this.isOnVideo = false,
  })  : assert(
          channel != null || channelId != null,
          "Channel and ChannelId both can't be null",
        ),
        super(key: key);

  // final AsyncSnapshot<Channel>? channel;
  final AsyncSnapshot? channel;
  final String? channelId;
  final bool isOnVideo;
  final Color? textColor;

  @override
  State<ChannelInfo> createState() => _ChannelInfoState();
}

class _ChannelInfoState extends State<ChannelInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = widget.isOnVideo ? 40 : 60;
    // final yt = YoutubeExplode();
    // final channelData = widget.channelId != null
        // ? 
        // useFuture(
            // useMemoized(
              // () => yt.channels.get(widget.channelId),
              // [widget.channelId!],
            // ),
          // )
        // : widget.channel;
    // final data = widget.channel?.data ?? channelData?.data;
    // return Text("test");
    return GestureDetector(
      // onTap: widget.isOnVideo && data != null || widget.channelId != null
      //     ? () => context
      //         .pushPage(ChannelScreen(id: widget.channelId ?? data!.id.value))
      //     : null,
      child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      image: NetworkImage("https://yt3.ggpht.com/ytc/AAUvwnihe-DJ8LqGo-CIKGvJif0xpv_8aWF0UWiDZJSpEQ=s176-c-k-c0xffffffff-no-rj-mo"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 180),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "Hamed Essam",
                                        style: TextStyle(
                                            color: widget.textColor??Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.appMainColors,
                                        size: 16.0,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "200 Followers",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "FOLLOW",
                          style: TextStyle(
                              color: AppColors.appMainColors, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
