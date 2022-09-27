import 'package:ant_icons/ant_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/widgets/profile_image_with_status.dart';
import 'package:revenge_platform/screens/auth/login/login_screen.dart';
import 'package:revenge_platform/screens/random_screens/downloads_screen.dart';
import 'package:revenge_platform/screens/random_screens/history_screen.dart';
import 'package:revenge_platform/screens/profile/profile_home_base.dart';
import 'package:revenge_platform/screens/random_screens/intersts_screen.dart';
import 'package:revenge_platform/screens/random_screens/saved_home_screen.dart';
import 'package:revenge_platform/screens/random_screens/watch_later_videos_screen.dart';

final padding = const EdgeInsets.symmetric(horizontal: 20);

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    var expandedWidth = 240.0;

    return Drawer(
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: Container(
          padding: const EdgeInsetsDirectional.only(top: 20),
          width: 240.0,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: expandedWidth,
              color: Colors.white10,
              alignment: Alignment.topLeft,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 0, right: 0.0),
                    // width: 240.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => navigateTo(
                                context, ProfileHomeBase()),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(clipBehavior: Clip.none, children: [
                                  ProfileImageWithStatus(
                                    radius: 20.0,
                                  ),
                                  // Positioned(
                                  //   top: -4,
                                  //   right: -2,
                                  //   child: Text(
                                  //     // countryFlag(),
                                  //   ),
                                  // ),
                                ]),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        width: 180,
                                        child: Text("Hammed esam",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "10000 Followers",
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        // const Spacer(),
                        Container(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 22.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    padding: const EdgeInsets.only(top: 11.0, bottom: 05.0),
                    child: Container(
                      width: currentWidth,
                      height: 1.0,
                      color: Colors.black12.withOpacity(0.1),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          SavedHomeScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 24.0, top: 12.0, bottom: 9.0),
                                alignment: Alignment.topLeft,
                                child: const Icon(Icons.save_rounded),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 25.0, top: 0.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Saved',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context, HistoryVideosScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 21.0, top: 3.0, bottom: 9.0),
                                alignment: Alignment.topLeft,
                                child: const Icon(Icons.history_outlined,
                                    size: 29.0),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 22.0, bottom: 07.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'History',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(
                              context, WatchLaterScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          padding: const EdgeInsets.only(
                              left: 24.0, top: 08.0, bottom: 08.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Icon(Icons.watch_later_outlined),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 05.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Watch later',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(
                              context, DownloadsVideosScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          padding: const EdgeInsets.only(
                              left: 24.0, top: 08.0, bottom: 08.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Icon(AntIcons.download),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 03.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Downloads',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Container(
                          width: currentWidth,
                          height: 1.0,
                          color: Colors.black12.withOpacity(0.1),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 08.0, bottom: 08.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Icon(Icons.settings_outlined),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 03.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Settings',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 08.0, bottom: 08.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Icon(Icons.flag_outlined),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 03.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Report history',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 08.0, bottom: 08.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Icon(Icons.info_outline),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 03.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Help',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 08.0, bottom: 08.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Icon(Icons.feedback_outlined),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 03.0),
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Send feedback',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // filledBtn(10.0, "login", Colors.blue, Colors.white, onPressed: () => navigateTo(context, LoginScreen())),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildHeader({
  required String name,
  required String email,
  required VoidCallback onClicked,
}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  const color = Colors.white;
  const hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: const TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
