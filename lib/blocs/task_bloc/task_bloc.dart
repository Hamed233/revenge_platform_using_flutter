import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revenge_platform/models/project.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/task.dart';

part 'task_state.dart';

enum viewType {
  List,
  Sfoldergered
}

class TaskBloc extends Cubit<TaskStates> {
  TaskBloc() : super(TaskInitial());

  static TaskBloc get(context) => BlocProvider.of(context);

  // Change Tasks View
  var tasksViewType;

  void toggleViewType() {
    if(tasksViewType == viewType.List) {
      tasksViewType = viewType.Sfoldergered;
      emit(ToggleViewTasksType());
    } else  {
      tasksViewType = viewType.List;
      emit(ToggleViewTasksType());
    }
  }

  // ---- Task Bottom Sheet ----

  // Get Date of Task
  final DateTime today = new DateTime.now();
  late String startDate = new DateFormat('dd, MMMM yyyy').format(today).toString(),
      endDate = new DateFormat('dd, MMMM yyyy').format(today).toString();

  void getTaskDate(DateRangePickerSelectionChangedArgs args) {
    startDate =
        DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
    endDate =
        DateFormat('dd, MMMM yyyy').format(args.value.endDate ?? args.value.startDate).toString();
    emit(GetTaskDate());
  }

  // Get Time of Task
  // late String? fromTime = new DateFormat('hh:mm a').format(today).toString();
  // late String? toTime = today.add(Duration(hours: 1)).format('hh:mm a').toString();

  void getTaskRangeTime({start, end}) {
    if(start != null) {
      // fromTime = start.toString();
    } else if (end != null) {
      // toTime = end.toString();
    }
    emit(GetTaskTime());
  }

  // Check if is Selected Duration of Task
  bool isSelectedDuration = false;
  void selectedDuration() {
    emit(SelectedDurationLoading());
    isSelectedDuration = !isSelectedDuration;
    emit(SelectedDuration());
  }

  // Check if is Priority Changed of Task
  bool isPriority = false;
  void isPriorityChanged()  {
    isPriority = !isPriority;
    emit(IsPriorityChanged());
  }

  double taskRating = 1.0;

  void getTaskRating(double rating) {
    taskRating = rating;
    emit(TaskRating());
  }

  // ---------- Add Folder Sheet Bottom ---------------

  IconData? folderIcon = Icons.folder;
  var indexOfCurrentIcon = 0;

  List icons = [
    Icons.folder,
    Icons.hail,
    Icons.dangerous,
    Icons.help_sharp,
    Icons.leaderboard,
    Icons.motion_photos_auto,
    Icons.work,
    Icons.safety_divider,
    Icons.vaccines,
    Icons.safety_divider_sharp,
    Icons.deblur_outlined,
  ];

  void changeIconFolder(int indexOfIcon) {
    folderIcon = icons[indexOfIcon];
    indexOfCurrentIcon = indexOfIcon;
    emit(ChangeIconFolder());
  }

  Color folderColor = Color(4294085505);
  var indexOfCurrentColor = 1;

  final colors = [
    Color(4294967295), // classic white
    Color(4294085505), // light pink
    Color(4294425858), // yellow
    Color(4294702198), // light yellow
    Color(4291690384), // light green
    Color(4289199851), // turquoise
    Color(4291555576), // light cyan
    Color(4289711098), // light blue
    Color(4292325116), // plum
    Color(4294692841), // misty rose
    Color(4293314985), // light brown
    Color(4293520110)  // light gray
  ];


  void colorChangeTapped(int indexOfColor) {
    folderColor = colors[indexOfColor];
    indexOfCurrentColor = indexOfColor;
    emit(ColorOfFolderChangeTapped());
  }

  List<Project> allProjectsList = [];

  Future getProjectsList() async {
    
    emit(GettingProjectsFoldergedLoading());
    
    allProjectsList = [];

    // Database db = await DatabaseHelper.instance.db;
    // final List<Map<String, dynamic>> projectsMapList = await db.query(DatabaseHelper.instance.projectsTable);
    // projectsMapList.forEach((data) {
    //   allProjectsList.add(Project.fromMap(data));
    // });

    emit(RetrieveProjectsFoldergedDataSuccess());
  }

