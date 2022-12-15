import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

bool isIos = false;

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    OthersHelper().showToast("Please turn on your internet connection", Colors.black);
    return false;
  } else {
    return true;
  }
}

twoDouble(double value) {
  return double.parse(value.toStringAsFixed(1));
}

getYear(value) {
  final f = DateFormat('yyyy');
  var d = f.format(value);
  return d;
}

getTime(value) {
  final f = DateFormat('hh:mm a');
  var d = f.format(value);
  return d;
}

getDate(value) {
  final f = DateFormat('yyyy-MM-dd');
  var d = f.format(value);
  return d;
}

getMonthAndDate(value) {
  final f = DateFormat("MMMM dd");
  var d = f.format(value);
  return d;
}

firstThreeLetter(value) {
  var weekDayName = DateFormat('EEEE').format(value).toString();
  print(weekDayName);
  if(weekDayName == "Saturday"){
    weekDayName = "Sabtu";
  } else if(weekDayName == "Sunday"){
    weekDayName = "Minggu";
  } else if(weekDayName == "Monday"){
    weekDayName = "Senin";
  } else if(weekDayName == "Tuesday"){
    weekDayName = "Selasa";
  } else if(weekDayName == "Wednesday"){
    weekDayName = "Rabu";
  } else if(weekDayName == "Thursday"){
    weekDayName = "Kamis";
  } else if(weekDayName == "Friday"){
    weekDayName = "Jumat";
  }
  return weekDayName;
}

checkPlatform() {
  if (Platform.isAndroid) {
    isIos = false;
  } else if (Platform.isIOS) {
    isIos = true;
  }
}
