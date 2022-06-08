import 'package:chat_ap/helper/helperfunction.dart';
import 'package:chat_ap/services/auth.dart';
import 'package:chat_ap/services/database.dart';
import 'package:chat_ap/view/chatroomscreen.dart';
import 'package:chat_ap/widgets/widgets.dart';
import 'package:flutter/material.dart';
class signup extends StatefulWidget {
 // const signup({Key? key}) : super(key: key);
final Function toogle;
signup(this.toogle);
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  AuthMethods authMethods= new AuthMethods();
  DtabaseMethods databasemethods=new DtabaseMethods();
  final formkey= GlobalKey<FormState>();
  bool isloading= false;
  TextEditingController usernamecontroller =TextEditingController();
  TextEditingController emailcontroller =TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();
singMeUp()async{
  if(formkey.currentState!.validate()){
    Map<String , String> Userinfomap={
      "name": usernamecontroller.text,
      "email": emailcontroller.text
    };
    HelperFunction.saveUserEmailSharedPreference(emailcontroller.text);
    HelperFunction.saveusernamesheredpreference(usernamecontroller.text);
setState(() {
  isloading=true;
});
await authMethods.signUpWithEmailAndPassword(emailcontroller.text, passwordcontroller.text).then((value) {
////// print("my_catlog" + value));

databasemethods.uploadUserInfo(Userinfomap);
HelperFunction.saveuserLoginsheredpreference(true);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>chatRoom()));
});
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/images/logo.png",height: 50,),),
      body: isloading ? Container(child: Center(child: CircularProgressIndicator()),) : SingleChildScrollView(

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
                 child: Column(children: [
                   TextFormField(
                     validator: (val){
                       return val!.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                     },
                     controller: usernamecontroller,
                     style: simpletextfield(),
                     decoration: TextFieldInputDecoration("username"),
                   ),
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
                     obscureText: true,
                       validator:  (val){
                         return val!.length < 6 ? "Enter Password 6+ characters" : null;
                       },
                       controller: passwordcontroller,
                       style: simpletextfield(),
                       decoration: TextFieldInputDecoration("password")),
                 ],),
               ),
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
                        singMeUp();
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
                        child: Text("Sign up", style: mediumtextfield(),),
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
                      child: Text("Sign up with Google", style: TextStyle(color: Colors.black),),
                      //  child: Text("Sign in with Google", style: simpletextfield(),),
                    ),
                  ),
                  Container(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Allready have account?", style: mediumtextfield(),),
                          GestureDetector(
                            onTap: (){
                              widget.toogle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text("Sign in now",style: TextStyle(color: Colors.white,
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
