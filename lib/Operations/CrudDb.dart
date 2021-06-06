import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mrec_alumni/Pages/Profile.dart';
import 'package:mrec_alumni/Widgets/Blog.dart';
import 'package:mrec_alumni/Widgets/NotificationPerson.dart';
import 'package:mrec_alumni/Widgets/Profiledata.dart';

class CrudDB{
  Future<bool> userliked(pkey,uid) async {
    bool liked;
    DatabaseReference dbref = FirebaseDatabase.instance.reference();
    await dbref.child("Post").child(pkey).child("likedby").child(uid).once().then((value) {

      if(value.value==null)
        liked= false;
      else
        liked= true;

    });
    return liked;
  }
  Future<List<Blog>> readBlogData() async {


    List<Blog> bloglist =[];
    DatabaseReference postsref =  FirebaseDatabase.instance.reference().child("Post");
    DatabaseReference userref =  FirebaseDatabase.instance.reference();
   await postsref.once().then((DataSnapshot snap) async{
      var Keys = snap.value.keys;

      var Data=snap.value;
      bloglist.clear();
      for(var individualKeys in Keys)
      {
        bool liked;
        String Username;
      await userref.child("Users").child(Data[individualKeys]['uid']).child("userdetails").child("name").once().then((val)
      {
        Username=val.value;
      });
      liked= await userliked(individualKeys, await getCurrentUserId());

        Blog blogs = Blog(
            Data[individualKeys]['uid'],
            individualKeys,
            Data[individualKeys]['image'],
            Data[individualKeys]['blog'],
            Data[individualKeys]['title'],
            Data[individualKeys]['liked'],
            Data[individualKeys]['profileurl'],
            Username,
            Data[individualKeys]['time'],
            liked);
        bloglist.add(blogs);
      }





    });
    bloglist.sort((a,b) => b.dateTime.compareTo(a.dateTime));

    return bloglist;
  }
  Future<List<Blog>> readMyBlogData(String uid) async {


   List<Blog> bloglist =[];
   DatabaseReference postsref =  FirebaseDatabase.instance.reference().child("Users").child(uid).child("Post");
   DatabaseReference userref =  FirebaseDatabase.instance.reference();
   await postsref.once().then((DataSnapshot snap) async{
     var Keys = snap.value.keys;

     var Data=snap.value;

     bloglist.clear();
     for(var individualKeys in Keys)
     {
       bool liked ;
       String Username;
       await userref.child("Users").child(Data[individualKeys]['uid']).child("userdetails").child("name").once().then((val)
       {
         Username=val.value;
       });
     liked= await userliked(individualKeys, await getCurrentUserId());
       Blog blogs = Blog(
           Data[individualKeys]['uid'],
           individualKeys,
           Data[individualKeys]['image'],
           Data[individualKeys]['blog'],
           Data[individualKeys]['title'],
           Data[individualKeys]['liked'],
           Data[individualKeys]['profileurl'],
           Username,
           Data[individualKeys]['time'],
           liked);
       bloglist.add(blogs);
     }





   });
   bloglist.sort((a,b) => b.dateTime.compareTo(a.dateTime));


   return bloglist;
 }
  Future<String> getCurrentUsername()async {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
 User user = await _firebaseAuth.currentUser;

 return user.displayName;
 }
  Future<String> getCurrentUserId()async {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
 User user = await _firebaseAuth.currentUser;

 return user.uid;
 }
  Future<List<String>> updateLikes(String pkey,String wuid) async {

String Username= await getCurrentUsername();
String uid = await getCurrentUserId();
String data="d";
String UpdatedLikes;
String UpdatedUserLiked;
int likes;
 DatabaseReference dbref = FirebaseDatabase.instance.reference();
await dbref.child("Post").child(pkey).child("liked").once().then((value) {
  likes=int.parse(value.value);
});

await dbref.child("Post").child(pkey).child("likedby").child(uid).child(Username).once().then((value) async {
  if(value.value=="yes"){
     dbref.child("Post").child(pkey).child("likedby").child(uid).remove();
     dbref.child("Users").child(wuid).child("Post").child(pkey).child('likedby').child(uid).remove();
     dbref.child("Post").child(pkey).child('liked').set((likes-1).toString());
     dbref.child("Users").child(wuid).child("Post").child(pkey).child('liked').set((likes-1).toString());
     UpdatedLikes=(likes-1).toString();
     UpdatedUserLiked="false";

  }
  if(value.value==null)
    {
       dbref.child("Post").child(pkey).child("likedby").child(uid).child(Username).set('yes');
       dbref.child("Users").child(wuid).child("Post").child(pkey).child('likedby').child(uid).child(Username).set('yes');
       dbref.child("Post").child(pkey).child('liked').set((likes+1).toString());
       dbref.child("Users").child(wuid).child("Post").child(pkey).child('liked').set((likes+1).toString());
       UpdatedLikes=(likes+1).toString();
       UpdatedUserLiked="true";
    }
});



 return [UpdatedLikes,UpdatedUserLiked];
}
  Future<List<List<String>>> searchUser(String name) async {
   List<List<String>> SearchList=[];
   DatabaseReference dbref = FirebaseDatabase.instance.reference().child("Users");
   await dbref.once().then((DataSnapshot snap) async{
     var Keys = snap.value.keys;

     var Data=snap.value;


     for(var x in Keys)
     {

       if(Data[x]["userdetails"]["name"].toString().toLowerCase().contains(name.toLowerCase())&&name!='')
       {
         List<String> xpert = [x.toString(), Data[x]["userdetails"]["name"],Data[x]["userdetails"]["profileurl"]];
         SearchList.add(xpert);
       }


     }
   });

   return SearchList;


 }
  Future<List<NotificationPerson>> readNotifications() async {
   String uid = await getCurrentUserId();

   List<NotificationPerson> personList=[];
   DatabaseReference IDsref =  FirebaseDatabase.instance.reference().child("Users").child(uid).child("Post");
   DatabaseReference user =  FirebaseDatabase.instance.reference().child("Users");
   await IDsref.once().then((DataSnapshot snap) async {
     var Keys = snap.value.keys;

     var Data=snap.value;
     for(var individualKeys in Keys)
     {
       var title=Data[individualKeys]["title"];
       await IDsref.child(individualKeys).child("likedby").once().then((DataSnapshot data) async {

       if(data.value!=null)
         {   var uid = data.value.keys;
           for(var id in uid)
           {
             await user.child(id).once().then((DataSnapshot s)  async {

               var d= s.value;

               NotificationPerson person =NotificationPerson(
                   d['userdetails']['name'],
                   d['userdetails']['profileurl'],
                   title,
                   id
               );
               personList.add(person);

             });
           }
         }

       });
     }
   });

   return personList;
 }
  Future<Profiledata> readProfiledata(String uid) async {
   int liked=0;
   Profiledata userprofile;


   int blogcount=0;
   DatabaseReference userde=   FirebaseDatabase.instance.reference().child("Users").child(uid);
   await userde.once().then((DataSnapshot snap3) async{

       var Data=snap3.value;
     DatabaseReference userref =  FirebaseDatabase.instance.reference().child("Users").child(uid).child('Post');
     await userref.once().then((DataSnapshot snap) async {

       var postData=snap.value;
       if(postData!=null){
         var postKeys = snap.value.keys;

         for(var individualKeys in postKeys)
         {
           ++blogcount;
           liked = liked +int.parse(postData[individualKeys]['liked']);
         }
       }

     });

      userprofile=Profiledata(
         uid,
         Data['userdetails']['state'],
         Data['userdetails']['profileurl'],
         Data['userdetails']['branch'],
         Data['userdetails']['skills'],
         Data['userdetails']['email'],
         Data['userdetails']['phoneNumber'],
         Data['userdetails']['schoolname'],
         Data['userdetails']['worksat'],
         Data['userdetails']['name'],
         liked,
         blogcount
     );
   });

  return userprofile;
 }

}