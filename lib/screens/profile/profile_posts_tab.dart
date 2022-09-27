import 'package:flutter/material.dart';
import 'package:revenge_platform/components/post_container.dart';
import 'package:revenge_platform/components/widgets/profile_widgets/create_post_container.dart';
import 'package:revenge_platform/models/post.dart';

class PostsProfileTab extends StatefulWidget {
  @override
  PostsProfileTabState createState() => PostsProfileTabState();
}

class PostsProfileTabState extends State<PostsProfileTab>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CreatePostContainer(),
            PostContainer(post: Post(
              // user: User(),
              caption: "Hello World",
              timeAgo: "10 minutes",
              imageUrl: "https://yt3.ggpht.com/ytc/AAUvwnhuheOArV1o5BSo10TdUivctyIHSfzYGKLwudMCdg=s176-c-k-c0xffffffff-no-rj-mo",
              likes: 10,
              comments: 10,
              shares: 10,
            )
            )
          ],
        ),
      ),
    );
  }
}