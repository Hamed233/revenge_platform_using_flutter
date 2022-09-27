import 'package:custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:revenge_platform/components/extensions/extensions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.video,
    this.isInsidePopup = true,
  }) : super(key: key);

  final bool isInsidePopup;
  final Video video;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: ScrollController(),
      padding: const EdgeInsets.all(15),
      children: [
        Text(
          "description",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isInsidePopup ? 16 : 18,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DescriptionInfoWidget(
              title: video.engagement.viewCount.addCommas,
              body: "views",
            ),
            DescriptionInfoWidget(
              // title: DateFormat('dd MMM yyy').format(video.publishDate ?? DateTime.now()),
              title: DateTime.now().toString(),
              body: "uploadDate",
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CustomText(
            video.description,
            onTap: (Type type, link) => link.launchIt(),
            definitions: const [
              TextDefinition(matcher: UrlMatcher()),
              TextDefinition(matcher: EmailMatcher()),
            ],
            matchStyle: const TextStyle(color: Colors.lightBlue),
            // `tapStyle` is not used if both `onTap` and `onLongPress`
            // are null or not set.
            tapStyle: const TextStyle(color: Colors.yellow),
            style: TextStyle(fontSize: isInsidePopup ? 16 : 17),
          ),
        ),
      ],
    );
  }
}

class DescriptionInfoWidget extends StatelessWidget {
  const DescriptionInfoWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.headline3),
        Text(body),
      ],
    );
  }
}