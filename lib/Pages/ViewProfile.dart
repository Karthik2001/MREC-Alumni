import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mrec_alumni/Operations/CrudDb.dart';
import 'package:mrec_alumni/Widgets/Profiledata.dart';

import '../Size/SizeConfig.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Myblogs.dart';
import 'Loading.dart';

class ViewProfile extends StatefulWidget {
  String uid;

 ViewProfile(this.uid);
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {


  Future<Profiledata> readData() async {
    Profiledata Userdata;
    Userdata = await CrudDB().readProfiledata(widget.uid);
    return Userdata;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: readData(),
        builder:(BuildContext context,AsyncSnapshot<Profiledata> snapshot){
          if(snapshot.hasData){
            Profiledata u = snapshot.data;


            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title:Text(
                      "View Profile",
                      style: TextStyle(
                        wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                        fontFamily: 'NunitoSans',
                        fontSize: 6.9*SizeConfig.blockSizeHorizontal,

                        color: Colors.cyan[600],
                      )),
                  centerTitle: false,
                  iconTheme: IconThemeData(color: Colors.cyan[600]),
                  backgroundColor:Colors.black,




                ),
                backgroundColor: Colors.black,

                body:ListView(
                  children: <Widget>[
                    Container(
                      height :28*SizeConfig.blockSizeVertical,
                      child: Column(
                          children:<Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal, 0*SizeConfig.blockSizeVertical, 0*SizeConfig.blockSizeHorizontal, 0),
                              child: Row(


                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(u.url),
                                      radius : 7.27*SizeConfig.blockSizeVertical,
                                      backgroundColor: Colors.white70,
                                    ),
                                    Container(
                                      margin:  EdgeInsets.fromLTRB(2.77*SizeConfig.blockSizeHorizontal,3.63*SizeConfig.blockSizeVertical,0,0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(u.username,
                                            style: TextStyle(
                                                fontSize: 5.5*SizeConfig.blockSizeHorizontal,
                                                fontFamily: 'NunitoSans',


                                                color:Colors.cyan[600]
                                            ),
                                          ),
                                          Text(u.status,
                                            style: TextStyle(
                                                fontSize: 3.6*SizeConfig.blockSizeHorizontal,
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.bold,

                                                color:Colors.cyan[600]
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),]),
                            ),
                            FlatButton(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal, 3.63*SizeConfig.blockSizeVertical, 5.5*SizeConfig.blockSizeHorizontal, 0),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(

                                      children: <Widget>[
                                        Text((u.blogcount).toString(),
                                          style: TextStyle(
                                            fontSize: 6.9*SizeConfig.blockSizeHorizontal,
                                            color:Colors.cyan[600],
                                            fontFamily: 'NunitoSans',
                                          ),
                                        ),

                                        Text('My Posts',
                                          style: TextStyle(
                                              fontSize: 4.16*SizeConfig.blockSizeHorizontal,
                                              fontFamily: 'NunitoSans',
                                              color:Colors.cyan[600]
                                          ),
                                        ),

                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text((u.liked).toString(),
                                          style: TextStyle(
                                            fontSize:  6.9*SizeConfig.blockSizeHorizontal,
                                            color:Colors.cyan[600],
                                            fontFamily: 'NunitoSans',
                                          ),
                                        ),
                                        Text('Likes',
                                          style: TextStyle(
                                              fontSize: 4.16*SizeConfig.blockSizeHorizontal,
                                              fontFamily: 'NunitoSans',
                                              color:Colors.cyan[600]
                                          ),
                                        ),

                                      ],
                                    ),
                                    Container(
                                      margin:  EdgeInsets.only(left:16.6*SizeConfig.blockSizeHorizontal,top: 0.9*SizeConfig.blockSizeVertical),
                                      child: FlatButton(

                                        onPressed:() {

                                        },
                                        padding: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(2.18*SizeConfig.blockSizeVertical),
                                            side: BorderSide(color: Colors.black,)
                                        ),
                                        // color: Color(0XFF00857C),
                                        child: Text('Edit Profile',
                                          style: TextStyle(
                                              fontSize: 3.3*SizeConfig.blockSizeHorizontal,
                                              fontFamily: 'NunitoSans',
                                              fontWeight: FontWeight.bold,
                                              color:Colors.black
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed:((){
                                String uid;
                                setState(() {
                                  uid= u.uid;
                                });
                                {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => MyBlogs(uid: widget.uid,)));};
                              }),

                            ),


                          ]
                      ),
                    ),

                    //User_information(),
                    Container(

                      decoration: BoxDecoration(

                          color: Colors.black,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(5.5*SizeConfig.blockSizeHorizontal),topLeft:Radius.circular(5.5*SizeConfig.blockSizeHorizontal))
                      ),
                      padding: EdgeInsets.all(1.0),
                      height:70*SizeConfig.blockSizeVertical,
                      //constraints: BoxConstraints.expand(),
                      margin: EdgeInsets.fromLTRB(0,1.8*SizeConfig.blockSizeVertical,0,0),
                      child: SizedBox(
                        // height:40,
                        child: Container(

                          child: ListView(
                            //  semanticChildCount: 2,
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              // User_information(),
                              SizedBox(height: 1.8*SizeConfig.blockSizeVertical,),
                              _buidContainer("Status",u.status,u.url),
                              _buidContainer("Skills",u.skills,u.url),
                              _buidContainer("Branch",u.branch,u.url ),
                              _buidContainer("Contact Info",u.email,u.url),
                              _buidContainer("Works at",u.worksat,u.url),
                              SizedBox(height: 36.3*SizeConfig.blockSizeVertical,),




                            ],
                          ),
                        ),
                      ),
                    ),
                    // UserDetails(),

                  ],
                ),
              ),
            );

          }

          else{

            print(snapshot.data);
            return Center(child: CircularProgressIndicator());
          }
        }
    );

  }

}



















Widget _buidContainer(String Tag,String Info,String url) {

  return Container(
    margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
    height: 15*SizeConfig.blockSizeVertical,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white12,
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
          topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
          bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
          bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
      ),
      color: Colors.black,

    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 2.7*SizeConfig.blockSizeHorizontal,top: 4.5,right: 1.94*SizeConfig.blockSizeHorizontal,bottom: 1.8*SizeConfig.blockSizeVertical),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url),
                      radius : 15 ,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),

                  Text(Tag,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 3.8*SizeConfig.blockSizeHorizontal,
                        fontWeight: FontWeight.w700, fontFamily: 'NunitoSans',
                        //fontFamily:'Courgette',
                        color:Colors.cyan[600]),
                  ),

                ]
            ),
          ],
        ),
        Padding(
          padding:  EdgeInsets.fromLTRB(3.88*SizeConfig.blockSizeHorizontal, 1.45*SizeConfig.blockSizeVertical, 2.22*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical ),
          child: Text(Info,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 4.1*SizeConfig.blockSizeHorizontal,
                fontFamily: 'NunitoSans',
                //fontFamily:'Courgette',
                color:Colors.cyan[600]),
          ),
        ),
      ],

    ),
  );
}












