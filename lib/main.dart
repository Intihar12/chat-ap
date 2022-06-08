import 'package:chat_ap/helper/helperfunction.dart';
import 'package:chat_ap/view/chatroomscreen.dart';
import 'package:chat_ap/view/signin.dart';
import 'package:chat_ap/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'helper/athenticate.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool userislogind=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  getloginstate()async{
    await HelperFunction.getuserLoginsheredpreference().then((value){
userislogind= value!;
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
      ),
      home: userislogind != null ? /**/userislogind ? chatRoom() : Authenticate()/**/ : Authenticate() ,
    );
  }
}

class iamback extends StatefulWidget {
  const iamback({Key? key}) : super(key: key);

  @override
  State<iamback> createState() => _iambackState();
}

class _iambackState extends State<iamback> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


