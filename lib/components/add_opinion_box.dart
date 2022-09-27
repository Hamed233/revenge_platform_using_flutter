import 'package:flutter/material.dart';
import 'package:revenge_platform/components/default_form_field.dart';
import 'package:revenge_platform/components/styles/colors.dart';

class AddOpinionBox extends StatelessWidget {
  final String? hintText;
  const AddOpinionBox({this.hintText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController opinionController = TextEditingController();
    return Row(
      children: [
        Container(
          width: 35,
          child: TextButton(
            child: Text(
              "👍",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 35,
          child: TextButton(
            child: Text(
              "👎",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsetsDirectional.only(start: 5),
              height: 40,
              child: DefaultFormField(
                controller: opinionController,
                borderColor: Colors.grey,
                borderWidth: 50,
                hintText: hintText??"write your opinion",
                isSuffix: true,
                suffix: Icons.send,
                suffixColorIcon: AppColors.appMainColors,
                suffixPressed: () {
                  print("send");
                },
              )),
        ),
      ],
    );
  }
}
