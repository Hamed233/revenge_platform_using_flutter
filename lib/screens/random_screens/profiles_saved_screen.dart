import 'package:flutter/material.dart';
import 'package:revenge_platform/components/mini-video-component.dart';
import 'package:revenge_platform/components/playlist_component.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/widgets/channel_info.dart';
import 'package:revenge_platform/screens/profile/playlist_details_screen.dart';
import 'package:revenge_platform/test_json_data.dart';

class SavedProfilesScreen extends StatelessWidget {
  const SavedProfilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Saved Profiles'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // showMoreDetailsProfilesBottomSheet(context);
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
                  return Container(
                    padding: EdgeInsetsDirectional.only(top: 15, bottom: 15),
                    margin: EdgeInsetsDirectional.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: ChannelInfo(
                            channel: null,
                            channelId: "id",
                            isOnVideo: true,
                            textColor: Colors.black
                          ),
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
