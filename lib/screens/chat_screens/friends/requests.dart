import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
import 'package:revenge_platform/blocs/chat_bloc/states.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/state_widgets.dart';
import 'package:revenge_platform/models/user.dart';

class RequestsScreen extends StatelessWidget {
  // final UserModel? model;

  RequestsScreen({
    Key? key,
    // required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).cardColor,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              title: Text("Requests"),
              titleSpacing: 0,
              elevation: 0.3,
              actions: [
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.settings)),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ConditionalBuilder(
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
                    itemCount: ChatBloc.get(context).users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _itemBuilder(ChatBloc.get(context).users[index]);
                    },
                  ),
                  fallback: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyChatsWidget(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 15.0, end: 15.0),
                        child: Text("Not found any request",
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        });
  }

  Widget _itemBuilder(UserModel model) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        radius: 25.0,
        // backgroundImage: model!.image != '' ? NetworkImage(model!.image!) : null,
        backgroundImage: NetworkImage(
            "https://yt3.ggpht.com/ytc/AAUvwnjcXhQ1Tl-tCyXrovuQwBMHrFwE9uMzzclq2SzHjg=s176-c-k-c0xffffffff-no-rj-mo"),
        // child: model!.image == '' ? Text("hamed".substring(0, 1).toUpperCase()) : null,
      ),

      title: Text(
        "Hamed Essam",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      // subtitle: Text("${model!.msg}"),
      subtitle: Text(
        "message",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
      onTap: () {
        // navigateTo(context, GroupDetailsScreen(userModel: widget.model!,));
      },
    );
  }
}
