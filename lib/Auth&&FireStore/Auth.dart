import 'package:blogging_app/Auth&&FireStore/FireStoreProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Userid{
  String id;
  Userid({this.id});
}
class AuthService{
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future RegisterWithEmailAndPassword(String Email, String Password,String Username)async{
    try {
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: Email, password: Password);
      Fire userdata=Fire(id:result.user.uid);
      await userdata.SetUserData(Username,0,0,0,"Marrakech, Morroco","Aboutuser","Education","www.crisisflutter.com/crisis","Skills",null);
      return result.user;
    }catch (e){
      print(e.toString());
      return null;
    }
  }
  Future SignOut()async{
    try {
      await _auth.signOut();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
  Future<String> currentuserid()async{
    FirebaseUser user;
    try {
      user=await FirebaseAuth.instance.currentUser();
      return user.uid;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future LoginWithEmailAndPassword(String Email,String Password)async{
    try {
      AuthResult result=await _auth.signInWithEmailAndPassword(email: Email,password:Password);
      return result.user;
    }
    on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future UserFromDatabase(FirebaseUser user)async{
    try {
      return await Userid(id:user.uid);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
WriteLoginStatue(bool Statue)async{
  final prefers=await SharedPreferences.getInstance();
  final key="Statue";
  prefers.setBool(key,Statue);
}
ReadLoginStatue()async{
  final prefers=await SharedPreferences.getInstance();
  final key="Statue";
  final value=prefers.getBool(key) ?? false;
  return value;
}
