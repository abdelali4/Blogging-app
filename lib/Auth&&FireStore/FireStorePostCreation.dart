import 'package:shared_preferences/shared_preferences.dart';

WriteStatue(bool Statue)async{
  final prefers=await SharedPreferences.getInstance();
  final key="initstate";
  prefers.setBool(key,Statue);
}
ReadStatue()async{
  final prefers=await SharedPreferences.getInstance();
  final key="initstate";
  final value=prefers.getBool(key) ?? false;
  return value;
}