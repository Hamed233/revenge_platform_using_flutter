import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/routes/argument_bundle.dart';
import 'package:revenge_platform/screens/tasks/list_of_tasks.dart';

import '../../blocs/task_bloc/task_bloc.dart';
import '../../routes/page_path.dart';

class TaskItems extends StatelessWidget {

  final ArgumentBundle bundle;

  TaskItems({required this.bundle});

  var title;
  var tasks;

  @override
  Widget build(BuildContext context) {
    var typeOfTasks = bundle.identifier;
    var tagName = bundle.extras;
    
    return BlocConsumer<TaskBloc, TaskStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var taskBloc = TaskBloc.get(context);
          if(typeOfTasks == "all_tasks") {
            title = Text("All Tasks", style: TextStyle(color: Colors.white));
            tasks = taskBloc.allTasksList;
          } else if (typeOfTasks == "static") {
            title = Text("Static Tasks", style: TextStyle(color: Colors.white));
            tasks = taskBloc.staticTasksList;
          } else if (typeOfTasks == "inprogress") {
            title = Text("Inprogress Tasks", style: TextStyle(color: Colors.white));
            tasks = taskBloc.inProgressTasksList;
          } else if (typeOfTasks == "priority") {
            title = Text("Priority Tasks", style: TextStyle(color: Colors.white));
            tasks = taskBloc.priorityTasksList;
          } else if (typeOfTasks == "might") {
            title = Text("Might Tasks", style: TextStyle(color: Colors.white));
            tasks = taskBloc.mightTasksList;
          } else if (typeOfTasks == "done") {
            title = Text("Done Tasks", style: TextStyle(color: Colors.white));
            tasks = taskBloc.doneTasksList;
          } else if (typeOfTasks == "archived") {
            title = Text("Archived Tasks", style: TextStyle(color: Colors.white));
            tasks = taskBloc.archivedTasksList;
          } else if (typeOfTasks == "day") {
            title = Text("Day Plan", style: TextStyle(color: Colors.white));
            tasks = taskBloc.dayPlan;
          } else if (typeOfTasks == "week") {
            title = Text("Week Plan", style: TextStyle(color: Colors.white));
            tasks = taskBloc.weekPlan;
          } else if (typeOfTasks == "month") {
            title = Text("Month Plan", style: TextStyle(color: Colors.white));
            tasks = taskBloc.monthPlan;
          } else if (typeOfTasks == "half_year") {
            title = Text("Half-Year Plan", style: TextStyle(color: Colors.white));
            tasks = taskBloc.halfYearPlan;
          } else if (typeOfTasks == "year") {
            title = Text("Year Plan", style: TextStyle(color: Colors.white));
            tasks = taskBloc.yearPlan;
          } else if (typeOfTasks == "project") {
            // tasks = taskBloc.tasksOfProjectData;
            title = Text("Project Tasks", style: TextStyle(color: Colors.white));
          } else {
            // tasks = taskBloc.tasksFolderData;
            title = Text("Tasks Taged ( " + tagName + " )", style: TextStyle(color: Colors.white));
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                    Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0,
              backgroundColor: AppColors.appMainColors,
              title: title,
              titleSpacing: 0,
              shadowColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PagePath.searchScreen,
                        arguments: ArgumentBundle(extras: "Tasks Search", identifier: 'tasks'),
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                ),
                IconButton(
                    onPressed: () {
                      taskBloc.tasksToggleView();
                    },
                    icon: Icon(
                      taskBloc.tasksListView ? Icons.view_headline : Icons.view_agenda_rounded,
                      color: Colors.white,
                    )
                ),

                IconButton(
                    onPressed: () {
                      // Helper.showMoreDetailsBottomSheet(context);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    )
                ),
                
              ],
            ),
            body: Container(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ConditionalBuilder(
                    condition: state is! GettingTasksLoading || state is! GetNewSortLoading || state is! CreateTaskDatabaseLoading || state is! ToggleAsDoneTask,
                    builder: (context) => Container(
                      child: ConditionalBuilder(
                        condition: tasks.length != 0,
                        builder: (context) => Column(
                          children: List.generate(
                            tasks.length,
                                (index) {
                              return ListOfTasks(bundle: ArgumentBundle(extras: tasks[index]),);
                            },
                          ),
                        ),
                        fallback: (context) => Center(
                          child: SvgPicture.asset(Resources.empty, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * .75,),),
                      ),
                    ),
                    fallback: (context) => Center(child: CircularProgressIndicator(color: AppColors.appMainColors,), heightFactor: 15,),
                  )
              ),
            ),
            floatingActionButton: FloatingActionButton(
                  backgroundColor: AppColors.appMainColors,
                  child: Icon(Icons.add),
                  onPressed: () {
                    // if(isNumeric(typeOfTasks.toString())) {
                      // Helper.showTaskBottomSheet(context, folderId: typeOfTasks);
                    // } else {
                      // Helper.showTaskBottomSheet(context);
                    // }
                  }
              ),
          );
        }
    );
  }
}
