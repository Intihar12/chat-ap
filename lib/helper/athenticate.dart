import 'package:chat_ap/view/signin.dart';
import 'package:chat_ap/view/signup.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin=true;
  void toggleView(){
    setState(() {
      showSignin = !showSignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return signIn(toggleView);
    }else{
      return signup(toggleView);
    }
  }
}
