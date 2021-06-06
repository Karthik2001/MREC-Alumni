
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrec_alumni/Operations/CrudDb.dart';
import 'Loading.dart';
import '../Operations/SearchService.dart';
import 'ViewProfile.dart';
import '../Size/SizeConfig.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<String>> L=[];
  String name;
  Future<List<List<String>>> search( ) async {

    L= await CrudDB().searchUser(name);
    setState(() {
      L.sort((a,b) => b[0].compareTo(a[0]));
      L=L.reversed.toList();
    });
    return L;



  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding:  EdgeInsets.all(01*SizeConfig.blockSizeVertical),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[

              Container(
                height: 11*SizeConfig.blockSizeVertical,
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(0.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,0.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                  child: TextFormField(
                    

                    onChanged:(val){
                      print(val+"sds");
                      setState(() async {
                        name=val.isEmpty?"":val;
                        search();
                      });

                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search User",
                      prefixIcon: Icon(Icons.search,color: Colors.cyan[600]),
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
              ),

              Padding(
                padding:  EdgeInsets.only(top: 3*SizeConfig.blockSizeVertical),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: L.length,
                  itemBuilder: (context, index) {
                    return ListTile(

                      title:Text(  L[index][1], style: TextStyle(color:Colors.cyan[600]),),
                      leading:  CircleAvatar(
                        backgroundImage: NetworkImage(L[index][2]),
                        radius : 3.45*SizeConfig.blockSizeVertical,
                        backgroundColor: Colors.black12,
                      ),
                      onTap: (){
                        print(L[index][0]);
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ViewProfile(L[index][0])));
                      },
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}

