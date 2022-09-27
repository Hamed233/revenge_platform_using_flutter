import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditProfileFormFieldScreen extends StatelessWidget {
  String typeOfField;
  EditProfileFormFieldScreen(this.typeOfField, {Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final fieldController = TextEditingController();
  var title = "";
  var keyBoardType = TextInputType.text;
  // var user = UserData.myUser;


  void updateUserValue(String phone) {
    String formattedPhoneNumber = "(" +
        phone.substring(0, 3) +
        ") " +
        phone.substring(3, 6) +
        "-" +
        phone.substring(6, phone.length);
    // user.phone = formattedPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {


    if(typeOfField == "phone") {
      title = "phone number";
      keyBoardType = TextInputType.number;
    } else if (typeOfField == "email") {
      title = "Business Email";
      keyBoardType = TextInputType.emailAddress;
    } else if (typeOfField == "facebook_url") {
      title = "Facebook URL";
    } else if (typeOfField == "insta_url") {
      title = "Instagram URL";
    } else if (typeOfField == "twitter_url") {
      title = "Twittwr URL";
    } else if (typeOfField == "website_url") {
      title = "Website URL";
    } 
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(title.toUpperCase()),
          centerTitle: true,
          elevation: .4,
        ),        
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Edit " + title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: SizedBox(
                            width: 320,
                            child: TextFormField(
                              // Handles Form Validation
                              keyboardType: keyBoardType,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Input can\'t be empty';
                                } 
                                
                                if(typeOfField == "phone") {
                                  if (isAlpha(value)) {
                                    return 'Only Numbers Please';
                                  } else if (value.length < 10) {
                                    return 'Please enter a VALID phone number';
                                  }
                                } else if(typeOfField == "email") {

                                } else {
                                  // links
                                  bool _validURL = Uri.parse(value).isAbsolute;
                                  if(!_validURL) {
                                    return 'Please enter a valid URL!';
                                  }
                                }
                                
                                return null;
                              },
                              controller: fieldController,
                              decoration: InputDecoration(
                                labelText: 'Your ' + title,
                              ),
                            ))),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 320,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()) {
                                    if(typeOfField == "email" && EmailValidator.validate(fieldController.text)) {
                                      // updateUserValue(emailController.text);
                                      Navigator.pop(context);
                                    } else if (typeOfField == "phone" && isNumeric(fieldController.text)) {

                                      Navigator.pop(context);
                                    } else {
                                        // Links
                                        Navigator.pop(context);
                                    }
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
          ),
        ));
  }
}
