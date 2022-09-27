import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheets {

  // ------------------ Task Sheet -------------------------
   static showTaskBottomSheet(
      BuildContext context, {
        int taskId = 0,
        int folderId = 0,
        int? categoryId = 0,
        bool isUpdate = false,
      }) {
    if(isUpdate) {
      // TaskCubit.get(context).isSelectedDuration = true;
      // TaskCubit.get(context).getTaskDataFromDB(taskId);
    }
      
    // TaskCubit.get(context).getProjectsList();

    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      enableDrag: true,
      topRadius: Radius.circular(20),
      backgroundColor: Colors.transparent,
      builder: (context) { 
        // return TaskSheet(isUpdate, taskId);
        return Text("Test");
      }
    ).then((value) {
          
      
    });
  }


  // ---------------------------- SnackBar ------------------------------------
  static showCustomSnackBar(BuildContext context,
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
}