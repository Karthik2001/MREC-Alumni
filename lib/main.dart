
import 'Pages/Search.dart';
import 'Pages/Profile.dart';
import 'Pages/Notification.dart';
import 'package:flutter/material.dart';
import 'Pages/Editprofile.dart';
import 'Pages/Login.dart';
import 'Pages/UploadImage.dart';
import 'Operations/Mapping.dart';
import 'Size/SizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}
class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
        builder: (context,constraints){

          return OrientationBuilder(
              builder: (context,orientation){
                SizeConfig().init(constraints, orientation);
                return  MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home :  MappingPage(),
                    color: Colors.cyan[600],
                    title: 'MREC Alumni',
                    routes:{

                      '/search':(context)=>Search(),
                      '/profile':(context)=>Profile(),
                      '/notification':(context)=> Notification1(),
                      '/login':(context)=>Login(),
                      '/uploadImage':(context)=>UploadPost(),
                      '/editprofile': (context)=>EditProfile(),

                    }
                );
              }
          );
        }
    );
  }
}