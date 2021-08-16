
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/modules/shop_app/login/login_screen.dart';
import 'package:flutter_application_1/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_application_1/shared/component/components.dart';
import 'package:flutter_application_1/shared/network/local/cash_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value) {
    if(value)
    {
      navigateToAndBurn(context, OnBoardingScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}