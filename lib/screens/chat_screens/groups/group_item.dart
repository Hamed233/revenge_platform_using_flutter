import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/models/user.dart';
import 'package:revenge_platform/screens/chat_screens/groups/group_chat_details.dart';
import 'package:revenge_platform/screens/chat_screens/messages/chat_details_screen.dart';

class GroupItem extends StatefulWidget {
  final UserModel? model;

  GroupItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _GroupItemState createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
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
          "Students Group",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text("${widget.model!.msg}"),
        subtitle: Text("Hamed essam joined to group."),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              // "${widget.time}",
              "Now",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
    
            SizedBox(height: 5),
            // widget.counter == 0
                // ?SizedBox() :
                Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 11,
                minHeight: 11,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                child:Text(
                  "10",
                  // "${widget.counter}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        onTap: (){
          navigateTo(context, GroupDetailsScreen(userModel: widget.model!,),
        );    
        },
      ),
    );
  }
}