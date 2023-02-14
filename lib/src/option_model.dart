import 'package:flutter/material.dart';

class OptionModel {
  int? no;
  IconData? icon;
  String? title;
  String? subtitle;
  String? img;
  String? time;
  bool? checked;
  OptionModel({
    this.no = 1,
    this.icon,
    this.title,
    this.time,
    this.subtitle,
    this.img,
    this.checked = false,
  });
}

class OptionGroup {
  String? title;
  int? type;
  List<OptionModel>? listOption;
  OptionModel? choiceOption;
  OptionGroup({this.listOption, this.title, this.type});
}

class Service {
  String? sander;
  String? serviceType;
  String? petType;
  String? petsize;
  String? location;
  String? packge;
  String? serviceprice;
  String? staff;
}
