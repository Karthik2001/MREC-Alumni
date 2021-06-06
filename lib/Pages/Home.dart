
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Feeds.dart';
import 'Search.dart';
import 'Profile.dart';
import 'Notification.dart';
import '../Size/SizeConfig.dart';
import '../Operations/Authentication.dart';
class Home extends StatefulWidget {
  Home({
   this.auth,
   this.onSignedOut
});
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentTab=0;



  Widget currentScreen =Feeds();
   final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(


        backgroundColor: Colors.black,
        body:PageStorage(
          child : currentScreen,
          bucket :bucket,
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 40,
          child: Container(
         color: Colors.black,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      onPressed:() async {

                        setState(()  {
                          if(currentTab!=0)
                          currentScreen=Feeds();
                          currentTab=0;
                        }
                        );
                        },
                      icon: Icon(
                          Icons.home,
                          color: currentTab==0?Colors.white:Colors.cyan[600],
                          size:currentTab==0? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      color: Colors.white,
                      onPressed:(){
                        setState(() {
                          if(currentTab!=1)
                          currentScreen=Search();
                          currentTab=1;
                        });
                      },
                      icon: Icon(
                          Icons.search,
                          color: currentTab==1?Colors.white:Colors.cyan[600],
                          size:currentTab==1? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      color: Colors.white,
                      onPressed:() async {

                        setState(() {
                         if(currentTab!=2)
                          currentScreen=Notification1();

                          currentTab=2;
                        });
                      },
                      icon: Icon(
                          Icons.notifications_none,
                          color: currentTab==2?Colors.white:Colors.cyan[600],
                          size:currentTab==2? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      color: Colors.white,
                      onPressed:() async {

                        if(currentTab!=3)
                        setState(() {

                          currentScreen=Profile();
                          currentTab=3;
                        });
                      },
                      icon: Icon(Icons.person_outline,
                          color: currentTab==3?Colors.white:Colors.cyan[600],
                          size:currentTab==3? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
