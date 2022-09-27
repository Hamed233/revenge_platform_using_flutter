import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
import 'package:revenge_platform/blocs/chat_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/state_widgets.dart';
import 'package:revenge_platform/models/user.dart';
import 'package:revenge_platform/screens/chat_screens/groups/group_search_item.dart';
import 'package:revenge_platform/screens/chat_screens/messages/chat_item.dart';
import 'package:revenge_platform/screens/chat_screens/groups/group_item.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ChatBloc, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Theme.of(context).cardColor,
            appBar: AppBar( // toggle it with search btn
              titleSpacing: 0,
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.appMainColors
                    )
                    
                  ),
                width: double.infinity,
                height: 40,
                padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
                margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
                child: Center(
                  child: TextFormField(
                    controller: searchController,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.appMainColors,
                      ),
                      focusColor: AppColors.appMainColors,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 14
                    ),
                    cursorColor: AppColors.appMainColors,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter text to search';
                      }
                      return null;
                    },

                    onChanged: (String text) {
                        // TaskCubit.get(context).search(text);
                    },

                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.appMainColors,
                labelColor: AppColors.appMainColors,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Theme.of(context).textTheme.caption!.color,
                isScrollable: false,
                tabs: <Widget>[
                  Tab(
                    text: "Messages",
                  ),
                  Tab(
                    text: "Groups",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                // General messages
                ConditionalBuilder(
                  condition: state is! SocialGetAllUsersLoadingState,
                  builder: (context) => ConditionalBuilder(
                    condition: ChatBloc.get(context).users.isNotEmpty,
                    builder: (context) => ListView.separated(
                      padding: const EdgeInsets.all(10),
                      separatorBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Divider(),
                          ),
                        );
                      },
                      itemCount:  ChatBloc.get(context).users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatItem(
                            model: ChatBloc.get(context).users[index]);
                      },
                    ),
                    fallback: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TwoPersonCommunicatingWidget(),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
                          child: Text(
                            "You've not chat any person, search for people by tapping on the search button above.",
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(),),
                ),
                // Groups
                ConditionalBuilder(
                  condition: state is! SocialGetAllUsersLoadingState,
                  builder: (context) => ConditionalBuilder(
                    condition: ChatBloc.get(context).users.isNotEmpty,
                    builder: (context) => ListView.separated(
                      padding: const EdgeInsets.all(10),
                      separatorBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Divider(),
                          ),
                        );
                      },
                      itemCount:  ChatBloc.get(context).users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchGroupItem(
                            model: ChatBloc.get(context).users[index]);
                      },
                    ),
                    fallback: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PeopleCommunicatingWidget(),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "You've not joined any group, tap on the 'add' icon to create a group or search for groups by tapping on the search button above.",
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // borderedBtn(10.0, "Create new group", 1.0, AppColors.appMainColors),
                      ],
                    ),
                  ),
                  fallback: (context) => const Center(child: CircularProgressIndicator(),),
                ),
              ],
            ),
            
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
