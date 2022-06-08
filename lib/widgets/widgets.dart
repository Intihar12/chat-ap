
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context ){

  return AppBar(
    title:  Image.asset("asstes/images/logo.png", height: 50,),
  );
}

InputDecoration TextFieldInputDecoration(String hintText){
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white,width: 2.0),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );
}

TextStyle simpletextfield(){
  return  TextStyle(
    color: Colors.white,
    fontSize: 16
  );
}
TextStyle mediumtextfield(){
  return  TextStyle(
      color: Colors.white,fontSize: 17
  );
}