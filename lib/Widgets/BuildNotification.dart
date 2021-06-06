import 'package:flutter/material.dart';
import '../Size/SizeConfig.dart';
import '../Pages/ViewProfile.dart';

class BuildNotification extends StatefulWidget {
  String person;
  String title;
  String image;
  String uid;
  BuildNotification(this.person,this.image,this.title,this.uid);
  @override
  _BuildNotificationState createState() => _BuildNotificationState();
}

class _BuildNotificationState extends State<BuildNotification> {
  @override
  Widget build(BuildContext context) {


      return Container(
        margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
       height: 10*SizeConfig.blockSizeVertical,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
              topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
              bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
              bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
          ),
          color: Colors.black,

        ),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        print(widget.uid);
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ViewProfile(widget.uid)));
                      },
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:<Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(widget.image),
                                radius : 3.45*SizeConfig.blockSizeVertical,
                                backgroundColor: Colors.black12,
                              ),
                              Flexible(
                                child: FlatButton(
                                
                                  child: Text( widget.person +" liked your post titled "+ widget.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 4*SizeConfig.blockSizeHorizontal,

                                        fontFamily: 'NunitoSans',
                                        //fontFamily:'Courgette',
                                        color:Colors.cyan[600]),
                                  ),
                                ),
                              ),


                            ]
                        ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      );

  }
}

