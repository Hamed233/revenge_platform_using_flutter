import 'package:flutter/material.dart';
import 'package:revenge_platform/components/mini-video-component.dart';
import 'package:revenge_platform/components/playlist_component.dart';
import 'package:revenge_platform/components/post_container.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/models/post.dart';
import 'package:revenge_platform/screens/profile/playlist_details_screen.dart';
import 'package:revenge_platform/test_json_data.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Saved Posts'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // showMoreDetailsPostsBottomSheet(context);
              },
              icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(5, (index) {
                  return PostContainer(post: Post(
              // user: User(),
              caption: "Hello World",
              timeAgo: "10 minutes",
              imageUrl: "https://yt3.ggpht.com/ytc/AAUvwnhuheOArV1o5BSo10TdUivctyIHSfzYGKLwudMCdg=s176-c-k-c0xffffffff-no-rj-mo",
              likes: 10,
              comments: 10,
              shares: 10,
            )
            );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
