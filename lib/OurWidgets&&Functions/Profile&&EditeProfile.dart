import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
Widget Simplecolumn(String nbr, String content){
  return Column(
    children: [
      Text(
        nbr,
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Montserrat",
            fontSize: 20
        ),
      ),
      SizedBox(height: 7,),
      Text(
        content,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Montserratmini",
          fontSize: 18,
        ),
      ),
    ],
  );
}
Widget katba(String title,String content){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontFamily: "Montserrat",
            color: Colors.black
        ),
      ),
      SizedBox(height: 5,),
      Text(
        content,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 16,
            fontFamily: "Montserratmini"
        ),
      )
    ],
  );
}
Widget katbaWithIcon(String title,String content,Widget icon){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontFamily: "Montserrat",
            color: Colors.black
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(width: 5,),
          Expanded(
            child: Container(
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserratmini"
                ),
              ),
            ),
          ),

        ],
      ),
    ],
  );
}
Widget katbaWithIconPortfolio(String title,String content,Widget icon){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontFamily: "Montserrat",
            color: Colors.black
        ),
      ),
      SizedBox(height: 5,),
      Row(
        children: [
          icon,
          SizedBox(width: 5,),
          Expanded(
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                  decoration:TextDecoration.underline,
                  fontSize: 16,
                  color: Colors.greenAccent,
                  fontFamily: "Montserratmini"
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
Widget katbaWithIconEducation(String title,String content,Widget icon) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontFamily: "Montserrat",
            color: Colors.black
        ),
      ),
      SizedBox(height: 5,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(width:15,),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: "Montserratmini"
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
Widget PortfolioIcon(){
  return IconButton(
      icon: Image.asset("assets/images/lien.png",color:Colors.greenAccent,),
      onPressed: null);
}
Widget EducationIcon(){
  return  Icon(Icons.school_outlined,color: Colors.greenAccent,size: 35,);
}
Widget aboutfield(String content,Function Validator,TextEditingController Controller,String initial){
  Controller.text=initial;
  return TextFormField(
      initialValue: initial,
      maxLines:6,
      maxLength: 80,
      maxLengthEnforced: true,
      keyboardType: TextInputType.text,
      validator: Validator,
      style: TextStyle(
          color:Colors.black,
          fontSize: 16,
          fontFamily: "Montserratmini"
      ),
      decoration:AboutFieldDecoration()

  );
}
Widget Skillsfield(String content,Function Validator,TextEditingController Controller,String initial){
  Controller.text=initial;
  return TextFormField(
    maxLines: 2,
    maxLengthEnforced: true,
    keyboardType: TextInputType.text,
    validator: Validator,
    controller: Controller,
    style: TextStyle(
        color:Colors.black,
        fontSize: 16,
        fontFamily: "Montserratmini"
    ),
    decoration:InputDecoration(

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
            borderSide: BorderSide(color:Color(0xffFBEAFF))
        ),
        contentPadding: EdgeInsets.only(left: 15,top: 10,bottom: 10),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: content,
        hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: "Montserratmini"
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff2b106a),width: 2),
        )
    ),

  );
}
Widget TextAboveField(String content){
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Text(
      content,
      style: TextStyle(
          fontSize: 18,
          fontFamily: "Montserrat",
          color: Colors.black
      ),
    ),
  );
}
InputDecoration NameFieldDecoration(String content){
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
          borderSide: BorderSide(color:Color(0xffFBEAFF))
      ),
      filled: true,
      fillColor: Colors.grey[200],
      hintText: content,
      hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: "Montserratmini"
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xff2b106a),width: 2),
      )
  );
}
InputDecoration AboutFieldDecoration(){
  return InputDecoration(
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
          borderSide: BorderSide(color:Color(0xffFBEAFF))
      ),
      contentPadding: EdgeInsets.only(left: 15,top: 10,bottom: 10),
      filled: true,
      fillColor: Colors.grey[200],
      hintText: 'About',
      hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: "Montserratmini"
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xff2b106a),width: 2),
      )
  );
}
String NameValidator(String value){
  if(value.isEmpty){
    return "Required";
  }
  if(value.length>30){
    return " should not be greater than 30 digits";
  }
}
String LocationValidator(String value){
  if(value.length>60){
    return " should not be greater than 60 digits";
  }
}
String AboutValidator(String value){
  if(value.length>200){
    return " should not be greater than 200 digits";
  }
}
String PortfolioValidator(String value){
  if(value.length>100){
    return " should not be greater than 100 digits";
  }
}
String SkillsValidator(String value){
  if(value.length>100){
    return " should not be greater than 100 digits";
  }
}
Widget spinkit(){
  return Center(
    child: SpinKitThreeBounce(
      color: Color(0xff2B106A),
      size: 30,
    ),
  );
}