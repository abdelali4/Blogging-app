
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart';
import 'package:blogging_app/Auth&&FireStore/FireStoreProfile.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
class CreationOfPost extends StatefulWidget {
  @override
  String id;
  CreationOfPost({this.id});
  _CreationOfPostState createState() => _CreationOfPostState(id:id);
}
class _CreationOfPostState extends State<CreationOfPost> {
  File _image;
  String _Title;
  String _Text;
  String _Category;
  String _ImageUrl=null;
  bool picked=false;
  bool waiting=false;
  int i=0;
  @override
  String id;
  final _formkey=GlobalKey<FormState>();
  var Categories=[];
  var categorie=["Gaming","Design"];
  _CreationOfPostState({this.id});
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:Color(0xff2b106a),
          title: Text(
            "Poste",
            style: TextStyle(
              fontSize:22,
              fontWeight:FontWeight.bold,
              color: Color(0xFFFBEAFF),
              fontFamily:"Montserrat",
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight:Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
          ),
        ),
        body:Form(
          key:_formkey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: Column(
              children: [
                SizedBox(height: 30,),
                TextFormField(
                      onChanged: (value){
                        setState(() {
                          _Title=value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      validator: TitleValidator,
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: 16,
                          fontFamily: "Montserratmini"
                      ),
                      decoration:TitleFieldDecoration("Title")
                    ),
                _image!=null? SizedBox(height:20):Container(),
                _image!=null? Stack(
                  alignment: Alignment.bottomRight,
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                          image: DecorationImage(
                              image:FileImage(_image),
                              fit: BoxFit.fitHeight
                          )
                      ),
                    ),
                    Positioned(
                      right: -15,
                      child: GestureDetector(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                        onTap: (){
                          setState(() {
                            picked=false;
                            _image=null;
                          });

                        },
                      ),
                    ),
                  ],
                ):Container(),
                SizedBox(height:20),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("Categories").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData&&i==0){
                      snapshot.data.documents.map(
                          (DocumentSnapshot doc){
                            Categories.add(doc.data["Category"]);
                          }
                      ).toList();
                      if(i==0){
                        i++;
                      }
                    }
                    return DropdownButtonFormField(
                          validator: (value) => value == null ? 'You have to choice a category for you post' : null,
                          icon:  Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color:Colors.greenAccent,
                              size: 30,
                            ),
                          decoration: InputDecoration(
                              errorBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color:Colors.red[800],width: 2)
                              ),
                              errorStyle:TextStyle(
                                  color:Colors.red[800],
                                  fontSize: 14,
                                  fontFamily: "Montserratmini"
                              ),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Colors.grey[500],width: 2)
                            )
                          ),
                          hint: Text(
                              "Category",
                           style:TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[500],
                              fontFamily: "Montserratmini",
                            ),
                          ),
                          style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff2b106a),
                            fontFamily: "Montserratmini",
                          ),
                          items:Categories.map(
                                  (item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child:Text(item)
                                      );
                                  }
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              _Category=value;
                            });
                          },
                          value: _Category,
                        );
                  }
                ),
                SizedBox(height:20),
                TextFormField(
                  onChanged: (value){
                    setState(() {
                      _Text=value;
                    });
                  },
                  maxLines: 20,
                  maxLengthEnforced: true,
                  keyboardType: TextInputType.text,
                  validator: TextValidator,
                  style: TextStyle(
                      color:Colors.black,
                      fontSize: 16,
                      fontFamily: "Montserratmini"
                  ),
                  decoration:TitleFieldDecoration("Text"),
                ),
                SizedBox(height:20),
                StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance.collection("UsersProfiles").document(id)
                    .snapshots(),
                  builder: (context, snapshot) {
                    return Center(
                      child:waiting?Container(
                        height: 70,
                          child: spinkit()):Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                              splashColor: Color(0xff2b106a),
                              color:Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child:Text(
                                "Add image",
                                style:TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Montserrat",
                                    color: Colors.white
                                ),
                              ),
                              onPressed: ()async{
                                await GetImageFromGallery();
                              }
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                              splashColor: Color(0xff2b106a),
                              color:Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child:Text(
                                "Publish",
                                style:TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Montserrat",
                                    color: Colors.white
                                ),
                              ),
                              onPressed: ()async{
                                if(validate()){
                                  setState(() {
                                    waiting=true;
                                  });
                                  if (picked) {
                                    await UploadImage();
                                  }
                                  int a=await snapshot.data["nbrposts"];
                                  Fire(id:id).UploadaPost(_Title, _Category, _Text, id, _ImageUrl,a+1);
                                  _ImageUrl=null;
                                  Navigator.pop(context);
                                  setState(() {
                                    waiting=false;
                                  });
                                }
                              }
                          ),
                        ),
                      ],
                       )
                    );
                  }
                ),
                SizedBox(height:20),
              ],
            ),
          ),
        )
      ),
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
          aspectRatioPresets: [CropAspectRatioPreset.original],
          maxHeight: 720,
          maxWidth: 720,
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
      StorageReference ref =FirebaseStorage.instance.ref().child("ImagesUsedInPosts/$Filename");
      StorageUploadTask task=ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await task.onComplete;
      await ref.getDownloadURL().then((value) =>
          _ImageUrl=value
      );
      picked=false;
    }
    on Exception catch (e) {
      print(e.toString());
    }
  }
  String TitleValidator(String value){
    if(value.isEmpty){
      return "Required";
    }
  }
  String TextValidator(String value){
    if(value.isEmpty){
      return "Required";
    }
  }
  bool validate(){
    if(_formkey.currentState.validate()){
      return true;
    }
    else{
      return false;}
  }
  InputDecoration TitleFieldDecoration(String content){
    return InputDecoration(
        contentPadding: EdgeInsets.only(top: 20,left: 20),
        focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Colors.red[800],width: 2)
        ),
        errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Colors.red[800],width: 2)
        ),
        errorStyle:TextStyle(
            color:Colors.red[800],
            fontSize: 14,
            fontFamily: "Montserratmini"
        ),
       enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color:Colors.grey[400],width: 2)
        ),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xff2b106a),width: 2),
        ),
        hintText: content,
        hintStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
            fontFamily: "Montserratmini",
        ),
    );
  }
  Widget spinkit(){
    return Center(
      child: SpinKitThreeBounce(
        color: Color(0xff2B106A),
        size: 30,
      ),
    );
  }

}