  // Get Project Folderged Id of Task
  int? projectTaggedId = 1;
  void getProjectTagged(id)  {
    projectTaggedId = id!;
    // getTaggDataFromDB(projectTagggedId);
    emit(GetProjectTagged());
  }
  
  String? sortType = CacheHelper.getData(key: 'sortType');
  void sortBy(_sortType)  {
    emit(GetNewSortLoading());
    print(sortType);
    CacheHelper.saveData(
      key: 'sortType',
      value: _sortType,
    );
    sortType = CacheHelper.getData(key: 'sortType');
    print(sortType);
    getTaskList(sortBy: sortType);
    emit(GetNewSort());
  }

  // ---------- Task Item ---------------
  bool tasksListView = false;

  void tasksToggleView() {
    tasksListView = !tasksListView;
    emit(TasksToggleView());
  }

  List<Task> searchList = [];
  // Search tasks
  Future search(String text) async {
    emit(SearchTaskLoadingState());

    // Database db = await DatabaseHelper.instance.db;
    // db.rawQuery('SELECT * FROM tasks_tbl WHERE task_title LIKE ? OR task_description LIKE ?', ['%$text%', '%$text%']).then((value) {
    //   emit(SearchTaskSuccessState());
    //   searchList = [];
    //   value.forEach((element) {
    //     searchList.add(Task.fromMap(element));
    //   });
    //   emit(RetrieveTaskDataFromDatabase());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(SearchTaskErrorState());
    // });
  }

  List<Task> allTasksList = [];
  List<Task> staticTasksList = [];
  List<Task> inProgressTasksList = [];
  List<Task> priorityTasksList = [];
  List<Task> mightTasksList = [];
  List<Task> doneTasksList = [];
  List<Task> archivedTasksList = [];
  // Plans
  List<Task> dayPlan = [];
  List<Task> weekPlan = [];
  List<Task> monthPlan = [];
  List<Task> halfYearPlan = [];
  List<Task> yearPlan = [];

  // Future<List<Map<String, dynamic>>> getMapTaskList(sortBy) async {
    // Database db = await DatabaseHelper.instance.db;
    // final List<Map<String, dynamic>> result = await db.query(DatabaseHelper.instance.tasksTable, orderBy: sortBy);
    // return result;
  // }

  Future getTaskList({sortBy}) async {
    
    emit(GettingTasksLoading());
    
    // List<Map<String, dynamic>> taskMapList = await getMapTaskList("id DESC");
    // if(sortBy == "New") {
    //   taskMapList = await getMapTaskList("id DESC");
    // } else if (sortBy == "Oldest") {
    //   taskMapList = await getMapTaskList("id ASC");
    // } else if (sortBy == "Priority") {
    //   taskMapList = await getMapTaskList("priority DESC");
    // } else if (sortBy == "Name") {
    //   taskMapList = await getMapTaskList("task_title");
    // }

    allTasksList = [];
    staticTasksList = [];
    inProgressTasksList = [];
    priorityTasksList = [];
    mightTasksList = [];
    doneTasksList = [];
    archivedTasksList = [];

    // Plans
    dayPlan = [];
    weekPlan = [];
    monthPlan = [];
    halfYearPlan = [];
    yearPlan = [];


    // taskMapList.forEach((taskMap) {
    //     allTasksList.add(Task.fromMap(taskMap));
    //     if (taskMap['is_archived'] == 1) {
    //       archivedTasksList.add(Task.fromMap(taskMap));
    //     } else if (taskMap['status'] == 0 && taskMap['is_archived'] == 0) {
    //       inProgressTasksList.add(Task.fromMap(taskMap));
    //     } else if (taskMap['status'] == 1 && taskMap['is_archived'] == 0) {
    //       doneTasksList.add(Task.fromMap(taskMap));
    //     } 
    //     if (taskMap['folder_task'] == 1) { // 1: Static Tasks id 
    //       staticTasksList.add(Task.fromMap(taskMap));
    //     }
    //     if (taskMap['priority'] >= 3.0) priorityTasksList.add(Task.fromMap(taskMap));
    //     if (taskMap['priority'] < 3.0) mightTasksList.add(Task.fromMap(taskMap));

    //     // plans
    //     if(taskMap['folder_title'] == "Day Plan") {
    //       dayPlan.add(Task.fromMap(taskMap));
    //     } else if (taskMap['folder_title'] == "Week Plan") {
    //       weekPlan.add(Task.fromMap(taskMap));
    //     } else if (taskMap['folder_title'] == "Month Plan") {
    //       monthPlan.add(Task.fromMap(taskMap));
    //     } else if (taskMap['folder_title'] == "Half-Year Plan") {
    //       halfYearPlan.add(Task.fromMap(taskMap));
    //     } else if (taskMap['folder_title'] == "Year Plan") {
    //       yearPlan.add(Task.fromMap(taskMap));
    //     }
    // });

    emit(RetrieveTaskDataFromDatabase());
  }

