import 'package:blogging_app/Auth&&FireStore/Auth.dart';
import 'package:blogging_app/OurWidgets&&Functions/SignUp.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  AuthService _auth=AuthService();
  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  final _EmailController=TextEditingController();
  final _NameController=TextEditingController();
  final _PasswordController=TextEditingController();
  bool  isVisibile = false;
  bool Waiting=false;
  bool EmailUsed=false;
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xffFBEAFF),
        body:  Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child:Form(
                key: globalKey,
                child: Container(
                  width: widthScreen * (0.8),
                  //height: heightScreen * (1.5),
                  margin: EdgeInsets.symmetric(horizontal:30,),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      overflow: Overflow.visible,
                      children: [
                        Column(
                          children: [
                            Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Color(0xff2B106A),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              showCursor: true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff2B106A),
                                          width: 2
                                      )
                                  ),
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.red
                                    )
                                ),
                                focusedErrorBorder:UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.red
                                    )
                                ),
                                errorStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserratmini"
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xff4c4c4c),
                                  size: 40,
                                ),
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                  color: Color(0xffc7c1cc),
                                  fontSize: 20,
                                ),
                              ),
                              controller: _NameController,
                              validator: NameValidator
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              showCursor: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff2B106A),
                                        width: 2
                                    )
                                ),
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.red
                                    )
                                ),
                                focusedErrorBorder:UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.red
                                    )
                                ),
                                errorStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserratmini"
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xff4c4c4c),
                                  size: 25,
                                ),
                                labelText: 'Email Address',
                                labelStyle: TextStyle(
                                  color: Color(0xffc7c1cc),
                                  fontSize: 20,
                                ),
                              ),
                              controller: _EmailController,
                              validator:EmailValidatorAll,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: !isVisibile,
                              showCursor: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff2B106A),
                                        width: 2
                                    )
                                ),
                                errorStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserratmini"
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.red
                                  )
                                ),
                                focusedErrorBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red
                                  )
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xff4c4c4c),
                                  size: 25,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    !isVisibile?Icons.visibility_off:Icons.visibility,
                                    color: Color(0xff4c4c4c),
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isVisibile = !isVisibile;
                                    });
                                  },
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Color(0xffc7c1cc),
                                  fontSize: 20,
                                ),
                              ),
                              controller: _PasswordController,
                              validator: PasswordValidator
                            ),
                            SizedBox(
                              height:70,
                            ),
                            Center(
                              child:FlatButton(
                                color: Color(0xff2B106A),
                                minWidth: widthScreen*(0.8),
                                height: 50,
                                onPressed: ()async{
                                 if(validateAndSave()){
                                 setState(() {
                                   Waiting=true;
                                 });
                                 dynamic user=await _auth.RegisterWithEmailAndPassword(_EmailController.text.trim(), _PasswordController.text,_NameController.text);
                                 if(user!=null){
                                   Navigator.pop(context);
                                 }
                                 setState(() {
                                   Waiting=false;
                                 });
                                 if(user==null){
                                   setState(() {
                                     EmailUsed=true;
                                   });
                                   validateAndSave();
                                 }
                                 EmailUsed=false;
                                 }
                                },
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80),
                                    side: BorderSide(color: Color(0xff2B106A))
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:50.0),
                              child: Text(
                                'Already have an account ?',
                                style: TextStyle(
                                  color: Color(0xff4B4553),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            FlatButton(
                              color: Color(0xffFBEAFF),
                              minWidth: widthScreen*(0.8),
                              height: 50,
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                'LOG IN',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff2B106A),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                  side: BorderSide(
                                    color: Color(0xff2B106A),
                                  )
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Waiting?spinkit():null,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String EmailValidatorAll(String value){
    if(value.isEmpty)
    {
      return 'Please enter your email';
    }
    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
      return 'Please enter a valid Email';
    }
    if(EmailUsed){
      return "This Email is already used !";
    }
    return null;
  }
  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}


