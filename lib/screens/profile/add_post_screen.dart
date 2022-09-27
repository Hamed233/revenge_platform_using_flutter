import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';

class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    TextEditingController postController = TextEditingController();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, size: 26,),
          onPressed: () {},
        ),
        title: Text("New Post"),
        centerTitle: true,
        elevation: .5,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Post",
              style: TextStyle(
                color: AppColors.appMainColors,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Stack(
          children: [ 
            Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: 200, // if there image
                ),
                child: TextFormField(
                  // expands: true,
                  autofocus: true,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length > 200) {
                      return 'Please describe yourself but keep it under 200 characters.';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  controller: postController,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  minLines: null,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                      border: InputBorder.none,
                      
                      hintText: 'Write a post...'),
                ),
              ),
        
              // post.imageUrl != null ? 
              // const SizedBox.shrink(),
                        // : const SizedBox(height: 6.0),
              
              // If set image
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://yt3.ggpht.com/ytc/AAUvwnhuheOArV1o5BSo10TdUivctyIHSfzYGKLwudMCdg=s176-c-k-c0xffffffff-no-rj-mo")
                      ),
                      border: Border.all(color: Color.fromARGB(255, 235, 235, 235))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(57, 167, 166, 166),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ),
        
              
              
            ],
          ),

          // const SizedBox(height: 30,),
          Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color.fromARGB(255, 220, 219, 219),) 
                    )
                  ),
                  child: Row(
                    children: [
                      FlatButton.icon(
                        onPressed: () => print('Live'),
                        icon: const Icon(
                          Icons.videocam,
                          color: Colors.red,
                        ),
                        label: Text('Video'),
                      ),
                      FlatButton.icon(
                        onPressed: () => print('Photo'),
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.green,
                        ),
                        label: Text('Photo'),
                      
                      ),
                    ],
                  )
                
                ),
              ),
          ],
        )),
    );
  }
}