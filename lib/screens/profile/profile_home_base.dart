import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
import 'package:revenge_platform/blocs/profile_bloc/profile_bloc.dart';
import 'package:revenge_platform/blocs/profile_bloc/states.dart';
import 'package:revenge_platform/blocs/task_bloc/task_bloc.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/routes/argument_bundle.dart';
import 'package:revenge_platform/routes/page_path.dart';
import 'package:revenge_platform/screens/chat_screens/chats.dart';
import 'package:revenge_platform/screens/profile/edit_profile/main_edit_profile_screen.dart';
import 'package:revenge_platform/screens/profile/feed_profile_tab.dart';
import 'package:revenge_platform/screens/profile/hire_me/profile_hire_me_tab.dart';
import 'package:revenge_platform/screens/profile/profile_playlists_tab.dart';
import 'package:revenge_platform/screens/profile/profile_posts_tab.dart';
import 'package:revenge_platform/screens/profile/profile_tasks_tab.dart';
import 'package:revenge_platform/screens/profile/profile_videos_tab.dart';

class ProfileHomeBase extends StatefulWidget {
  const ProfileHomeBase({Key? key}) : super(key: key);

  @override
  State<ProfileHomeBase> createState() => _ProfileHomeBase();
}

class _ProfileHomeBase extends State<ProfileHomeBase>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Tab> tabs = <Tab>[
    Tab(text: 'Feed', icon: const Icon(Icons.home)),
    Tab(text: 'Videos', icon: const Icon(Icons.videocam_sharp)),
    Tab(
      text: 'Playlists',
      icon: const Icon(Icons.playlist_add_check),
    ),
    Tab(
      text: 'Posts',
      icon: const Icon(Icons.post_add_sharp),
    ),
    Tab(
      text: 'Tasks',
      icon: const Icon(Icons.task_sharp),
    ),
    Tab(text: 'Hire Me', icon: const Icon(Icons.hive_rounded)),
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        ProfileBloc bloc = ProfileBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Profile Name'),
            titleSpacing: 0,
            actions: [
              // Edit inforation button
              if(bloc.currentTabIndex == 0)
                IconButton(onPressed: () {
                  navigateTo(context, EditProfileScreen());
                }, icon: Icon(Icons.settings)),
              // Filter and order videos
              if(bloc.currentTabIndex == 1)
                IconButton(onPressed: () {
                  // showMoreDetailsVideosBottomSheet(context);
                }, icon: Icon(Icons.more_vert)),
              
              if(bloc.currentTabIndex == 4)
                IconButton(
                    onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PagePath.searchScreen,
                          arguments: ArgumentBundle(extras: "Tasks Search", identifier: 'tasks'),
                        );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 25,
                )),
              if(bloc.currentTabIndex == 4)
                IconButton(
                  onPressed: () => TaskBloc.get(context).toggleViewType(),
                  icon: Icon(
                    TaskBloc.get(context).tasksViewType == viewType.List ?  Icons.developer_board : Icons.view_headline,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
            ],
            bottom: TabBar(
              isScrollable: true,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              automaticIndicatorColorAdjustment: true,
              indicatorColor: AppColors.appMainColors,
              labelColor: AppColors.appMainColors,
              controller: _tabController,
              tabs: tabs,
              physics: const BouncingScrollPhysics(),
              onTap: (int? index) => bloc.changeTabNav(index!),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: bloc.tabScreens.map((Widget currentTab) {
                    return currentTab;
                  }).toList(),
                )
              ),
            ],
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 30.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      ChatBloc.get(context).getUsers();
                      navigateTo(context, Chats());
                    },
                    child: const Icon(Icons.message),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: mainFloatingBTN(),
              // ),
            ],
          ),
        );
      }
    );
        
  }
}
