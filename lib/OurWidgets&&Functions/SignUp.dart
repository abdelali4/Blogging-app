import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
String EmailValidator(String value){
    if(value.isEmpty)
    {
      return 'Please enter your email';
    }
    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
      return 'Please enter a valid Email';
    }
    return null;
}
String PasswordValidator(String value){
  if (value.toString().isEmpty) {
    return "please enter your Password";
  }
  if (value.length < 6) {
    return "Password < 6";
  }
  return null;
}
String NameValidator(String value){
  if (value.isEmpty) {
    return 'Please enter your full name';
  }
   return null;
}
Widget spinkit(){
  return Center(
    child: SpinKitThreeBounce(
      color: Color(0xff2B106A),
      size: 50,
    ),
  );
}