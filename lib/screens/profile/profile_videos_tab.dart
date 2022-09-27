import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:revenge_platform/components/mini-video-component.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/video_component.dart';
import 'package:revenge_platform/test_json_data.dart';

class VideosProfileTab extends StatefulWidget {
  @override
  VideosProfileTabState createState() => VideosProfileTabState();
}

class VideosProfileTabState extends State<VideosProfileTab>
    with SingleTickerProviderStateMixin {
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
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(home_video_detail.length, (index) {
            return MiniVideoComponent();
          }),
        ),
      ),
    );
  }
}
