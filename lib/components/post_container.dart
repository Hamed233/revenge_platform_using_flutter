import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:revenge_platform/components/add_opinion_box.dart';
import 'package:revenge_platform/components/default_form_field.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/models/post.dart';
import 'package:revenge_platform/screens/random_screens/opinions_screen.dart';

import '../screens/profile/profile_home_base.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: post),
                  const SizedBox(height: 4.0),
                  Text(post.caption),
                  post.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.imageUrl != null
                ? InkWell(
                    onDoubleTap: () {
                      print("like");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(imageUrl: post.imageUrl),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: post),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => navigateTo(context, ProfileHomeBase()),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    // image: NetworkImage(post.user.thumbnailImage),
                    image: NetworkImage(post.imageUrl),
                    fit: BoxFit.cover)),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Hamed Esam',
                      style: TextStyle(
                        height: 1.4,
                      )),
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
              Row(
                children: [
                  Text(
                    '${post.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            _PostActionButton(
              icon: Icon(
                MdiIcons.heartOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'love',
              onTap: () => print('Love'),
            ),
            _PostActionButton(
              icon: Icon(
                Icons.support_rounded,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'support',
              onTap: () => print('Share'),
            ),
            _PostActionButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'opinion',
              onTap: () => navigateTo(context, OpinionsScreen()),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        AddOpinionBox(),
      ],
    );
  }
}

class _PostActionButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function() onTap;

  const _PostActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            // height: 25.0,
            child: Column(
              children: [
                icon,
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: Text(
                    '200 ' + label,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
