import 'package:cloud_firestore/cloud_firestore.dart';
class Userdata{
  String Username;String Location;String Aboutuser;
  String Skills;String Portfolio;String Education;
  int nbrposts;int nbrfollowers;int nbrfollowing;
  String UserImageUrl;
  Userdata({this.Username,this.Location,this.Aboutuser,this.Skills,this.Portfolio,
    this.nbrposts,this.nbrfollowers,this.nbrfollowing,this.Education,this.UserImageUrl});
}
class Fire {
  String id;
  Fire({this.id});
  Firestore fire = Firestore.instance;
  CollectionReference usercollection=Firestore.instance.collection("UsersProfiles");
  Future Updatedata( String id, var data) async {
    try {
      await fire.collection("UsersProfiles").document(id).updateData(data);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
  Future UploadaPost(String title,String category,String text,String id,String imageurl,int nbrposts)async{
     try {
      await fire.collection("Posts").document().setData(
         {
           "Title":title,
           "Category":category,
           "Text":text,
           "Owner":id,
           "ImageUrl":imageurl,
           "nbrlikes":0,
           "nbrcomments":0,
         }
       );
        await fire.collection("UsersProfiles").document(id).updateData(
        {
          "nbrposts":nbrposts
        }

       );

     } on Exception catch (e) {
       print(e.toString());
     }
  }
  Future delete(String path)async{
    await fire.collection(path).document(id).delete();
  }
  Future modifie(String path,String id,var data)async{
    try {
      await fire.collection(path).document(id).setData(data);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
  Future SetUserData(String Username,int nbrposts,int nbrfollowers,int nbrfollowing,String Location,String Aboutuser,String Education,String Portfolio,String Skills,dynamic UserImageUrl)async{
    try {
      await fire.collection("UsersProfiles").document(id).setData(
          {
            "nbrposts":nbrposts,
            "nbrfollowers":nbrfollowers,
            "nbrfollowing":nbrfollowing,
            "Location":Location,
            "Aboutuser":Aboutuser,
            "Portfolio":Portfolio,
            "Skills":Skills,
            "Username":Username,
            "Education":Education,
            "UserImageUrl":UserImageUrl,
            "LickedPosts":[]
          }
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }
  Stream<Userdata> get data{
    return  usercollection.document(id).snapshots().map(Userdatafromfirestore);
  }
  Userdata Userdatafromfirestore(DocumentSnapshot doc){
    return Userdata(
        nbrposts:doc.data["nbrposts"],
        nbrfollowers:doc.data["nbrfollowers"],
        nbrfollowing:doc.data["nbrfollowing"],
        Location:doc.data["Location"],
        Aboutuser:doc.data["Aboutuser"],
        Portfolio:doc.data["Portfolio"],
        Skills:doc.data["Skills"],
        Username:doc.data["Username"],
        Education:doc.data["Education"],
        UserImageUrl:doc.data["UserImageUrl"]
    );
  }
}