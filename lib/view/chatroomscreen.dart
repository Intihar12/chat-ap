import 'package:chat_ap/helper/constant.dart';
import 'package:chat_ap/services/auth.dart';
import 'package:chat_ap/view/search.dart';
import 'package:chat_ap/view/signin.dart';
import 'package:flutter/material.dart';

import '../helper/athenticate.dart';
import '../helper/helperfunction.dart';

class chatRoom extends StatefulWidget {
  const chatRoom({Key? key}) : super(key: key);

  @override
  _chatRoomState createState() => _chatRoomState();
}

class _chatRoomState extends State<chatRoom> {
  AuthMethods authMethods=new AuthMethods();
  @override
  void initState() {
    // TODO: implement initState
    getUserinfo();
    super.initState();
  }
  getUserinfo()async{
    Constants.myName= await HelperFunction.getuserNamesheredpreference().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/images/logo.png", height: 50,),
      actions: [
        GestureDetector(
          onTap: (){
            authMethods.signout();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authenticate()));
          },
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.exit_to_app),
         )
        )
      ],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
      onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
      },
      ),
    );
  }
}
