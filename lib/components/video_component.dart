import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/screens/channel_screen.dart';
import 'package:revenge_platform/screens/profile/feed_profile_tab.dart';
import 'package:revenge_platform/screens/profile/profile_home_base.dart';
import 'package:revenge_platform/screens/video/video_detail_screen.dart';
import 'package:revenge_platform/screens/video/video_screen.dart';
import 'package:revenge_platform/test_json_data.dart';

class VideoComponent extends StatelessWidget {
  const VideoComponent({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            navigateTo(
                context,
                VideoDetailPage(
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
                ));
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.only(left: 0, right: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                        image: AssetImage(home_video[1]['thumnail_img']),
                        fit: BoxFit.cover)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 17.0,
                    width: 40.0,
                    color: Colors.black87.withOpacity(0.8),
                    alignment: Alignment.center,
                    child: const Text(
                      "00:00",
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    // color: Colors.black87.withOpacity(0.5),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        // reviewStar,
                        // reviewStar,
                        // reviewStar,
                        // reviewStar,
                        // reviewStar,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () => navigateTo(context, ProfileHomeBase()),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: NetworkImage(home_video[1]['profile_img']),
                          fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: size.width - 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      home_video[1]['title'],
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          home_video_detail[1]['view_count'] +
                              " views" +
                              " • " +
                              "12 likes" +
                              " • " +
                              home_video[1]['day_ago'],
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Container(
                      width: size.width - 120,
                      child: Row(
                        children: [
                          Text(home_video[1]['username'],
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Icon(
                LineIcons.verticalEllipsis,
                color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
              )
            ],
          ),
        )
      ],
    );
  }
}
