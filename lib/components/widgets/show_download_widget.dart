
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:revenge_platform/components/extensions/context.dart';
import 'package:revenge_platform/components/widgets/show_download_popover.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube_explode;

class ShowDownloadsWidget extends StatelessWidget {
  const ShowDownloadsWidget({
    Key? key,
    required this.downloadsSideWidget,
    // required this.videoData, 
    youtube_explode.StreamManifest? manifest,
    // this.manifest,
  }) : super(key: key);

  final ValueNotifier<Widget?> downloadsSideWidget;
  // final Video videoData;
  // final StreamManifest? manifest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdwHeaderBar(
          style: const HeaderBarStyle(
            autoPositionWindowButtons: false,
          ),
          title: Text(
            "downloadQuality",
          ),
          actions: AdwActions(
            onClose: () => downloadsSideWidget.value = null,
            onHeaderDrag: appWindow?.startDragging,
            onDoubleTap: appWindow?.maximizeOrRestore,
          ),
        ),
        Expanded(
          child: Container(
            color: context.theme.canvasColor,
            child: WillPopScope(
              child: SingleChildScrollView(
                controller: ScrollController(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                child: DownloadsWidget(
                  // video: videoData,
                  onClose: () => downloadsSideWidget.value = null,
                ),
              ),
              onWillPop: () async {
                context.back();
                return false;
              },
            ),
          ),
        ),
      ],
    );
  }
}