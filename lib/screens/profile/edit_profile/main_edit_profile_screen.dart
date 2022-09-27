import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/widgets/profile_widgets/display_image_widget.dart';
import 'package:revenge_platform/screens/profile/edit_profile/edit_bio.dart';
import 'package:revenge_platform/screens/profile/edit_profile/edit_image.dart';
import 'package:revenge_platform/screens/profile/edit_profile/edit_name.dart';
import 'package:revenge_platform/screens/profile/edit_profile/edit_profile_form_field.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // background image and bottom contents
              Column(

                children: [
              
                Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260")),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final coverImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (coverImage == null) return;

                            final location = await getApplicationDocumentsDirectory();
                            final name = basename(coverImage.path);
                            final coverImageFile = File('${location.path}/$name');
                            final newcoverImage =
                                await File(coverImage.path).copy(coverImageFile.path);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 25.0, start: 20, end: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "General",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),

                buildUserInfoDisplay(context, 
                    "Hamed Essam", 'Name', EditNameFormPage()),
                bioBuilder(context),

                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 25.0, start: 20, end: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Social links",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),

                buildUserInfoDisplay(context, 
                    "https://facebook.com", 'Facebook URL',  EditProfileFormFieldScreen("facebook_url")),
                buildUserInfoDisplay(context, 
                    "https://instagram.com", 'Instagram URL',  EditProfileFormFieldScreen("insta_url")),
                buildUserInfoDisplay(context, 
                    "https://twitter.com", 'Twitter URL',  EditProfileFormFieldScreen("twitter_url")),
                buildUserInfoDisplay(context, 
                    "https://website.com", 'Website URL',  EditProfileFormFieldScreen("website_url")),

                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 25.0, start: 20, end: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Contact",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),

                buildUserInfoDisplay(context, 
                    "hamed@info.com", 'Business Email', EditProfileFormFieldScreen("email")),
                buildUserInfoDisplay(context, 
                    "01029222348", 'Phone', EditProfileFormFieldScreen("phone")),
              ]),

              Positioned(
                top:
                    120.0, // (background container size) - (circle height / 2)
                child: InkWell(
                  onTap: () async {
                      final profileImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (profileImage == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(profileImage.path);
                      final profileImageFile = File('${location.path}/$name');
                      final newProfileImage =
                          await File(profileImage.path).copy(profileImageFile.path);
                  },
                  child: DisplayImage(
                    imagePath:
                        "https://yt3.ggpht.com/ytc/AAUvwnihe-DJ8LqGo-CIKGvJif0xpv_8aWF0UWiDZJSpEQ=s176-c-k-c0xffffffff-no-rj-mo",
                    onPressed: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(context, String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 20.0, start: 20, end: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title + ": ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => navigateTo(context, editPage),
                child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getValue,
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                        ])),
              )
            ],
          ));

  // Widget builds the About Me Section
  Widget bioBuilder(context, {User? user}) => Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 20.0, start: 20, end: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your bio: ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => navigateTo(context, EditBioFormScreen()),
            child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ))),
                child: Center(
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Text(
                            "Donec sollicitudin molestie malesuada. Curabitur aliquet quam id d Curabitur  m id d Curabitur  m id d Curabitur  m id d Curabitur  m id d Curabitur aliquet quam id d Curabitur aliquet quam id d Curabitur aliquet quam id dui posuere blandit. Sed porttitor lectus nibh. Cras ultricies ligula sed magna dictum porta.",
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.4,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            ),
                          )),
                            const Spacer(),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 30.0,
                    )
                  ]),
                )),
          )
        ],
      ));


}