  Future checkDeadlineOfTasks(context) async {

    // List<Map<String, dynamic>> taskMapList = await getMapTaskList("id DESC");

    // taskMapList.forEach((element) {
      
    //   var endDateTimeAndTime = element['task_deadline'] + " " + element['task_end_time'];
    //   DateTime edt = DateFormat("dd, MMMM yyyy HH:mm a").parse(endDateTimeAndTime);
    //   var startDateTimeAndTime = element['task_start_date'] + " " + element['task_start_time'];
    //   DateTime sdt = DateFormat("dd, MMMM yyyy HH:mm a").parse(startDateTimeAndTime);
    //   DateTime currentDateTime = new DateTime.now();
    //   var currentDate = DateFormat("dd, MMMM yyyy").format(currentDateTime);
      
    //   if(element['status'] == 0 && element['is_archived'] == 0 && element['task_deadline'] == currentDate) {
    //         NotificationAPI.showScheduleNotification(context,
    //           id: element['id'],
    //           title: element['task_title'],
    //           body: "Due Date (" + sdt.toString() + " -> " +  edt.toString() + " )",
    //           tag_notification: element['folder_title'],
    //           startScheduleDate: sdt,
    //           endScheduleDate: edt,
    //           start_time: element['task_start_time'],
    //           end_time: element['task_end_time'], 
    //           payload: element['id'].toString(),
    //           remindeForDeadline: true,
    //     );
    //   }
    // });

    // emit(DoneCheckForDeadlineOfTasks());

  }

  // Future<List<Map<String, dynamic>>> getMapSpecificTask(taskId) async {
  //   Database db = await DatabaseHelper.instance.db;
  //   final List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM ${DatabaseHelper.instance.tasksTable} WHERE id = ${taskId}');
  //   return result;
  // }

  List taskData = [];
  // Get Specific task Date from db
  Future getTaskDataFromDB(taskId) async {

    // final List<Map<String, dynamic>> taskMapList = await getMapSpecificTask(taskId);
    taskData = [];

    emit(GettingTaskDataLoading());

    // taskMapList.forEach((taskMap) {
    //   taskData.add(taskMap);
    // });
      
    emit(RetrieveTaskDataFromDatabase());
  }


  // Get tasks of project from db
  Future getTasksOfProjectDataFromDB(projectId) async {
    // Database db = await DatabaseHelper.instance.db;
    // final List<Map<String, dynamic>> tasksProjectMapList = await db.rawQuery('SELECT * FROM ${DatabaseHelper.instance.tasksTable} WHERE project_tagged = ${projectId}');
    // tasksOfProjectData = [];

    // emit(GettingTasksProjectDataLoading());

    // tasksProjectMapList.forEach((projectMap) {
      // tasksOfProjectData.add(Task.fromMap(projectMap));
    // });
      
    // emit(RetrieveTasksProjectDataFromDatabase());
  }

}
