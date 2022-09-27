import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:revenge_platform/blocs/general_app_bloc/app_general_bloc.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/models/notification.dart';
import 'package:revenge_platform/routes/argument_bundle.dart';

class NotificationScreen extends StatelessWidget {
  final ArgumentBundle bundle;

  const NotificationScreen({Key? key, required this.bundle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? payload = bundle.extras;
    print(payload);

    var notifications;

    return BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var appBloc = AppBloc.get(context);
          if (payload != null) {
            // appBloc.makeNotificationOpend(context, payload);
            // payload = null; // to prevent run makeNotificationOpend every time (Just once)
          }

          // notifications = appBloc.notifications;

          // if(payload != null) appBloc.makeNotificationOpend(payload);

          return Scaffold(
            appBar: AppBar(
              shadowColor: Colors.grey,
              elevation: .3,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(context),
              ),
              title: Text("Notifications"),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ConditionalBuilder(
                    condition: state is! GettingNotificationsLoading ||
                        state is! NotificationsOpendIsLoading,
                    builder: (context) => Container(
                      child: ConditionalBuilder(
                        // condition: notifications.length != 0,
                        condition: 1 == 1,
                        builder: (context) => Column(
                          children: [
                              _notificationVideoAndPostBuilder(context, "post"),
                          ],
                          // children: List.generate(
                          //   notifications.length,
                          //   (index) {
                          //     return _notificationBuilder(
                          //         context, notifications[index]);
                          //   },
                          // ),
                        ),
                        fallback: (context) => Center(
                          child: SvgPicture.asset(
                            Resources.empty,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .75,
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.appMainColors,
                      ),
                      heightFactor: 15,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _notificationBuilder(context, NotificationModel model) {
    DateTime today = DateTime.now();
    late String? currentDay =
        DateFormat('dd, MMMM yyyy').format(today).toString();
    String dateContent;
    print(currentDay);
    print(model.date);

    if (model.date != currentDay) {
      // dateContent = AppLocalizations.of(context)!.daysAgo;
    } else {
      // dateContent = AppLocalizations.of(context)!.today;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.alarm,
              color: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title!,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "dateContent",
                  // dateContent + " . " + model.tag_notification,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width * .70,
                      child: Text(
                        "date",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  // DatabaseHelper.instance.deleteFromTable(
                  //     "notifications", model.id
                  // ).then((value) {
                  //   AppBloc.get(context).getNotifications(context);
                  //   Helper.showCustomSnackBar(context, content: AppLocalizations.of(context)!.noficicationDeleted, bgColor: Colors.red, textColor: Colors.white);
                  // });
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Divider(),
      ],
    );
  }

  Widget _notificationVideoAndPostBuilder(context, notificationType, {NotificationModel? model}) {
    DateTime today = DateTime.now();
    late String? currentDay =
        DateFormat('dd, MMMM yyyy').format(today).toString();
    String dateContent;


    // if (model!.date != currentDay) {
    //   // dateContent = AppLocalizations.of(context)!.daysAgo;
    // } else {
    //   // dateContent = AppLocalizations.of(context)!.today;
    // }

    return InkWell(
      onTap: () {
        // go to video
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  // if post: put profile image, video: put thumnail image
                  child: Image(
                    image: NetworkImage("https://yt3.ggpht.com/ytc/AAUvwnjcXhQ1Tl-tCyXrovuQwBMHrFwE9uMzzclq2SzHjg=s176-c-k-c0xffffffff-no-rj-mo"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "Hamed Esam publish ${notificationType == 'post' ? "post" : "video"}" + " 'How to play football?dsdssssssssssssssssssssssssssssssss'",
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width * .70,
                        child: Text(
                          "date",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
        ],
      ),
    );
  }
}
