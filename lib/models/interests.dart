import 'package:flutter/cupertino.dart';

class InterestModel {
  bool? isChosen;
  String? title;
  String? icon;

  InterestModel({this.title, this.isChosen = false, this.icon});
}