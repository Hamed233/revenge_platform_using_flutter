import 'package:flutter/material.dart';
import 'package:revenge_platform/screens/tasks/tasks_screen.dart';

class TasksProfileTab extends StatefulWidget {
  @override
  TasksProfileTabState createState() => TasksProfileTabState();
}

class TasksProfileTabState extends State<TasksProfileTab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TasksScreen();
  }
}