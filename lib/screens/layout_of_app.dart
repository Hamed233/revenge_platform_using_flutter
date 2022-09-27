import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:revenge_platform/blocs/general_app_bloc/app_general_bloc.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/components/bottom_sheets/sheets.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/sidebar.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';
import 'package:revenge_platform/routes/argument_bundle.dart';
import 'package:revenge_platform/screens/chat_screens/friends/requests.dart';
import 'package:revenge_platform/screens/notifications/notifications_screen.dart';
import 'package:revenge_platform/screens/search/search_screen.dart';
import 'package:revenge_platform/screens/video/video_detail_screen.dart';
import 'package:revenge_platform/screens/video/video_screen.dart';

import '../models/video.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);

final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
  (ref) => MiniplayerController(),
);

class AppLayout extends StatelessWidget {
  static const double _playerMinHeight = 60.0;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  AppLayout({Key? key}) : super(key: key);

  IconData currentIconScreen(appCubit) {
    if (appCubit.currentIndex == 1) {
      return LineIcons.fire;
    } else if (appCubit.currentIndex == 3) {
      return LineIcons.hireahelper;
    } else if (appCubit.currentIndex == 4) {
      return Icons.chat_outlined;
    }

    return Icons.home;
  }

  String currentScreenTitle(appCubit) {
    if (appCubit.currentIndex == 1) {
      return "Top";
    } else if (appCubit.currentIndex == 3) {
      return "Hire";
    } else if (appCubit.currentIndex == 4) {
      return "Chats";
    }

    return "Revenge";
  }

  List<Widget> currentActionsList(context, appCubit) {
    if (appCubit.currentIndex == 4) {
      return [
        InkWell(
          onTap: () {
            // cubit.getNotifications(context);
            // navigateTo(context, NotificationScreen(bundle: ArgumentBundle(),));
          },
          child: IconButton(
            onPressed: () {
              navigateTo(
                  context,
                  RequestsScreen());
            },
            icon: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topRight,
              children: <Widget>[
                const Icon(Icons.pending_outlined),
                Positioned(
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '20',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
          ),
          onPressed: () {},
        ),
      ];
    }

    return [
      IconButton(
          onPressed: () {
            navigateTo(context, SearchScreen());
          },
          icon: const Icon(LineIcons.search)),
      InkWell(
        onTap: () {
          // cubit.getNotifications(context);
          // navigateTo(context, NotificationScreen(bundle: ArgumentBundle(),));
        },
        child: IconButton(
          onPressed: () {
            navigateTo(
                context,
                NotificationScreen(
                  bundle: ArgumentBundle(),
                ));
          },
          icon: Stack(
            children: <Widget>[
              const Icon(LineIcons.bell),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: const Text(
                    '20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      
      ),
      InkWell(
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/avatar.jpg"),
          // radius: 20,
        ),
        onTap: () {
          scaffoldKey.currentState!.openEndDrawer();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppBloc.get(context);
        var userId = CacheHelper.getData(key: CacheHelperKeys.userIdKey);

        return Scaffold(
          key: scaffoldKey,
          endDrawer: const SideDrawer(),
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            leading: SizedBox(
              width: 45.0,
              height: 30.0,
              child: CircleAvatar(
                child: Center(
                  child: Icon(
                    currentIconScreen(appCubit),
                    color: AppColors.appMainColors,
                    size: 28,
                  ),
                ),
                radius: 20,
                backgroundColor: Colors.transparent,
              ),
            ),
            title: Text(
              currentScreenTitle(appCubit),
              style: TextStyle(color: AppColors.appMainColors),
            ),
            centerTitle: false,
            actions: currentActionsList(context, appCubit),
          ),
          body: appCubit.mainScreens[appCubit.currentIndex],
          bottomNavigationBar: ConvexAppBar(
            // type: BottomNavigationBarType.fixed,
            // backgroundColor: Theme.of(context)
            //     .bottomNavigationBarTheme
            //     .backgroundColor,
            // showSelectedLabels: true,
            // showUnselectedLabels: true,
            elevation: 0,
            // currentIndex: appCubit.currentIndex,
            backgroundColor: AppColors.appMainColors,
            style: TabStyle.fixedCircle,
            cornerRadius: 0.0,
            initialActiveIndex: appCubit.currentIndex,
            onTap: (index) {
              appCubit.changeBottomNav(index);
            },
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              TabItem(title: "Home", icon: LineIcons.home),
              TabItem(title: "Top", icon: LineIcons.fire),
              // TabItem(icon: mainFloatingBTN(context)),
              TabItem(title: "Hire", icon: LineIcons.hireahelper),
              TabItem(title: "Chats", icon: Icons.chat),
              // const BottomNavigationBarItem(
              //   icon: Icon(LineIcons.fire),
              //   label: 'Top',
              // ),
              // const BottomNavigationBarItem(
              //   icon: Icon(LineIcons.home),
              //   label: 'Home',
              // ),
              // const BottomNavigationBarItem(
              //   icon: Icon(LineIcons.music),
              //   label: 'Musics',
              // ),
              // BottomNavigationBarItem(
              //   icon: SvgPicture.asset(Resources.tasksInactive, width: 25, height: 23),
              //   activeIcon: SvgPicture.asset(Resources.tasksActive, width: 25, height: 23),
              //   label: 'Tasks',
              // ),
            ],
          ),

          // floatingActionButton: mainFloatingBTN(),
        );
      },
    );
  }
}
