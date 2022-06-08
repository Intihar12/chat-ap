import 'package:chat_ap/helper/constant.dart';
import 'package:chat_ap/services/database.dart';
import 'package:chat_ap/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'conversationscreen.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController Searchcontroller= new TextEditingController();
  DtabaseMethods databaseMethods =DtabaseMethods();
 QuerySnapshot <Map<String, dynamic>>? searchSnapshot;


  initiatesearch(){
    databaseMethods.getuserbyusername(Searchcontroller.text).then((val){
      print(val.toString());
      setState(() {
        searchSnapshot=val;
      });
  }
    );}



  creatChatRoomAndStartConversation(String userName){
    if(userName !=Constants.myName){
      String chatroomid= getChatRoomId(userName,Constants.myName);
      List<String> users=[userName,Constants.myName];
      Map<String, dynamic>chatroomMap={
        "users": users,
        "chatroomid": chatroomid,
      };
      DtabaseMethods().createchateRoom(chatroomid,chatroomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen()));
    }else{
      print("you can not to message your self");
    }
  }


  Widget searchTile({required String username, required String useremail}){
     return Container(
       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
       child: Row(
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(username.toString() ,style: simpletextfield(),),
               Text(useremail.toString(), style: simpletextfield(),)
             ],),
           Spacer(),
           GestureDetector(
             onTap: (){
               creatChatRoomAndStartConversation( username);
             },
             child: Container(
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(40),
                   color: Colors.blue
               ),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
               child: Text("Message", style: TextStyle(color: Colors.white),),
             ),
           )
         ],),
     );
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        itemCount:searchSnapshot?.docs.length ,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return searchTile(
            username: (searchSnapshot!.docs[index].data() as Map)['name'],

            useremail: (searchSnapshot!.docs[index].data() as Map)['email'],

            //  username: searchSnapshot.docs[index].data().name ,
            //   useremail: searchSnapshot!.docs[index].data["email"],
          );
        }
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Image.asset("assets/images/logo.png",height: 50,),),
      body: Container(
        child: Column(children: [
          Container(
            color: Color(0x54FFFFFF),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
            child: Row(children: [
              Expanded(
              child:  TextField(
                controller: Searchcontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "search ...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none
                ),
              )
              ),
              GestureDetector(
                onTap: (){
                 initiatesearch();


                },
                child: Container(
                  height: 40,
                    width: 40,
                    padding: EdgeInsets.all(10),
decoration: BoxDecoration(gradient: LinearGradient(
  colors: [
    Color(0x36FFFFFF),
    Color(0x0FFFFFFF)
  ]
),
  borderRadius: BorderRadius.circular(40)

),
                    child: Image.asset("assets/images/search_white.png")),
              ),
            ],),
          ),

          searchList(),
        ],),
      ),
    );
  }
}







getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}