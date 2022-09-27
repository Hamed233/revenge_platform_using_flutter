import 'package:flutter/material.dart';
import 'package:revenge_platform/components/styles/colors.dart';

navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// ----------- Navigate And finish component ----------------
navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

// Default Button
Widget defaultTextButton({
  required Function()? function,
  required String text,
  IconData? icon,
  Color? color,
}) =>
    TextButton(
      onPressed: function,
      child: Row(
        children: [
          Text(
            text.toUpperCase(),
            style: TextStyle(color: color ?? AppColors.appMainColors, fontSize: 15),
          ),
          SizedBox(
            width: 1,
          ),
          Icon(
            icon,
            color: AppColors.appMainColors,
            size: 15,
          ),
        ],
      ),
    );

showCustomSnackBar(BuildContext context,
      {required String content, required Color bgColor, required Color textColor}) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: TextStyle(
          color: textColor,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: bgColor.withOpacity(0.7),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
