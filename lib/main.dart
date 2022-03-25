
import 'package:blogging_app/Auth&&FireStore/Auth.dart';
import 'package:blogging_app/screens/CreationOfPost.dart';
import 'package:blogging_app/screens/OneCategoryPage.dart';
import 'package:blogging_app/screens/PostPage.dart';
import 'package:blogging_app/screens/ProfilePageSeenBySomeOne.dart';
import 'package:blogging_app/screens/Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:blogging_app/screens/LogIn_Screen.dart';
import 'package:blogging_app/screens/OnBoradingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
int initScreen;
var UserStatue;
Future<void> main() async{
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen',1);*/
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'BloggingApp',
        initialRoute: initScreen != 0 ? 'onboard' : 'LogIn',
        routes: {
          'LogIn': (context) => LoginScreen(),
          'onboard': (context) => OnBoarding(),
          'Profile':(context)=>ProfileScreen(),
          'CreationOfPost':(context)=>CreationOfPost(),
          'PostPage':(context)=>PostPage(),
          'OneCategoryPage':(context)=>OneCategoryPage(),
          'ProfileBySomeone':(context)=>ProfilePageSeenBySomeOne(),
         /*'homeScreen' : (context)=> HomePage(),*/
        },
      );
    }
  }
