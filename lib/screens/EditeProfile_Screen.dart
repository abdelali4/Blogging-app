import 'dart:io';
import 'package:blogging_app/Auth&&FireStore/Auth.dart';
import 'package:blogging_app/Auth&&FireStore/FireStoreProfile.dart';
import 'package:blogging_app/OurWidgets&&Functions/Profile&&EditeProfile.dart';
import 'package:blogging_app/screens/LoadingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class EditeProfileScreen extends StatefulWidget {
  String id;
  EditeProfileScreen({this.id});
  @override
  _EditeProfileScreenState createState() => _EditeProfileScreenState(id:id);
}
class _EditeProfileScreenState extends State<EditeProfileScreen> {
  String  id;
  _EditeProfileScreenState({this.id});
  final _formkey=GlobalKey<FormState>();
  String _Name;
  String _Location;
  String _Aboutuser;
  String _Portfolio;
  String _Skills;
  String _Education;
  bool picked=false;
  bool waiting=false;
  final UserData=Firestore.instance.collection("UsersProfiles");
  AuthService _auth=AuthService();
  File _image;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return StreamBuilder<Userdata>(
        stream:Fire(id:id).data,
        builder: (context, snapshot) {
          Userdata user=snapshot.data;
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                backgroundColor:Colors.white,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor:Color(0xff2b106a),
                  title: Text(
                    "Edite Profile",
                    style: TextStyle(
                      fontSize:22,
                      color: Color(0xFFFBEAFF),
                      fontFamily:"Montserrat",
                    ),
                  ),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.add,color: Colors.white,size: 30,),
                        onPressed: (){}
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight:Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                  ),
                ),
                drawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                          color: Colors.deepPurple,
                          child:Padding(
                            padding: EdgeInsets.only(top: 30,bottom: 30,left: 10),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:Colors.white,
                                  backgroundImage:user.UserImageUrl==null?AssetImage("assets/images/userwithoutprofileimage.png"):NetworkImage(user.UserImageUrl),
                                  radius: 40,
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          user.Username,
                                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                          style: TextStyle(
                                              fontSize:20,
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        child: Text(
                                          user.Location,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: "Montserratmini",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )

                      ),
                      Expanded(
                        child: Container(
                          color: Colors.deepPurpleAccent,
                          padding: EdgeInsets.only(top:50),
                          child: ListView(
                            children: [
                              ListTile(
                                leading: IconButton(
                                  icon:Icon(
                                    Icons.edit,
                                    size: 30,
                                    color:Colors.greenAccent,
                                  ),
                                  onPressed: (){
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>EditeProfileScreen(id:id,)));
                                  },
                                ),
                                title: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: IconButton(
                                  icon:Icon(
                                    Icons.logout,
                                    size: 30,
                                    color:Colors.greenAccent,
                                  ),
                                  onPressed: ()async{
                                    await _auth.SignOut();
                                    Navigator.pushReplacementNamed(context, "LogIn");
                                  },
                                ),
                                title: Text(
                                  "Log out",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              )
                            ],
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                body: Form(
                  key:_formkey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:30),
                        Center(
                          child: Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:!picked?(user.UserImageUrl!=null?NetworkImage(user.UserImageUrl):(_image==null?AssetImage("assets/images/userwithoutprofileimage.png"):FileImage(_image))):FileImage(_image),
                                radius: 45,
                              ),
                              Positioned(
                                bottom: -10,
                                right: -10,
                                child: IconButton(
                                    icon: Image.asset("assets/images/camera.png",color: Colors.greenAccent,),
                                    onPressed: (){
                                      GetImageFromGallery();
                                    }
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height:20),
                        TextAboveField("Name"),
                        SizedBox(height: 7,),
                        TextFormField(
                            initialValue: _Name??user.Username,
                            onChanged: (value){
                              setState(() {
                                _Name=value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            validator: NameValidator,
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 16,
                                fontFamily: "Montserratmini"
                            ),
                            decoration:NameFieldDecoration("Name")
                        ),
                        SizedBox(height:20),
                        TextAboveField("Location"),
                        SizedBox(height: 7,),
                        TextFormField(
                            initialValue: _Location??user.Location,
                            onChanged: (value){
                              setState(() {
                                _Location=value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            validator: NameValidator,
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 16,
                                fontFamily: "Montserratmini"
                            ),
                            decoration:NameFieldDecoration("Location")
                        ),
                        SizedBox(height:20),
                        TextAboveField("About"),
                        SizedBox(height: 7,),
                        TextFormField(
                          initialValue: _Aboutuser??user.Aboutuser,
                          onChanged: (value){
                            setState(() {
                              _Aboutuser=value;
                            });
                          },
                          maxLines: 4,
                          maxLengthEnforced: true,
                          keyboardType: TextInputType.text,
                          validator: AboutValidator,
                          style: TextStyle(
                              color:Colors.black,
                              fontSize: 16,
                              fontFamily: "Montserratmini"
                          ),
                          decoration:NameFieldDecoration("About"),
                        ),
                        SizedBox(height: size.height*(0.015),),
                        TextAboveField("Education"),
                        SizedBox(height: 7,),
                        TextFormField(
                          initialValue: _Education??user.Education,
                          onChanged: (value){
                            setState(() {
                              _Education=value;
                            });
                          },
                          keyboardType: TextInputType.text,
                          validator: SkillsValidator,
                          style: TextStyle(
                              color:Colors.black,
                              fontSize: 16,
                              fontFamily: "Montserratmini"
                          ),
                          decoration:NameFieldDecoration("Location"),
                        ),
                        SizedBox(height:20),
                        TextAboveField("Portfolio"),
                        SizedBox(height: 7,),
                        TextFormField(
                            initialValue: _Portfolio??user.Portfolio,
                            onChanged: (value){
                              setState(() {
                                _Portfolio=value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            validator: PortfolioValidator,
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 16,
                                fontFamily: "Montserratmini"
                            ),
                            decoration:NameFieldDecoration("Portfolio")
                        ),
                        SizedBox(height:20),
                        TextAboveField("Skills"),
                        SizedBox(height: 7,),
                        TextFormField(
                            initialValue: _Skills??user.Skills,
                            onChanged: (value){
                              setState(() {
                                _Skills=value;
                              });
                            },
                            maxLines: 2,
                            maxLengthEnforced: true,
                            keyboardType: TextInputType.text,
                            validator: SkillsValidator,
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 16,
                                fontFamily: "Montserratmini"
                            ),
                            decoration:NameFieldDecoration("Skills")
                        ),
                        SizedBox(height:20,),
                        Center(
                            child: waiting?spinkit():RaisedButton(
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                splashColor: Color(0xff2b106a),
                                color:Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child:Text(
                                  "Confirm",
                                  style:TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Montserrat",
                                      color: Colors.white
                                  ),
                                ),
                                onPressed: ()async{
                                  if(_formkey.currentState.validate()){
                                    setState(() {
                                      waiting=true;
                                    });
                                    await Fire(id:id).Updatedata(id, {
                                      "Location":_Location??user.Location,
                                      "Aboutuser":_Aboutuser??user.Aboutuser,
                                      "Portfolio":_Portfolio??user.Portfolio,
                                      "Skills":_Skills??user.Skills,
                                      "Username":_Name??user.Username,
                                      "Education":_Education??user.Education,
                                    });
                                    if (picked) {
                                      UploadImage();
                                    }
                                    Navigator.pop(context);
                                    setState(() {
                                      waiting=false;
                                    });
                                  }
                                }
                            ),
                        ),
                        SizedBox(height:20,)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          else{
            return LoadingScreen();
          }
        }
    );
  }
  Future GetImageFromGallery()async{
    File image=await ImagePicker.pickImage(source: ImageSource.gallery);
    File cropped;
    if (image!=null) {
      cropped= await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1 ),
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              lockAspectRatio: false,
              toolbarColor: Color(0xff2b106a),
              toolbarWidgetColor: Colors.white,
              statusBarColor: Colors.black,
              backgroundColor: Colors.black
          ),
          iosUiSettings: IOSUiSettings(
            rotateButtonsHidden: false,
            rotateClockwiseButtonHidden: false,
          )
      );
      if(cropped!=null){
        setState(() {
          _image=cropped;
          if (image!=null) {
            picked=true;
          }
        });
      }
    }
  }
  Future UploadImage()async{
    try {
      FirebaseStorage storage=FirebaseStorage(storageBucket: "gs://blogging-app-80378.appspot.com");
      String Filename=basename(_image.path);
      StorageReference ref =FirebaseStorage.instance.ref().child("UsersProfilesImage/$Filename");
      StorageUploadTask task=ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await task.onComplete;
      await ref.getDownloadURL().then((value) =>
          Fire(id:id).Updatedata(id,
              {"UserImageUrl":value})
      );
      picked=false;
    }
    on Exception catch (e) {
      print(e.toString());
    }
  }

}