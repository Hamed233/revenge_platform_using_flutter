import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditCoverOrProfileImageScreen extends StatefulWidget {
  const EditCoverOrProfileImageScreen({Key? key}) : super(key: key);

  @override
  _EditCoverOrProfileImageScreenState createState() => _EditCoverOrProfileImageScreenState();
}

class _EditCoverOrProfileImageScreenState extends State<EditCoverOrProfileImageScreen> {
  // var user = UserData.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: const Text(
                "Upload a photo of yourself:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);
                      // setState(
                      //     () => user = user.copy(imagePath: newImage.path));
                    },
                    // child: Image.network(user.image),
                    child: Image.network("https://yt3.ggpht.com/ytc/AAUvwnihe-DJ8LqGo-CIKGvJif0xpv_8aWF0UWiDZJSpEQ=s176-c-k-c0xffffffff-no-rj-mo"),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
