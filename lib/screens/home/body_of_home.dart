import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:revenge_platform/blocs/general_app_bloc/app_general_bloc.dart';
import 'package:revenge_platform/components/card_ads_component.dart';
import 'package:revenge_platform/components/post_container.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/video_component.dart';
import 'package:revenge_platform/models/post.dart';
import 'package:revenge_platform/screens/video/video_detail_screen.dart';
import 'package:revenge_platform/test_json_data.dart';

Widget bodyOfHome(context) {
  const double _playerMinHeight = 60.0;
  return Stack(
    children: [
       ListView(
      children: <Widget>[
        const AdsCard(),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Recommended",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate(home_video.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
              child: VideoComponent(),
            );
          }),
        ),
        Column(
          children: List.generate(2, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
              child:             PostContainer(post: Post(
              // user: User(),
              caption: "Hello World",
              timeAgo: "10 minutes",
              imageUrl: "https://yt3.ggpht.com/ytc/AAUvwnhuheOArV1o5BSo10TdUivctyIHSfzYGKLwudMCdg=s176-c-k-c0xffffffff-no-rj-mo",
              likes: 10,
              comments: 10,
              shares: 10,
            )
            )
            );
          }),
        ),
        
      ],
    ),

    Miniplayer(
          minHeight: 70,
          maxHeight: MediaQuery.of(context).size.height,
          builder: (height, percentage) {
           if (height <= _playerMinHeight + 50.0)
              // ignore: curly_braces_in_flow_control_structures
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          "https://yt3.ggpht.com/ytc/AAUvwnihe-DJ8LqGo-CIKGvJif0xpv_8aWF0UWiDZJSpEQ=s176-c-k-c0xffffffff-no-rj-mo",
                          height: _playerMinHeight - 4.0,
                          width: 120.0,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Hammed esam",
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "Hamed Esam",
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontWeight:
                                                FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            // context
                            //     .read(selectedVideoProvider)
                            //     .state = null;
                          },
                        ),
                      ],
                    ),
                    const LinearProgressIndicator(
                      value: 0.4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            return VideoDetailPage(
                  title: home_video[1]['title'],
                  viewCount: home_video[1]['view_count'],
                  username: home_video[1]['username'],
                  profile: home_video[1]['profile_img'],
                  thumbnail: home_video[1]['thumnail_img'],
                  dayAgo: home_video[1]['day_ago'],
                  subscribeCount: home_video[1]['subscriber_count'],
                  likeCount: home_video[1]['like_count'],
                  unlikeCount: home_video[1]['unlike_count'],
                  videoUrl: home_video[1]['video_url'],
                );
          },
        ),
      ],
  );
}
