
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrec_alumni/Operations/CrudDb.dart';
import 'UploadImage.dart';
import '../Operations/Authentication.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../Size/SizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/Blog.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Widgets/Buidpost.dart';
import 'Loading.dart';
class Feeds extends StatefulWidget {
String uid;
Feeds({this.uid});

  Auth auth = Auth();

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {


  Future<List<Blog>> readData() async
  {
    List<Blog> L =[];
    L= await CrudDB().readBlogData();

    return L;
  }

bool loading =true;
  Build buildpost;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

   appBar: AppBar(

     iconTheme: IconThemeData(color: Colors.cyan[600]),
       title:Text(
           'Mrec Alumni',
           style: TextStyle(
               wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
               fontFamily: 'NunitoSans',
               fontSize: 6.9*SizeConfig.blockSizeHorizontal,

               color: Colors.cyan[600],
     )),
       centerTitle: true,
       shape:ContinuousRectangleBorder(
         borderRadius:  BorderRadius.only(
             bottomLeft: Radius.circular(2*SizeConfig.blockSizeVertical),
             bottomRight: Radius.circular(2*SizeConfig.blockSizeVertical)
         ),
       ),
       backgroundColor:Colors.black,

       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.add, color: Colors.cyan[600],size: 9.1*SizeConfig.blockSizeHorizontal,),

           onPressed:() {

             Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>UploadPost()));
           },
         ),
       ],


   ),
      body: FutureBuilder(
          future: readData(),
          builder:(BuildContext context,AsyncSnapshot<List<Blog>> snapshot){
            if(snapshot.hasData){
              List<Blog> bloglist = snapshot.data;

              return ListView.builder(
                itemCount: bloglist.length,
                itemBuilder: (context, index) {
                  buildpost= Build(widget.uid,bloglist[index].uid,bloglist[index].key,bloglist[index].image,bloglist[index].blog,bloglist[index].title,bloglist[index].liked,bloglist[index].profileurl,bloglist[index].username,bloglist[index].userliked);

                  return buildpost;
                },
              );

            }
            else if((snapshot.hasData&&snapshot.data.length==0)&&snapshot.data==null){
              return Center(
                child: Text("No Feeds Yet" ,style: TextStyle(color:Colors.cyan[600]),),
              );
            }

            else{

              print(snapshot.data);
              return Center(child: CircularProgressIndicator(
                backgroundColor: Colors.cyan[600],
              ));
            }
          }
      ),


      drawer:Drawer(

    child: Container(
    color: Colors.black,
      child: ListView(
        children: <Widget>[
          Padding(

            padding:  EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal,3.63*SizeConfig.blockSizeVertical,5.5*SizeConfig.blockSizeVertical,3.63*SizeConfig.blockSizeVertical),
            child: Text(
                'Mrec Alumni',
                style: TextStyle(
                    wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                    fontFamily: 'NunitoSans',
                    fontSize: 6*SizeConfig.blockSizeHorizontal,

                    color: Colors.cyan[600],
      )),
          ),
          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Mrec website',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 4.1*SizeConfig.blockSizeHorizontal,
                      color: Colors.cyan[600],
)),
              leading : Icon(Icons.web,color:Colors.cyan[600],size: 5.5*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/Placement_Details.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Announcements',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 4.1*SizeConfig.blockSizeHorizontal,
                      color: Colors.cyan[600],
)),
              leading : Icon(Icons.record_voice_over,color: Colors.cyan[600],size: 5.5*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: ()async {


              const url = 'hhttps://mrecexamcell.com/Login.aspx?ReturnUrl=%2f';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Results',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 4.1*SizeConfig.blockSizeHorizontal,

                      color: Colors.cyan[600],
)),
              leading : Icon(Icons.library_books,color: Colors.cyan[600],size: 5.5*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/Placement_Details.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Placements',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 4.1*SizeConfig.blockSizeHorizontal,

                      color: Colors.cyan[600],
)),
              leading : Icon(Icons.outlined_flag,color: Colors.cyan[600],size: 5.5*SizeConfig.blockSizeHorizontal,),
            ),
          ),

          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/photogallery.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Events',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 4.1*SizeConfig.blockSizeHorizontal,

                      color: Colors.cyan[600],
   )),
              leading : Icon(Icons.account_balance,color: Colors.cyan[600],size: 5.5*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap:()async {
              const url = 'http://www.mrec.ac.in/sac.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Clubs',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 4.1*SizeConfig.blockSizeHorizontal,

                      color: Colors.cyan[600],
)),
              leading : Icon(Icons.music_note,color: Colors.cyan[600],size: 5.5*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: (){

              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              widget.auth.signOut();
            },
            child: ListTile(
              title: Text(
                  'Log Out',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 4.1*SizeConfig.blockSizeHorizontal,

                      color:Colors.cyan[600],
)),
              leading : Icon(Icons.devices_other,color: Colors.cyan[600],size: 5.5
                  *SizeConfig.blockSizeHorizontal,)
            ),
          ),
        ],
      ),
    ),
    ),

    );
  }


}