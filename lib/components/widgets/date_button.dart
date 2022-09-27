import 'package:flutter/material.dart';

class DateButton extends StatelessWidget {
  final String text;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final VoidCallback onTap;

  const DateButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.prefixWidget,
    this.suffixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(.5),
        ),
      ),
      child: Padding(
          padding: EdgeInsetsDirectional.only(start: 7, end: 7, top: 14, bottom: 14),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                prefixWidget ?? Container(),
                SizedBox(width: 5,),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          )),
    );
  }
}