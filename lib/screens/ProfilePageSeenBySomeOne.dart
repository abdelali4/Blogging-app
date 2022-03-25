
import 'package:blogging_app/Auth&&FireStore/Auth.dart';
import 'package:blogging_app/Auth&&FireStore/FireStoreProfile.dart';
import 'package:blogging_app/OurWidgets&&Functions/Profile&&EditeProfile.dart';
import 'package:blogging_app/screens/CreationOfPost.dart';
import 'package:blogging_app/screens/LoadingScreen.dart';
import 'package:blogging_app/screens/PostPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
class ProfilePageSeenBySomeOne extends StatefulWidget {
  String id;
  String pageid;
  ProfilePageSeenBySomeOne ({this.id,this.pageid});
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageSeenBySomeOne (id:id,pageid:pageid);
  }
}
class _ProfilePageSeenBySomeOne  extends State<ProfilePageSeenBySomeOne > {
  String id;
  String pageid;
  int j=0;
  TextEditingController comment=TextEditingController();
  _ProfilePageSeenBySomeOne ({this.id,this.pageid});
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
      body: StreamBuilder<DocumentSnapshot>(
          stream:Firestore.instance.collection("UsersProfiles")
          .document(pageid).snapshots(),
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child:Column(
                  children: [
                    SizedBox(height:30),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor:Colors.white,
                            backgroundImage:snapshot.data["UserImageUrl"]==null?AssetImage("assets/images/userwithoutprofileimage.png"):NetworkImage(snapshot.data["UserImageUrl"]),
                            radius: 40,
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    snapshot.data["Username"],
                                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                    style: TextStyle(
                                        fontSize:20,
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  child: Text(
                                    snapshot.data["Location"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: "Montserratmini",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 30,left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Simplecolumn(snapshot.data["nbrposts"].toString(),"Postes"),
                              Simplecolumn(snapshot.data["nbrfollowers"].toString(),"Followers"),
                              Simplecolumn(snapshot.data["nbrfollowing"].toString(),"Fllowing"),
                            ],
                          ),
                          SizedBox(height:20,),
                          katba("About",snapshot.data["Aboutuser"]),
                          SizedBox(height:20,),
                          katbaWithIconEducation("Education",snapshot.data["Education"],EducationIcon()),
                          SizedBox(height:20,),
                          katbaWithIconPortfolio("Portfolio",snapshot.data["Portfolio"],PortfolioIcon()),
                          SizedBox(height:20,),
                          katba("Skills",snapshot.data["Skills"]),
                        ],
                      ),
                    ),
                    snapshot.data["nbrposts"]!=0?Container(
                      height: 10,
                      width:double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border:null
                      ),
                    ):Container(),
                    StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection("Posts").where("Owner",isEqualTo:pageid).snapshots(),
                        builder: (context,bro){
                          if(bro.hasData){
                            return   Padding(
                              padding: EdgeInsets.only(top:20),
                              child: Column(
                                  children:[
                                    Column(
                                        children:bro.data.documents.map(
                                                (DocumentSnapshot doc){
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:30,right: 30,top: 0),
                                                    child: Column(
                                                      children: [
                                                        StreamBuilder<DocumentSnapshot>(
                                                            stream: Firestore.instance.collection("UsersProfiles").document(doc.data["Owner"]).snapshots(),
                                                            builder: (context,snapshot) {
                                                              return Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:snapshot.hasData?(snapshot.data["UserImageUrl"]!=null?
                                                                    NetworkImage(snapshot.data["UserImageUrl"]):AssetImage("assets/images/userwithoutprofileimage.png")):
                                                                    AssetImage("assets/images/userwithoutprofileimage.png"),
                                                                    backgroundColor: Colors.white,
                                                                    radius: 25,
                                                                  ),
                                                                  SizedBox(width: 15,),
                                                                  Expanded(
                                                                    child: Container(
                                                                      padding: EdgeInsets.only(top: 10),
                                                                      child: Text(
                                                                        snapshot.hasData?snapshot.data['Username']:" ",
                                                                        style: TextStyle(
                                                                            fontSize:17,
                                                                            color: Colors.black,
                                                                            fontFamily: "Montserrat",
                                                                            fontWeight: FontWeight.w800
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Container(
                                                          width: double.infinity,
                                                          child:Text(
                                                            doc.data["Title"],
                                                            style: TextStyle(
                                                                fontSize:17,
                                                                color: Colors.black,
                                                                fontFamily: "Montserratmini",
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        doc.data["ImageUrl"]!=null?
                                                        Container(
                                                          width: double.infinity,
                                                          height: 300,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                              color: Colors.grey[300],
                                                              image: DecorationImage(
                                                                  image: NetworkImage(doc.data["ImageUrl"]),
                                                                  fit: BoxFit.fitHeight
                                                              )
                                                          ),
                                                        ):Container(),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                StreamBuilder<DocumentSnapshot>(
                                                                    stream: Firestore.instance.collection("UsersProfiles").document(id).snapshots(),
                                                                    builder: (context, snapshot) {
                                                                      if (snapshot.hasData) {
                                                                        return
                                                                          IconButton(
                                                                              icon: Icon(
                                                                                Icons.favorite,
                                                                                size: 30,
                                                                                color: List.from(snapshot.data["LickedPosts"]).contains(doc.documentID)?
                                                                                Colors.red:Colors.grey,
                                                                              ),
                                                                              onPressed: () async {
                                                                                if (List.from(snapshot
                                                                                    .data["LickedPosts"])
                                                                                    .contains(
                                                                                    doc.documentID)) {
                                                                                  Firestore.instance
                                                                                      .collection(
                                                                                      "UsersProfiles")
                                                                                      .document(id)
                                                                                      .
                                                                                  updateData(
                                                                                      {
                                                                                        "LickedPosts": FieldValue
                                                                                            .arrayRemove(
                                                                                            [
                                                                                              doc
                                                                                                  .documentID
                                                                                            ])
                                                                                      }
                                                                                  );
                                                                                  Firestore.instance.collection("Posts").document(doc.documentID)
                                                                                      .updateData(
                                                                                      { "nbrlikes":FieldValue.increment(-1)
                                                                                      }
                                                                                  );
                                                                                }
                                                                                else {
                                                                                  Firestore.instance
                                                                                      .collection(
                                                                                      "UsersProfiles")
                                                                                      .document(id)
                                                                                      .
                                                                                  updateData(
                                                                                      {
                                                                                        "LickedPosts": FieldValue
                                                                                            .arrayUnion([
                                                                                          doc.documentID
                                                                                        ])
                                                                                      }
                                                                                  );
                                                                                  Firestore.instance.collection("Posts").document(doc.documentID)
                                                                                      .updateData(
                                                                                      {
                                                                                        "nbrlikes":FieldValue.increment(1)
                                                                                      }
                                                                                  );
                                                                                }
                                                                              }
                                                                          );
                                                                      }
                                                                      else{
                                                                        return Icon(
                                                                          Icons.favorite,
                                                                          size: 30,
                                                                          color: Colors.grey,
                                                                        );
                                                                      }
                                                                    }
                                                                ),
                                                                Text(
                                                                  doc.data["nbrlikes"].toString(),
                                                                  style: TextStyle(
                                                                      fontSize:15,
                                                                      color: Colors.black,
                                                                      fontFamily: "Montserratmini",
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                                SizedBox(width: 5,),
                                                                IconButton(
                                                                    icon: Icon(
                                                                      Icons.comment,
                                                                      size: 30,
                                                                      color: doc.data["nbrcomments"]!=0?Color(0xff2b106a):Colors.grey,
                                                                    ),
                                                                    onPressed: ()=>{
                                                                      showModalBottomSheet(context: context,
                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                                                            topLeft: Radius.circular(20),
                                                                            topRight:Radius.circular(20),
                                                                          )),
                                                                          builder: (context){
                                                                            return  GestureDetector(
                                                                              onTap: (){
                                                                                FocusScope.of(context).requestFocus(FocusNode());
                                                                              },
                                                                              child: StreamBuilder<QuerySnapshot>(
                                                                                  stream:  Firestore.instance.collection("Posts").document(doc.documentID)
                                                                                      .collection("Comments").snapshots(),
                                                                                  builder: (context, snapshot) {
                                                                                    return Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          height: 15,
                                                                                          width: 700,
                                                                                          decoration: BoxDecoration(
                                                                                              color:Color(0xff2b106a),
                                                                                              borderRadius: BorderRadius.only(
                                                                                                topRight:Radius.circular(20),
                                                                                                topLeft: Radius.circular(20),
                                                                                              )
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(height: 20,),
                                                                                        Expanded(
                                                                                            child:
                                                                                            StreamBuilder<DocumentSnapshot>(
                                                                                                stream: Firestore.instance.collection("Posts")
                                                                                                    .document(doc.documentID).snapshots(),
                                                                                                builder: (context, bim) {
                                                                                                  if(bim.hasData){
                                                                                                    return Container(
                                                                                                      color:Colors.white,
                                                                                                      child: bim.data["nbrcomments"]!=0? (
                                                                                                          snapshot.hasData?
                                                                                                          ListView(
                                                                                                            children:snapshot.data.documents.map(
                                                                                                                    (DocumentSnapshot snap){
                                                                                                                  return Column(
                                                                                                                    children: [
                                                                                                                      StreamBuilder<DocumentSnapshot>(
                                                                                                                          stream: Firestore.instance.collection("UsersProfiles").
                                                                                                                          document(snap.data["Owner"]).snapshots(),
                                                                                                                          builder: (context, bro) {
                                                                                                                            if(bro.hasData){
                                                                                                                              return Row(
                                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                children: [
                                                                                                                                  SizedBox(width: 5,),
                                                                                                                                  CircleAvatar(
                                                                                                                                    backgroundImage: bro.hasData?
                                                                                                                                    bro.data["UserImageUrl"]!=null?
                                                                                                                                    NetworkImage(bro.data["UserImageUrl"]):
                                                                                                                                    AssetImage("assets/images/userwithoutprofileimage.png"):
                                                                                                                                    AssetImage("assets/images/userwithoutprofileimage.png"),
                                                                                                                                    backgroundColor: Colors.white,
                                                                                                                                    radius: 20,
                                                                                                                                  ),
                                                                                                                                  SizedBox(width: 5,),
                                                                                                                                  Expanded(
                                                                                                                                    child: Container(
                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                        color: Colors.grey[200],
                                                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                                                      ),
                                                                                                                                      child:Padding(
                                                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                                                        child: Column(
                                                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                          children: [
                                                                                                                                            Container(
                                                                                                                                              child:
                                                                                                                                              Text(
                                                                                                                                                bro.data["Username"],
                                                                                                                                                style: TextStyle(
                                                                                                                                                  fontSize: 16,
                                                                                                                                                  color: Colors.black,
                                                                                                                                                  fontFamily: "Montserratmini",
                                                                                                                                                  fontWeight: FontWeight.bold,
                                                                                                                                                ),
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                                                                            SizedBox(height: 5,),
                                                                                                                                            Container(
                                                                                                                                                child:
                                                                                                                                                Text(
                                                                                                                                                  snap.data["Content"]
                                                                                                                                                  ,
                                                                                                                                                  style: TextStyle(
                                                                                                                                                      fontSize: 16,
                                                                                                                                                      color: Colors.black,
                                                                                                                                                      fontFamily: "Montserratmini"
                                                                                                                                                  ),)
                                                                                                                                            ),
                                                                                                                                          ],
                                                                                                                                        ),
                                                                                                                                      ) ,
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  SizedBox(width: 5,),
                                                                                                                                ],
                                                                                                                              );}
                                                                                                                            else{
                                                                                                                              return Text("");
                                                                                                                            }
                                                                                                                          }
                                                                                                                      ),
                                                                                                                      SizedBox(height: 15,),
                                                                                                                    ],
                                                                                                                  );
                                                                                                                }
                                                                                                            ).toList(),
                                                                                                          ):Text("")
                                                                                                      ):
                                                                                                      SingleChildScrollView(
                                                                                                        child: Column(
                                                                                                          children: [
                                                                                                            Image.asset("assets/images/comments.jpg"),
                                                                                                            SizedBox(height: 10,),
                                                                                                            Text(
                                                                                                              "No Comments Yet",
                                                                                                              style: TextStyle(
                                                                                                                  fontSize: 20,
                                                                                                                  color: Colors.grey
                                                                                                              ),
                                                                                                            ),
                                                                                                            Text(
                                                                                                              "Be the first to comment",
                                                                                                              style: TextStyle(
                                                                                                                  fontSize: 15,
                                                                                                                  color: Colors.grey
                                                                                                              ),
                                                                                                            ),
                                                                                                            SizedBox(height: 20,)
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  }
                                                                                                  else{
                                                                                                    return Container();
                                                                                                  }
                                                                                                }
                                                                                            )
                                                                                        ),
                                                                                        Padding(
                                                                                            padding: EdgeInsets.only(
                                                                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SizedBox(width: 5,),
                                                                                                StreamBuilder<DocumentSnapshot>(
                                                                                                    stream:Firestore.instance.collection("UsersProfiles").
                                                                                                    document(id).snapshots(),
                                                                                                    builder: (context,boom) {
                                                                                                      if(boom.hasData){
                                                                                                        return CircleAvatar(
                                                                                                          backgroundColor:Colors.white,
                                                                                                          backgroundImage:boom.hasData?
                                                                                                          boom.data["UserImageUrl"]!=null?
                                                                                                          NetworkImage(boom.data["UserImageUrl"]):
                                                                                                          AssetImage("assets/images/userwithoutprofileimage.png"):
                                                                                                          AssetImage("assets/images/userwithoutprofileimage.png"),
                                                                                                          radius: 20,
                                                                                                        );
                                                                                                      }
                                                                                                      else {
                                                                                                        return  CircleAvatar(
                                                                                                          backgroundColor:Colors.white,
                                                                                                          radius: 20,
                                                                                                        );
                                                                                                      }
                                                                                                    }
                                                                                                ),
                                                                                                SizedBox(width: 5,),
                                                                                                Expanded(
                                                                                                  child: TextFormField(
                                                                                                      controller: comment,
                                                                                                      keyboardType: TextInputType.text,
                                                                                                      style: TextStyle(
                                                                                                          color:Colors.black,
                                                                                                          fontSize: 16,
                                                                                                          fontFamily: "Montserratmini"
                                                                                                      ),
                                                                                                      decoration:InputDecoration(
                                                                                                          suffixIcon: IconButton(
                                                                                                            icon:Icon(
                                                                                                                Icons.send_rounded
                                                                                                            ),
                                                                                                            onPressed: ()async{
                                                                                                              if(!comment.text.isEmpty){
                                                                                                                await Firestore.instance.collection("Posts").document(doc.documentID).
                                                                                                                collection("Comments").document().setData(
                                                                                                                    {
                                                                                                                      "Owner":id,
                                                                                                                      "Content":comment.text
                                                                                                                    }
                                                                                                                );
                                                                                                                comment.clear();
                                                                                                                await Firestore.instance.collection("Posts")
                                                                                                                    .document(doc.documentID).updateData(
                                                                                                                    {
                                                                                                                      "nbrcomments":FieldValue.increment(1)
                                                                                                                    }
                                                                                                                );
                                                                                                                setState(() {
                                                                                                                  j=1;
                                                                                                                });
                                                                                                              }
                                                                                                            },
                                                                                                          ),
                                                                                                          contentPadding: EdgeInsets.only(top: 20,left: 20),
                                                                                                          enabledBorder: OutlineInputBorder(
                                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                                              borderSide: BorderSide(color:Color(0xffFBEAFF))
                                                                                                          ),
                                                                                                          filled: true,
                                                                                                          fillColor: Colors.grey[200],
                                                                                                          hintText: "Write a comment...",
                                                                                                          hintStyle: TextStyle(
                                                                                                              fontSize: 16,
                                                                                                              color: Colors.black,
                                                                                                              fontFamily: "Montserratmini"
                                                                                                          ),
                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                            borderSide: BorderSide(color: Color(0xff2b106a),width: 2),
                                                                                                          )
                                                                                                      )
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(width: 5,),
                                                                                              ],
                                                                                            )
                                                                                        ),
                                                                                        SizedBox(height: 10,)
                                                                                      ],
                                                                                    );
                                                                                  }
                                                                              ),
                                                                            );
                                                                          }
                                                                      )
                                                                    }
                                                                ),
                                                                Text(
                                                                  doc.data["nbrcomments"].toString(),
                                                                  style: TextStyle(
                                                                      fontSize:15,
                                                                      color: Colors.black,
                                                                      fontFamily: "Montserratmini",
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                                              decoration: BoxDecoration(
                                                                color: Colors.grey[300],
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: Text(
                                                                doc.data["Category"],
                                                                style: TextStyle(
                                                                    fontSize:15,
                                                                    color: Colors.black,
                                                                    fontFamily: "Montserratmini",
                                                                    fontWeight: FontWeight.w500
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Container(
                                                                  child: Text(
                                                                    doc.data["Text"],
                                                                    maxLines:2,
                                                                    style: TextStyle(
                                                                        fontSize:17,
                                                                        color: Colors.black,
                                                                        fontFamily: "Montserratmini",
                                                                        fontWeight: FontWeight.w500
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                  child: Text(
                                                                    "See more",
                                                                    style:TextStyle(
                                                                      fontSize:17,
                                                                      color: Colors.blue,
                                                                      fontFamily: "Montserratmini",
                                                                      fontWeight: FontWeight.w500,
                                                                      decoration:TextDecoration.underline,
                                                                    ),
                                                                  ),
                                                                  onTap:() {
                                                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>PostPage(postid:doc.documentID,)));
                                                                  }
                                                              )
                                                            ]
                                                        ),
                                                        SizedBox(height: 15,),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 10,
                                                    width:double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                    ),
                                                  ),
                                                  SizedBox(height: 15,),
                                                ],
                                              );
                                            }
                                        ).toList()
                                    )
                                  ]
                              ),
                            )
                            ;
                          }
                          else{
                            return  Padding(
                                padding: EdgeInsets.only(left: 30,right: 30,top: 20),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "There is no Posts",
                                      style: TextStyle(
                                          fontSize:20,
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w800
                                      ),
                                    ),
                                  ],
                                ),
                            );
                          }
                        }
                    ),
                  ],
                ),
              );
            }
            else{
              return LoadingScreen();
            }
          }
      ),
    );
  }
}

