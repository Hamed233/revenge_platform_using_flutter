import 'package:flutter/material.dart';

// This class handles the Page to edit the About Me Section of the User Profile.
class EditBioFormScreen extends StatefulWidget {
  @override
  _EditBioFormScreenState createState() =>
      _EditBioFormScreenState();
}

class _EditBioFormScreenState extends State<EditBioFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  // var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    // user.aboutMeDescription = description;
  }

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
          title: Text("Edit Bio"),
          centerTitle: true,
          elevation: .4,
        ),
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Write some information about yourself",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            // Handles Form Validation
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 200) {
                                return 'Please describe yourself but keep it under 200 characters.';
                              }
                              return null;
                            },
                            controller: descriptionController,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 10, 100),
                                hintMaxLines: 3,
                                hintText:
                                    'Write a little bit about yourself. Do you like chatting? Are you a smoker? Do you bring pets with you? Etc.'),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 350,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  updateUserValue(descriptionController.text);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          )))
                ]),
          ),
        ));
  }
}
