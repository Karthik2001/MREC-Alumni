import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrec_alumni/Operations/CrudDb.dart';
import 'UploadImage.dart';

import '../Operations/Authentication.dart';
import '../Size/SizeConfig.dart';

import 'package:url_launcher/url_launcher.dart';
import '../Widgets/Blog.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Widgets/Buidpost.dart';
import 'Loading.dart';
class MyBlogs extends StatefulWidget {
  MyBlogs({this.uid});
  String uid;
  Auth auth = Auth();
  @override
  _MyBlogsState createState() => _MyBlogsState();
}

class _MyBlogsState extends State<MyBlogs> {
  set(){
    setState(() {
      readData();
    });

  }
  Future<List<Blog>> readData() async
  {
    List<Blog> L =[];
    L= await CrudDB().readMyBlogData(widget.uid);

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
            'My Blogs',
            style: TextStyle(
              wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
              fontFamily: 'NunitoSans',
              fontSize: 6.9*SizeConfig.blockSizeHorizontal,

              color: Colors.cyan[600],
            )),
        centerTitle: false,
        shape:ContinuousRectangleBorder(
          borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(2*SizeConfig.blockSizeVertical),
              bottomRight: Radius.circular(2*SizeConfig.blockSizeVertical)
          ),
        ),
        backgroundColor:Colors.black,




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
            else if((snapshot.hasData&&snapshot.data.length==0)||snapshot.data==null){
              return Center(
                child: Text("No Feeds Yet" ,style: TextStyle(color:Colors.cyan[600]),),
              );
            }

            else{

              print(snapshot.data);
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.cyan[600],));
            }
          }
      ),




    );
  }


}

