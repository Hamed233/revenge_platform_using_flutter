import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';

class PersonContainer extends StatefulWidget {
// final String personId;

  PersonContainer({
    Key? key,
    // required this.personId,
  }) : super(key: key);

  @override
  _PersonContainerState createState() => _PersonContainerState();
}

class _PersonContainerState extends State<PersonContainer> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/app_logo.png",
              ),
              radius: 25,
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
                      color: true ? Colors.greenAccent : Colors.grey,
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
          "Hamed Essam",
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          "300 followers",
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: Container(
            height: 35,
            width: 100,
            // child: filledBtn(
            //     10.0, "follow", AppColors.appMainColors, Colors.white)
                ),
        onTap: () {
          // navigateTo(context, Conversation());
        },
      ),
    );
  }
}
