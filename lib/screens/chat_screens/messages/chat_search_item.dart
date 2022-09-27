import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/models/user.dart';
import 'package:revenge_platform/screens/chat_screens/groups/group_chat_details.dart';
import 'package:revenge_platform/screens/chat_screens/messages/chat_details_screen.dart';

class SearchChatItem extends StatefulWidget {
  final UserModel? model;

  SearchChatItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _SearchChatItemState createState() => _SearchChatItemState();
}

class _SearchChatItemState extends State<SearchChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: CircleAvatar(
          radius: 25.0,
          backgroundImage: widget.model!.image != '' ? NetworkImage(widget.model!.image!) : null,
          child: widget.model!.image == '' ? Text(widget.model!.fullName!.substring(0, 1).toUpperCase()) : null,
        ),
    
        title: Text(
          "Hamed Essam",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text("${widget.model!.msg}"),
        subtitle: Text(
          "biohhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhgg",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          width: 120,
          height: 40,
          // child: filledBtn(10.0, "Connect", AppColors.appMainColors, Colors.white),
        ),
        onTap: (){
            navigateTo(context, GroupDetailsScreen(userModel: widget.model!,));
        },
      ),
    );
  }
}