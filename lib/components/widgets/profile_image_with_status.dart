import 'package:flutter/material.dart';

class ProfileImageWithStatus extends StatelessWidget {
  final double? radius;

  ProfileImageWithStatus({Key? key, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: radius??25.0,
          backgroundImage: NetworkImage(
              "https://yt3.ggpht.com/ytc/AAUvwnjcXhQ1Tl-tCyXrovuQwBMHrFwE9uMzzclq2SzHjg=s176-c-k-c0xffffffff-no-rj-mo"),
          //  child: widget.model!.image == '' ? Text(widget.model!.fullName!.substring(0, 1).toUpperCase()) : null,
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
    );
  }
}
