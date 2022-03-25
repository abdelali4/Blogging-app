import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class  PostPage extends StatelessWidget {
  String postid;
  PostPage({this.postid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor:Color(0xff2b106a),
        title: Text(
          "Post",
          style: TextStyle(
            fontSize:22,
            color: Colors.white,
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
      body:StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection("Posts").document(postid).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return SingleChildScrollView(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(
                        "Category : ",
                        style: TextStyle(
                          fontSize:18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily:"Montserrat",
                        ),
                      ),
                     Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            snapshot.data["Category"],
                            style: TextStyle(
                              fontSize:18,
                              color: Color(0xff2b106a),
                              fontWeight: FontWeight.bold,
                              fontFamily:"Montserrat",
                            ),
                            overflow: TextOverflow.clip,
                          ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    child:Text(
                      snapshot.data["Title"],
                      style: TextStyle(
                        fontSize:20,
                        color: Color(0xff2b106a),
                        fontWeight: FontWeight.bold,
                        fontFamily:"Montserrat",
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  snapshot.data["ImageUrl"]!=null?Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data["ImageUrl"]),
                          fit:BoxFit.fitHeight,
                        )
                    ),
                  ):Text(""),
                  SizedBox(height: 10,),
                  Container(
                      width: double.infinity,
                      child: Text(
                        snapshot.data["Text"]+".",
                        style: TextStyle(
                            fontSize:17,
                            color: Colors.black,
                            fontFamily: "Montserratmini",
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                ],
              ),

            );
          }
          else{
            return Column(
              children: [
                SizedBox(height: 30,),
                Text(
                 "Erreur 404",
                 style:TextStyle(
                    fontSize:22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily:"Montserrat",
                  ),
                )
              ],
            );
          }
        }
      )
    );
  }
}
