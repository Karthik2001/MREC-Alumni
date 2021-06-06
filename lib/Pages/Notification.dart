import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrec_alumni/Operations/CrudDb.dart';
import 'package:mrec_alumni/Widgets/NotificationPerson.dart';
import '../Operations/Authentication.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Size/SizeConfig.dart';
import 'Loading.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Widgets/BuildNotification.dart';
import 'UploadImage.dart';
class Notification1 extends StatefulWidget {


  Auth auth = Auth();
  @override
  _Notification1State createState() => _Notification1State();
}


class _Notification1State extends State<Notification1> {

  Future<String> getCurrentUserId()async
  {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  User user = await _firebaseAuth.currentUser;

  return user.uid;
  }
  set(){
    readData();
  }
  Future<List<NotificationPerson>> readData() async
  {
    List<NotificationPerson> L =[];
    L= await CrudDB().readNotifications();
    print(L);
    return L;
  }

  BuildNotification buildNotification;

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
          builder:(BuildContext context,AsyncSnapshot<List<NotificationPerson>> snapshot){
            if(snapshot.hasData && snapshot.data.length>0){
              List<NotificationPerson> personList = snapshot.data;
              print(snapshot.data.length);
              return ListView.builder(
                itemCount: personList.length,
                itemBuilder: (context, index) {
                  buildNotification= BuildNotification(
                      personList[index].name,
                      personList[index].image,
                      personList[index].title,
                      personList[index].uid
                  );

                  return buildNotification;
                },
              );

            }
            else if(snapshot.hasData&&snapshot.data.length==0){
              return Center(
                child: Text("N0 Notifications Yet" ,style: TextStyle(color:Colors.cyan[600]),),
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

