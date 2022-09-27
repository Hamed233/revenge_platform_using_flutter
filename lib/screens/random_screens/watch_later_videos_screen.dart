import 'package:flutter/material.dart';
import 'package:revenge_platform/components/mini-video-component.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/test_json_data.dart';

class WatchLaterScreen extends StatelessWidget {
  const WatchLaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Watch Later Videos'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // showMoreDetailsVideosBottomSheet(context);
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
                children: List.generate(home_video_detail.length, (index) {
                  return MiniVideoComponent();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
