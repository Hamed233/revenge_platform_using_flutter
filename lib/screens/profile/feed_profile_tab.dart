import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:line_icons/line_icons.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/profile_widgets/numbers_widget.dart';
import 'package:revenge_platform/components/widgets/profile_widgets/profile_image_widget.dart';
import 'package:revenge_platform/screens/profile/hire_me/profile_hire_me_tab.dart';
import 'package:revenge_platform/screens/profile/profile_playlists_tab.dart';
import 'package:revenge_platform/screens/profile/profile_posts_tab.dart';
import 'package:revenge_platform/screens/profile/profile_tasks_tab.dart';
import 'package:revenge_platform/screens/profile/profile_videos_tab.dart';
import 'package:revenge_platform/test_json_data.dart';

class FeedProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 30.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // background image and bottom contents
            Column(
              children: <Widget>[
                Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260")),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: socialMediaWidget(),
                        ),
                      ],
                    )),
                Container(
                  padding: const EdgeInsetsDirectional.only(top: 60),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hamed Essam",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
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
                      const SizedBox(height: 10),
                      Text(
                        "Job Title",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // filledBtn(10.0, "Follow", AppColors.appMainColors,
                          //     Colors.white),
                          const SizedBox(
                            width: 15,
                          ),
                          // borderedBtn(
                          //     10.0, "Hire", 1.0, AppColors.appMainColors),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 25, end: 25, top: 10),
                        child: Text(
                          "Donec sollicitudin molestie malesuada. Curabitur aliquet quam id dui posuere blandit. Sed porttitor lectus nibh. Cras ultricies ligula sed magna dictum porta.",
                          style: TextStyle(color: Colors.grey),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 24),
                      NumbersWidget(),
                      const SizedBox(height: 20),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: titleWithSpacerIcon(
                            context, "Latest Videos", Icons.arrow_forward_ios),
                      ),
                      Container(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        width: double.infinity,
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int i) {
                            return Card(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width:
                                        (MediaQuery.of(context).size.width) / 2,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                                            fit: BoxFit.cover)),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          bottom: 10,
                                          right: 12,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                home_video_detail[1]
                                                    ['video_duration'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white
                                                        .withOpacity(0.4)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 7, top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60) /
                                              2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                home_video[1]['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    home_video_detail[1]
                                                            ['view_count'] +
                                                        " views" +
                                                        " • " +
                                                        home_video[1]
                                                            ['day_ago'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          LineIcons.verticalEllipsis,
                                          color: Colors.black.withOpacity(0.4),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: titleWithSpacerIcon(context, "Latest Playlists",
                            Icons.arrow_forward_ios),
                      ),
                      Container(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        width: double.infinity,
                        height: 250,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                width: 250.0,
                                height: 180.0,
                                margin:
                                    const EdgeInsetsDirectional.only(end: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                            child: Icon(
                                          Icons.play_arrow,
                                          size: 30,
                                        )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Playlist Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "30 items",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                      const SizedBox(height: 20),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: titleWithSpacerIcon(
                            context, "Latest Clients", Icons.arrow_forward_ios),
                      ),

                      Container(
                        width: double.infinity,
                        height: 150,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                width: (MediaQuery.of(context).size.width) / 3,
                                height: 40,
                                child: Column(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.topRight,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                                        ),
                                        Positioned(
                                          child:
                                              Icon(Icons.star_outline_rounded),
                                          right: -10,
                                          top: 0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Maged Mohamed",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),

                      const SizedBox(height: 20),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: titleWithSpacerIcon(context, "Latest Projects",
                            Icons.arrow_forward_ios),
                      ),

                      // Design Here

                      const SizedBox(height: 20),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: titleWithSpacerIcon(
                            context, "Latest Tasks", Icons.arrow_forward_ios),
                      ),

                      // Design Here
                    ],
                  ),
                ),
              ],
            ),
            // Profile image
            Positioned(
              top: 150.0, // (background container size) - (circle height / 2)
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://yt3.ggpht.com/ytc/AAUvwnihe-DJ8LqGo-CIKGvJif0xpv_8aWF0UWiDZJSpEQ=s176-c-k-c0xffffffff-no-rj-mo")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialMediaWidget() {
    return Container(
        padding: EdgeInsetsDirectional.all(5),
        decoration: BoxDecoration(
          color: Color.fromARGB(53, 0, 0, 0),
        ),
        child: Row(
          children: [
            InkWell(
              child: Icon(Icons.facebook, size: 26),
              onTap: () {
                print("test");
              },
            ),
            SizedBox(
              width: 7,
            ),
            InkWell(
              child: Icon(
                Icons.whatsapp,
                size: 26,
              ),
              onTap: () {
                print("test");
              },
            ),
            SizedBox(
              width: 7,
            ),
            InkWell(
              child: Icon(Icons.telegram, size: 26),
              onTap: () {
                print("test");
              },
            ),
          ],
        ));
  }

  Widget titleWithSpacerIcon(context, title, icon) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: 20,
            )),
      ],
    );
  }
}
