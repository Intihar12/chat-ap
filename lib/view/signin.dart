import 'package:chat_ap/services/auth.dart';
import 'package:chat_ap/services/database.dart';
import 'package:chat_ap/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/helperfunction.dart';
import 'chatroomscreen.dart';

class signIn extends StatefulWidget   {
  final Function toggle;
  signIn(this.toggle);
  //const signIn({Key? key,  this.toggle}) : super(key: key);
  //Size get preferredSize =>  Size.fromHeight(100);

  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
 // Size get preferredSize => const Size.fromHeight(100);
AuthMethods authMethod = AuthMethods();
DtabaseMethods databaseMethods= DtabaseMethods();
  TextEditingController emailcontroller =TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();
final formkey=GlobalKey<FormState>();
QuerySnapshot <Map<String, dynamic>>? snapshotinfo;
bool isloading= false;
signin(){
  if(formkey.currentState!.validate()){
    HelperFunction.saveUserEmailSharedPreference(emailcontroller.text);
   // HelperFunction.saveusernamesheredpreference(usernamecontroller.text);

    databaseMethods.getuserbyuserEmail(emailcontroller.text).then((val){
      snapshotinfo=val;
      HelperFunction.saveUserEmailSharedPreference(snapshotinfo!.docs[0].data()["name"]);
    });
    setState(() {
      isloading=true;
    });


    authMethod.signInWithEmailAndPassword(emailcontroller.text, passwordcontroller.text).then((value){
      if(value != null) {
        HelperFunction.saveuserLoginsheredpreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => chatRoom()));
      }
    });

  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/images/logo.png", height: 50,),),
      body: SingleChildScrollView(

        child: Container(
          height: MediaQuery.of(context).size.height -70,
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Container(
              child:
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formkey,
         child:    Column(children: [


                 TextFormField(
                   validator: (val){
                     return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                         .hasMatch(val!) ?
                     null :  "Enter correct email"  ;
                   },
                   controller: emailcontroller,
                   style: simpletextfield(),
                   decoration: TextFieldInputDecoration("email"),
                 ),

                 TextFormField(
                     validator:  (val){
                       return val!.length < 6 ? "Enter Password 6+ characters" : null;
                     },
                     controller: passwordcontroller,
                     style: simpletextfield(),
                     decoration: TextFieldInputDecoration("password")),

             ],)),
SizedBox(height: 10,),



                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        child: Text("Forgot Password?", style: simpletextfield(),),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        signin();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [ Color(0xff007ef4),
                            Color(0xff2A75BC)]
                          ),
borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text("Sign in", style: mediumtextfield(),),
                      ),
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                         color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text("Sign in with Google", style: TextStyle(color: Colors.black),),
                      //  child: Text("Sign in with Google", style: simpletextfield(),),
                      ),
                    ),
                  Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?", style: mediumtextfield(),),
                        GestureDetector(
                          onTap: (){
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("Register now",style: TextStyle(color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline),),
                          ),
                        )
                      ],
                    )
                  ),
SizedBox(height: 60,)
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
