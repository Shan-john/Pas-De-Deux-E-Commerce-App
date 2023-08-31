import 'package:flutter/material.dart';

class Routes {
  // teh instace of class to call the below function

  static Routes instance = Routes();
  // function for  pushandRemoveUntil the screen
  Future<dynamic> pushandRemoveUntil(
      {required widget, required BuildContext context}) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (cxt) => widget), (route) => false);
  }
 // function for  push the screen
  Future<dynamic> push({required widget, required BuildContext context}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (cxt) => widget),
    );
  }
 // function for  pushreplace  the screen
  Future<dynamic> pushreplace(
      {required widget, required BuildContext context}) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (cxt) => widget),
    );
  }
// function for pop the screen
  void  pop(context) {
     Navigator.of(context).pop();
  }
}
