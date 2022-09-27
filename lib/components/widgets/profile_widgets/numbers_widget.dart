import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/screens/followers_and_followning_screens/following_screen.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsetsDirectional.only(start: 10,end: 10),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, '4.8M', 'Views'),
            buildDivider(),
            buildButton(context, '50M', 'Followers', onPressed: () => navigateTo(context, FollowingScreen())),
            buildDivider(),
            buildButton(context, '50', 'Clients'),
          ],
        ),
  );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text, {Function()? onPressed}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color.fromARGB(255, 224, 224, 224),
            width: 1
          )
        ),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 4),
          onPressed: onPressed,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 2),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}