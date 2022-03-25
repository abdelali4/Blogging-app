import 'package:blogging_app/Auth&&FireStore/Auth.dart';
import 'package:blogging_app/Auth&&FireStore/FireStoreProfile.dart';
import 'package:blogging_app/screens/AccueilPage.dart';
import 'package:blogging_app/screens/CategoriesPage.dart';
import 'package:blogging_app/screens/CreationOfPost.dart';
import 'package:blogging_app/screens/EditeProfile_Screen.dart';
import 'package:blogging_app/screens/LoadingScreen.dart';
import 'package:blogging_app/screens/Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
class HomePage extends StatefulWidget {
  String id;
  HomePage({this.id});
  @override
  State<StatefulWidget> createState() {
    return _HomePage(id:id);
  }
}
class _HomePage extends State<HomePage> {
  String id;
  _HomePage({this.id});
  int index;
  AuthService _auth= AuthService();
  var array=["Home","Categories","Search","Profile"];
  final _Pages=<Widget>[
    Icon(Icons.home,size: 40),
    Icon(Icons.menu,size: 40),
    Icon(Icons.person,size: 40,)
  ];
  @override
  Widget build(BuildContext context) {
    var index;
    var size=MediaQuery.of(context).size;
    return StreamBuilder<Userdata>(
        stream:Fire(id:id).data,
        builder: (context,snapshot) {
          var user=snapshot.data;
          if (snapshot.hasData) {
            return DefaultTabController(
                length: 3,
                child: Scaffold(
                    backgroundColor:Colors.white,
                    appBar:AppBar(
                      centerTitle: true,
                      backgroundColor:Color(0xff2b106a),
                      title: Text(
                        "Home",
                        style: TextStyle(
                          fontSize:22,
                          color: Color(0xFFFBEAFF),
                          fontFamily:"Montserrat",
                        ),
                      ),
                      actions: [
                        IconButton(
                            icon: Icon(Icons.add,color: Colors.white,size: 30,),
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>CreationOfPost(id:id)));
                            }
                        )],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight:Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )
                      ),
                    ),
                    bottomNavigationBar:Container(
                      decoration: BoxDecoration(
                           color: Color(0xff2b106a),
                           borderRadius: BorderRadius.only(
                            topRight:Radius.circular(20),
                            topLeft: Radius.circular(20),
                          )
                      ),
                      padding: EdgeInsets.only(top: 10),
                      child: TabBar(
                        onTap: (value){
                          setState(() {
                            index=value;
                          });
                        },
                        labelColor: Colors.greenAccent,
                        unselectedLabelColor: Colors.white,
                        indicatorWeight: 3,
                        indicatorColor:Colors.greenAccent,
                        tabs:_Pages,
                      ),
                    ),
                    drawer: Drawer(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Color(0xff2b106a),
                                border: Border(
                                  bottom:BorderSide(
                                    color:Colors.greenAccent,
                                    width:2,
                                  ),
                                ),
                              ),
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
                                                  fontSize:18,
                                                  color: Colors.white,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 7,),
                                          Container(
                                            child: Text(
                                              user.Location,
                                              style: TextStyle(
                                                fontSize: 14,
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
                              color: Color(0xff2b106a),
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
                                        Navigator.push(context, MaterialPageRoute(builder:(context)=>EditeProfileScreen(id:id,)));
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
                                        WriteLoginStatue(false);
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
                          )
                        ],
                      ),
                    ),
                    body:TabBarView(
                      children:[
                        AcceuilPage(id: id,),
                        CategoriesPage(id:id),
                        ProfileScreen(id:id),
                      ],
                    )
                )
            );
          }
          else{
            return LoadingScreen();
          }
        }
    );

  }


}

