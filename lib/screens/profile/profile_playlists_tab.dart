import 'package:flutter/material.dart';
import 'package:revenge_platform/components/playlist_component.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/screens/profile/playlist_details_screen.dart';

class PlaylistsProfileTab extends StatefulWidget {
  @override
  PlaylistsProfileTabState createState() => PlaylistsProfileTabState();
}

class PlaylistsProfileTabState extends State<PlaylistsProfileTab>
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(10, (int index) {
                return PlaylistComponent();
              }),
        ),
      )
    );
  }
}
