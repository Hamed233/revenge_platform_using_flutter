import 'package:flutter/material.dart';
import 'package:revenge_platform/components/add_opinion_box.dart';
import 'package:revenge_platform/components/mini-video-component.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/models/opinions.dart';
import 'package:revenge_platform/screens/random_screens/replay_opinion_screen.dart';
import 'package:revenge_platform/test_json_data.dart';

class OpinionsScreen extends StatelessWidget {
  const OpinionsScreen({Key? key}) : super(key: key);
  // final OpinionsModel? opinions;

  @override
  Widget build(BuildContext context) {
    final FocusNode? focuseNode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Opinions'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // showMoreDetailsVideosBottomSheet(context);
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  commentsBody("test",
                      width: 35, height: 35, radius: 15, fontsize: 15),
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                          context, ReplayOnOpinionScreen());
                    },
                    child: viewReplies(context),
                  ),
                ],
              ),
            ),
            AddOpinionBox(),
          ],
        ),
      ),
    );
  }

  viewReplies(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('View replies', style: TextStyle(color: Colors.grey)),
          SizedBox(width: 5),
          Text(
            "20".toString(),
            style: TextStyle(color: Colors.grey),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.grey,
            size: 17,
          )
        ],
      ),
    );
  }
}

Container commentsBody(
  comment, {
  double? width,
  double? height,
  double? radius,
  double? fontsize,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: width,
          height: height,
          child: GestureDetector(
            child: CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(
                  'https://yt3.ggpht.com/ytc/AAUvwnjcXhQ1Tl-tCyXrovuQwBMHrFwE9uMzzclq2SzHjg=s176-c-k-c0xffffffff-no-rj-mo'),
            ),
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    'Hamed esam',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () {
                      // postState.isreply(true);
                      // focuseNode?.nextFocus();
                      // postState
                      //     .getreplyCommentOwnerName('${comment?.userName}');
                      // postState.getreplyCommentId('${comment?.commentId}');
                    },
                    child: Text(
                      'Hellow from hamed',
                      style: TextStyle(fontSize: fontsize),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.support_rounded,
              color: Colors.grey,
              size: 15,
            ),
            SizedBox(width: 5),
            Text(
              '4',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ],
    ),
  );
}
