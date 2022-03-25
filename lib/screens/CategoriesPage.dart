import 'package:blogging_app/screens/OneCategoryPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class CategoriesPage extends StatelessWidget {
  @override
  String id;
  CategoriesPage({this.id});
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Padding(
      padding:EdgeInsets.only(left: 30,right: 30,top: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Categories").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return GridView.count(
                childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.7),
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                children:snapshot.data.documents.map(
                      (DocumentSnapshot doc) =>
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: size.width*0.3,
                            width: size.width*0.3,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder:(context)=>OneCategoryPage(id:id,Category:doc.data["Category"])));
                              },
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(doc.data["ImageUrl"]),
                                  fit:BoxFit.cover,
                                )
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>
                                  OneCategoryPage(Category:doc.data["Category"])));
                            },
                              child:Container(
                                width: size.width*0.3,
                                  child: Center(
                                    child: Text(
                                        doc.data["Category"],
                                      style:TextStyle(
                                        fontSize:17,
                                        color: Color(0xff2b106a),
                                        fontFamily: "Montserratmini",
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                ),
                                  ),
                              )
                          )
                        ],
                      ),

                ).toList()
            );
          }
          else{
            return Column(
              children: [
                Text("")
              ],
            );
          }
        }
      ),
    );
  }
}
