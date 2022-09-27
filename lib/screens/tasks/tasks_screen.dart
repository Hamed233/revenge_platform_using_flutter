import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:revenge_platform/blocs/task_bloc/task_bloc.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/routes/argument_bundle.dart';

import '../../routes/page_path.dart';

class TasksScreen extends StatelessWidget {

  final List<Color> colorsList = [
    HexColor("#474956"),
    HexColor("#051367"),
    HexColor("#61cfed"),
    HexColor("#09759f"),
    HexColor("#5cce99"),
    HexColor("#7d83c5"),
    HexColor("#ffcf97"),
  ];
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {

        Widget _content = Text("Test");

        var taskBloc = TaskBloc.get(context);

        // int numberOfAllTasks = taskBloc.allTasksList.length;
        // int numberOfStaticTasks = taskBloc.staticTasksList.length;
        // int numberOfInProgressTasks = taskBloc.inProgressTasksList.length;
        // int numberOfDoneTasks = taskBloc.doneTasksList.length;
        // int numberOfArchivedTasks = taskBloc.archivedTasksList.length;
        // int numberOfPriorityTasks = taskBloc.priorityTasksList.length;
        // int numberOfMightTasks = taskBloc.mightTasksList.length;
        
        // // plans
        // int numberOfDayPlan = taskBloc.dayPlan.length;
        // int numberOfWeekPlan = taskBloc.weekPlan.length;
        // int numberOfMonthPlan = taskBloc.monthPlan.length;
        // int numberOfHalfYearPlan = taskBloc.halfYearPlan.length;
        // int numberOfYearPlan = taskBloc.yearPlan.length;
        // calculate percentage is: (value/total value)×100%.
        // Map<String, double> dataMap = {
        //   "All": numberOfAllTasks != 0 ? (numberOfAllTasks/numberOfAllTasks)*100 : 0,
        //   "Static": numberOfStaticTasks != 0 ? (numberOfStaticTasks/numberOfAllTasks)*100 : 0,
        //   "Done": numberOfDoneTasks != 0 ? (numberOfDoneTasks/numberOfAllTasks)*100 : 0,
        //   "Inprogress": numberOfInProgressTasks != 0 ? (numberOfInProgressTasks/numberOfAllTasks)*100 : 0,
        //   "Priority": numberOfPriorityTasks != 0 ? (numberOfPriorityTasks/numberOfAllTasks)*100 : 0,
        //   "Might": numberOfMightTasks != 0 ? (numberOfMightTasks/numberOfAllTasks)*100 : 0,
        //   "Archived": numberOfArchivedTasks != 0 ? (numberOfArchivedTasks/numberOfAllTasks)*100 : 0,
        // };
    
    
        // if(TaskBloc.tasksViewType == viewType.List) {
        //   _content = Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         children: [
        //           SvgPicture.asset(Resources.basicTitle, width: 20, height: 25,),
        //           SizedBox(width: 5,),
        //           Text(
        //             "Basics".toUpperCase(),
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 10),
        //       listTasks(context, Icons.all_inbox_outlined, false, true, "All Tasks", numberOfAllTasks, AppTheme.allTasksColor, Colors.white, PagePath.tasksOfCategoryScreen, "all_tasks", 0),
        //       SizedBox(height: 10),
        //       listTasks(context, SvgPicture.asset(Resources.staticTasks, width: 20, height: 25,), true, true, "Static", numberOfStaticTasks, AppTheme.staticTasksColor, Colors.white, PagePath.tasksOfCategoryScreen, "static", 0),
        //       SizedBox(height: 10),
        //       listTasks(context, Icons.play_for_work, false, true, "Inprogress", numberOfInProgressTasks, AppTheme.inprogressTasksColor, Colors.white, PagePath.tasksOfCategoryScreen, "inprogress", 0),
        //       SizedBox(height: 10.0,),
        //       listTasks(context, Icons.priority_high, false, true, "Priority-Tasks", numberOfPriorityTasks, AppTheme.priorityTasksColor, Colors.white, PagePath.tasksOfCategoryScreen, "priority", 20),
        //       SizedBox(height: 10.0,),
        //       listTasks(context, Icons.notification_important, false, true, "Might-Tasks", numberOfMightTasks, AppTheme.mightTasksColor, Colors.white, PagePath.tasksOfCategoryScreen, "might", 20),
        //       SizedBox(height: 10.0,),
        //       listTasks(context, Icons.done, false, true, "Done", numberOfDoneTasks, AppTheme.doneTasksColor, Colors.white, PagePath.tasksOfCategoryScreen, "done", 0),
        //       SizedBox(height: 10.0,),
        //       listTasks(context, Icons.archive, false, true, "Archived", numberOfArchivedTasks, AppTheme.archivedTasksColor, Colors.white, PagePath.tasksOfCategoryScreen, "archived", 0),
        //       SizedBox(height: 30),
        //       myDivider(),
        //       SizedBox(height: 30),
        //       Row(
        //         children: [
        //           SvgPicture.asset(Resources.planTitle, width: 20, height: 25,),
        //           SizedBox(width: 5,),
        //           Text(
        //             "Plans".toUpperCase(),
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 10),
        //       listTasks(context, SvgPicture.asset(Resources.day, width: 20, height: 25,), true, false, "Day", numberOfDayPlan, Colors.transparent, HexColor("#e8ce60"), PagePath.tasksOfCategoryScreen, "day", 0),
        //       SizedBox(height: 10),
        //       listTasks(context, SvgPicture.asset(Resources.week, width: 20, height: 25,), true, false, "Week", numberOfWeekPlan, Colors.transparent, HexColor("#e2574c"), PagePath.tasksOfCategoryScreen, "week", 0),
        //       SizedBox(height: 10),
        //       listTasks(context, SvgPicture.asset(Resources.month, width: 20, height: 25,), true, false, "Month", numberOfMonthPlan, Colors.transparent, HexColor("#e2574c"), PagePath.tasksOfCategoryScreen, "month", 0),
        //       SizedBox(height: 10),
        //       listTasks(context, SvgPicture.asset(Resources.halfYear, width: 20, height: 25,), true, false, "Half-Year", numberOfHalfYearPlan, Colors.transparent, HexColor("#e2574c"), PagePath.tasksOfCategoryScreen, "half_year", 0),
        //       SizedBox(height: 10),
        //       listTasks(context, SvgPicture.asset(Resources.year, width: 20, height: 25,), true, false, "Year", numberOfYearPlan, Colors.transparent, HexColor("#e2574c"), PagePath.tasksOfCategoryScreen, "year", 0),
              
        //       SizedBox(height: 30),
        //       myDivider(),
        //       SizedBox(height: 30),
        //       Row(
        //         children: [
        //           Icon(
        //             Icons.folder,
        //             color: Colors.amber,
        //             size: 30,
        //           ),
        //           SizedBox(width: 5,),
        //           Text(
        //             "Folders".toUpperCase(),
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ),
        //           Spacer(),
        //           IconButton(
        //             icon: Icon(
        //               Icons.add,
        //               color: Colors.amber,
        //               size: 30,
        //               ),
        //               onPressed: () => Helper.showAddFolderBottomSheet(context),
        //             ),
        //         ],
        //       ),
        //       SizedBox(height: 10),
        //       if(TaskBloc.allFoldersWithoutBuiltIn.length != 0)
        //           Container(
        //             height: 200,
        //             child: ListView.builder(
        //               itemBuilder: (BuildContext context, int index) => folderBuilder(context, TaskBloc.allFoldersWithoutBuiltIn[index]),
        //               itemCount: TaskBloc.allFoldersWithoutBuiltIn.length,
        //               ),
        //           ),
        //     ],
        //   );
        // } else {
        //   _content = Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       if(dataMap.isNotEmpty)
        //         chartBuilder(context, dataMap, colorsList),
        //       Row(
        //         children: [
        //           SvgPicture.asset(Resources.basicTitle, width: 20, height: 25,),
        //           SizedBox(width: 5,),
        //           Text(
        //             "Basics".toUpperCase(),
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 10,),
        //       Row(
        //         children: [
        //           boxBuilder(context, Icons.all_inbox_outlined, "All Tasks", numberOfAllTasks.toString(), AppTheme.allTasksColor, PagePath.tasksOfCategoryScreen, "all_tasks"),
        //         ],
        //       ),
        //       SizedBox(height: 5,),
        //       Row(
        //         children: [
        //           boxBuilder(context, SvgPicture.asset(Resources.staticTasks, width: 20, height: 25,), "Static", numberOfStaticTasks.toString(), AppTheme.staticTasksColor, PagePath.tasksOfCategoryScreen, "static", is_icon: false),
        //           SizedBox(width: 5.0,),
        //           boxBuilder(context, Icons.play_for_work, "Inprogress", numberOfInProgressTasks.toString(), AppTheme.inprogressTasksColor, PagePath.tasksOfCategoryScreen, "inprogress",),
        //         ],
        //       ),
        //       SizedBox(height: 5,),
        //       Row(
        //         children: [
        //           boxBuilder(context, Icons.notification_important, "Priority", numberOfPriorityTasks.toString(), AppTheme.mightTasksColor, PagePath.tasksOfCategoryScreen, "priority"),
        //           SizedBox(width: 5.0,),
        //           boxBuilder(context, Icons.priority_high, "Might", numberOfMightTasks.toString(), AppTheme.mightTasksColor, PagePath.tasksOfCategoryScreen, "might"),
        //         ],
        //       ),
        //       SizedBox(height: 5,),
        //       Row(
        //         children: [
        //           boxBuilder(context, Icons.done, "Done", numberOfDoneTasks.toString(), AppTheme.doneTasksColor, PagePath.tasksOfCategoryScreen, "done"),
        //           SizedBox(width: 5.0,),
        //           boxBuilder(context, Icons.archive, "Archived", numberOfArchivedTasks.toString(), AppTheme.archivedTasksColor, PagePath.tasksOfCategoryScreen, "archived"),
        //         ],
        //       ),
        //       SizedBox(height: 20,),
        //       Row(
        //         children: [
        //           SvgPicture.asset(Resources.planTitle, width: 20, height: 25,),
        //           SizedBox(width: 5,),
        //           Text(
        //             "Plans".toUpperCase(),
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ),
        //         ],
        //       ),
        //       SizedBox(height: 10,),
        //       Row(
        //         children: [
        //           boxBuilder(context, SvgPicture.asset(Resources.day, width: 20, height: 30,), "Day", numberOfDayPlan.toString(), Colors.transparent, PagePath.tasksOfCategoryScreen, "day", is_icon: false, arrow_icon_color: HexColor("#e8ce60"), titleContainerColor: HexColor("#e8ce60"), borderColor: HexColor("#e8ce60")),
        //           SizedBox(width: 5.0,),
        //           boxBuilder(context, SvgPicture.asset(Resources.week, width: 20, height: 30,), "Week", numberOfWeekPlan.toString(), Colors.transparent, PagePath.tasksOfCategoryScreen, "week", is_icon: false,  arrow_icon_color: HexColor("#e2574c"), titleContainerColor: HexColor("#e2574c"), borderColor: HexColor("#e2574c")),
        //         ],
        //       ),
        //       SizedBox(height: 5,),
        //       Row(
        //         children: [
        //           boxBuilder(context, SvgPicture.asset(Resources.month, width: 20, height: 30,), "Month", numberOfMonthPlan.toString(),Colors.transparent, PagePath.tasksOfCategoryScreen, "month", is_icon: false, arrow_icon_color: HexColor("#e2574c"), titleContainerColor: HexColor("#e2574c"), borderColor: HexColor("#e2574c")),
        //           SizedBox(width: 5.0,),
        //           boxBuilder(context, SvgPicture.asset(Resources.halfYear, width: 20, height: 30,), "Half-Year", numberOfHalfYearPlan.toString(), Colors.transparent, PagePath.tasksOfCategoryScreen, "half_year", is_icon: false, arrow_icon_color: HexColor("#e2574c"), titleContainerColor: HexColor("#e2574c"), borderColor: HexColor("#e2574c")),
        //         ],
        //       ),
        //       SizedBox(height: 5,),
        //       Row(
        //         children: [
        //           boxBuilder(context, SvgPicture.asset(Resources.year, width: 20, height: 30,), "Year", numberOfDayPlan.toString(), Colors.transparent, PagePath.tasksOfCategoryScreen, "year", is_icon: false, arrow_icon_color: HexColor("#e2574c"), titleContainerColor: HexColor("#e2574c"), borderColor: HexColor("#e2574c")),
        //         ],
        //       ),
        //       SizedBox(height: 10),
        //       Row(
        //         children: [
        //           Icon(
        //             Icons.folder,
        //             color: Colors.amber,
        //             size: 30,
        //           ),
        //           SizedBox(width: 5,),
        //           Text(
        //             "Folders".toUpperCase(),
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ),
        //           Spacer(),
        //           IconButton(
        //             icon: Icon(
        //               Icons.add,
        //               color: Colors.amber,
        //               size: 30,
        //               ),
        //               onPressed: () => Helper.showAddFolderBottomSheet(context),
        //             ),
        //         ],
        //       ),
        //       // if(TaskBloc.allFoldersWithoutBuiltIn.length != 0)
        //           Container(
        //             height: 200,
        //             child: ListView.builder(
        //               itemBuilder: (BuildContext context, int index) => folderBuilder(context, TaskBloc.allFoldersWithoutBuiltIn[index]),
        //               itemCount: TaskBloc.allFoldersWithoutBuiltIn.length,
        //               ),
        //           ),           
        //     ],
        //   );
        // }
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: state is GettingTasksLoading || state is GettingFoldersLoading ? Center(child: CircularProgressIndicator(color: AppColors.appMainColors,),) : _content,
              ),
            ),
        );
      },
    );
  }
}

