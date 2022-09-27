import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/models/user.dart';
import 'package:revenge_platform/screens/chat_screens/messages/chat_details_screen.dart';

class ChatItem extends StatefulWidget {
  final UserModel? model;

  ChatItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: widget.model!.image != '' ? NetworkImage(widget.model!.image!) : null,
                 child: widget.model!.image == '' ? Text(widget.model!.fullName!.substring(0, 1).toUpperCase()) : null,
              ),
    
            Positioned(
              bottom: 0.0,
              left: 6.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 11,
                width: 11,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.model!.isOnline
                          ?Colors.greenAccent
                          :Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 7,
                    width: 7,
                  ),
                ),
              ),
            ),
    
          ],
        ),
    
        title: Text(
          "${widget.model!.fullName}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text("${widget.model!.msg}"),
        subtitle: Text("Hellow"),
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
          navigateTo(context, ChatDetailsScreen(userModel: widget.model!,),
        );    
        },
      ),
    );
  }
}