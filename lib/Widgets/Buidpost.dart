import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mrec_alumni/Operations/CrudDb.dart';
import '../Size/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Options.dart';
import '../Operations/Authentication.dart';
import '../Pages/ViewProfile.dart';
class Build extends StatefulWidget {

  bool userliked;
  String uid,pkey,image,username,title,blog,liked,cuid,profileurl;
  Build(this.cuid,
      this.uid,
      this.pkey,
      this.image,
      this.blog,
      this.title,
      this.liked,
      this.profileurl,
      this.username,
      this.userliked);

  @override
  _BuildState createState() => _BuildState();
}

class _BuildState extends State<Build> {

  Options op;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }




  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,bottom: 3*SizeConfig.blockSizeVertical,
          left:0*SizeConfig.blockSizeHorizontal,right:
         0*SizeConfig.blockSizeHorizontal),
      height: 70*SizeConfig.blockSizeVertical,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
            topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
            bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
            bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
        ),
        color: Colors.black45,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[



                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ViewProfile(widget.uid)));
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0*SizeConfig.blockSizeVertical,top: 1.25*SizeConfig.blockSizeHorizontal,right: 1.25*SizeConfig.blockSizeHorizontal,bottom: 0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(widget.profileurl),
                              radius : 3.2*SizeConfig.blockSizeVertical ,
                              backgroundColor: Colors.black12,
                            ),
                          ),
                          Text(widget.username,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 4.1*SizeConfig.blockSizeHorizontal,
                                fontFamily: 'NunitoSans',
                                //fontFamily:'Courgette',
                                color:Colors.cyan[600]),
                          ),
                        ],
                      ),
                    ),

                  ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[

                  IconButton(
                    // padding:EdgeInsets.only(left: 145),
                    icon: Icon(widget.userliked?Icons.favorite:Icons.favorite_border, color: Colors.cyan[600],size: 6.94*SizeConfig.blockSizeHorizontal,),
                    color: Colors.white,
                    onPressed:()  async {

                List<String> newlikes = await CrudDB().updateLikes(widget.pkey,widget.uid);
                setState(() {
                  widget.liked=newlikes[0];
                  if(newlikes[1]=="true")
                    {
                      widget.userliked=true;
                    }
                  else if(newlikes[1]=="false"){
                    widget.userliked=false;
                  }
                });
                // widget.auth.signOut();
                    },
                  ),
                  Text(widget.liked,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 3.3*SizeConfig.blockSizeHorizontal,
                       fontFamily: 'NunitoSans',
                        //fontFamily:'Courgette',
                        color:Colors.cyan[600]),),
                  IconButton(
                    // padding:EdgeInsets.only(left: 145),
                    icon: Icon(Icons.more_vert, color: Colors.cyan[600],size: 6.94*SizeConfig.blockSizeHorizontal),
                    color: Colors.white,
                    onPressed:(){
                      setState(() {
                        op = Options(widget.username,widget.pkey);
                      });
                      op.options(context);// widget.auth.signOut();
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(

              child: ClipRRect(

                child: Image.network(widget.image,fit: BoxFit.contain,),
              ),
              margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,
                  //left:1.38*SizeConfig.blockSizeHorizontal,
                  //right: 1.38*SizeConfig.blockSizeHorizontal
                ),
              height: 40*SizeConfig.blockSizeVertical,
              color:Colors.white10
          ),
          ),
          Container(child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
              padding:  EdgeInsets.fromLTRB(3*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
              child: Text(widget.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 4.72*SizeConfig.blockSizeHorizontal,
                  fontFamily: 'NunitoSans',
                    //fontFamily:'Courgette',
                    color:Colors.cyan[600]),
              ),
            ),
              Padding(
                padding:  EdgeInsets.fromLTRB(3*SizeConfig.blockSizeHorizontal,0.5*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                child: Text( widget.blog,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 3.83*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',

                      //fontFamily:'Courgette',
                      color:Colors.cyan[600]),
                ),
              ),],
          ),),

        ],
      ),
    );
  }
}
