

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Size/SizeConfig.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Operations/Authentication.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Home.dart';
import 'Loading.dart';
import 'package:uuid/uuid.dart';



    class UploadPost extends StatefulWidget {
      final Auth auth = Auth();


      @override
      _UploadPostState createState() => _UploadPostState();
    }

    class _UploadPostState extends State<UploadPost> {

      bool loading = false;
      File sampleImage;
      String _myvalue,_blog;
      String _url;
      String Username='';


      final formKey = GlobalKey<FormState>();
      Future getImage()async{

        var tempimage =await ImagePicker.pickImage(source:ImageSource.gallery,imageQuality: 50);
        setState(() {
          sampleImage=tempimage;
        });
      }
       bool validateAndSave(){
        final form= formKey.currentState;
        if(form.validate()&&sampleImage!=null){
          form.save();
          return true;
        }
        else{
          if(sampleImage==null)
            {  Fluttertoast.showToast(
              msg: "Please Select an Image",
              //backgroundColor: Colors.black87,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 8,
            );

            }
          return false;
        }
       }
       void uploadImage() async{
        if(validateAndSave())
          {
            final StorageReference postImageRef= FirebaseStorage.instance.ref().child("Post Images");
            var timekey = DateTime.now();
            final StorageUploadTask uploadTask =postImageRef.child(timekey.toString()+".jpg").putFile(sampleImage);
            var Imageurl = await (await uploadTask.onComplete).ref.getDownloadURL();
            _url = Imageurl.toString();
            saveToDatabase(_url);

          }
       }

       void gotoHome(){
         Navigator.of(context).pop();
          Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>Home()));
         Fluttertoast.showToast(
           msg: "Blog Uploaded",
           //backgroundColor: Colors.black87,
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 3,
         );
       }

      Future<String> getCurrentUsername()async
      {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
        User user = await _firebaseAuth.currentUser;

        return user.displayName;
      }
      Future<String> getCurrentUserid()async
      {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
      User user = await _firebaseAuth.currentUser;

      return user.uid;
      }
       Future<void> saveToDatabase(url) async {
         var dbTimeKey = DateTime.now();
         var formatDate= DateFormat('yyy-MM-d');
         var formatTime= DateFormat('HH:mm:ss');
         String Uid= await getCurrentUserid();
         String date=formatDate.format(dbTimeKey);
         String time=formatTime.format(dbTimeKey);
         String uuid = Uuid().v4();
         String uname;
         String profileurl;
         DatabaseReference dbref = FirebaseDatabase.instance.reference();
         await dbref.child("Users").child(Uid).child("userdetails").once().then((DataSnapshot snap) async {
           var Keys = snap.value.keys;
           print(Keys);
           var Data = snap.value;
           print(Data);
              uname =Data["name"];
              profileurl=Data["profileurl"];
              print(uname);
         }).whenComplete(() async {


            var data={
              "username":uname,
              "image":url,
              "uid": Uid,
              "title":_myvalue,
              "blog":_blog,
              "date":date,
              "time":date+" "+time,
              "liked": 0.toString(),
              "id":uuid,
              "profileurl":profileurl,

            };
             await dbref.child("Post").child(uuid).set(data).whenComplete(() async {

              setState(() {
                loading= false;

              });
             await dbref.child("Users").child(Uid).child("Post").child(uuid).set(data);
              gotoHome();
            });

          });



       }

      @override
      Widget build(BuildContext context) {
        return loading?Loading():Scaffold(
          resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: false,
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

                icon: Icon(Icons.near_me, color: Colors.cyan[600],size: 7.3*SizeConfig.blockSizeHorizontal,),
                color: Colors.white,
                onPressed:() async {
                 if(validateAndSave()) {
                   setState(()  {
                     loading =true;
                   });
                   uploadImage();
                 }



                  // widget.auth.signOut();
                },
              ),
            ],


          ),
            body: Column(
              children: <Widget>[

                Form(
                  key: formKey,
                  child:
                  Expanded(
                    child: Container(
                      // height: MediaQuery.of(context).size.height -74,
                      margin: EdgeInsets.only(top: 0),
                     color: Colors.black,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
                            height: 34*SizeConfig.blockSizeVertical,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.cyan[600],
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                                  topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
                                  bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                                  bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
                              ),
                              color: Colors.black,


                            ),
                            child: sampleImage==null?selectImage(): FlatButton(
                              onPressed: getImage,
                              child: Container(

                                  child: ClipRRect(
                                  //  Image.file(sampleImage,height: 34*SizeConfig.blockSizeVertical,width:100*SizeConfig.blockSizeHorizontal,fit: BoxFit.scaleDown)
                                    child: Image.file(sampleImage,fit: BoxFit.contain,),
                                  ),
                                  margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,
                                    //left:1.38*SizeConfig.blockSizeHorizontal,
                                    //right: 1.38*SizeConfig.blockSizeHorizontal
                                  ),
                                  height: 40*SizeConfig.blockSizeVertical,
                                  color:Colors.white10
                              ),
                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.fromLTRB(2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                              child: TextFormField(
                                style: TextStyle(color: Colors.cyan[600]),
                                validator: (value){
                                  return value.isEmpty?'Title is required':null;
                                },
                                onSaved: (value){
                                  return _myvalue=value;

                                },
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (v){
                                  FocusScope.of(context).nextFocus(); // move focus to next
                                },
                                maxLengthEnforced:false ,
                                // maxLines: 3,
                                autocorrect: true,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: "Title",

                                  hintStyle: TextStyle(color: Colors.cyan[600],),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(2*SizeConfig.blockSizeHorizontal)),
                                    borderSide: BorderSide(color: Colors.cyan[600]),
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(2*SizeConfig.blockSizeHorizontal)),
                                    borderSide: BorderSide(color: Colors.cyan[600]),
                                  ),

                                ),
                              ),
                            ),


                          Padding(
                            padding: EdgeInsets.fromLTRB(2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                            child: TextFormField(
                              validator: (value){
                                return value.isEmpty?'Blog Content is required':null;
                              },
                              onSaved: (value){
                                return _blog=value;

                              },
                              maxLengthEnforced:true,
                              maxLines: 5,
                              autocorrect: true,
                              style: TextStyle(color: Colors.cyan[600]),
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Blog Content",

                                hintStyle: TextStyle(color: Colors.cyan[600],),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(2*SizeConfig.blockSizeHorizontal)),
                                  borderSide: BorderSide(color: Colors.cyan[600]),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(2*SizeConfig.blockSizeHorizontal)),
                                  borderSide: BorderSide(color: Colors.cyan[600]),
                                ),

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ),


              ],
            ),


        );
      }

      Widget selectImage(){
        return Container(
          margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
          height: 34*SizeConfig.blockSizeVertical,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
                bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
            ),
            color: Colors.black,

          ),
        child: Center(
          child:   FlatButton(
            child:Text(' Tap to Select Image ',style :TextStyle(fontFamily:'NunitoSans',fontSize:5.88*SizeConfig.blockSizeHorizontal,color:Colors.cyan[600])),
            color:Colors.black,
            onPressed: getImage,
          ),
        ),);

      }

    }