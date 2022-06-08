
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class DtabaseMethods{
  getuserbyusername(String username)async{
return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo : username).get();
  }

  getuserbyuserEmail(String useremail)async{
    return await FirebaseFirestore.instance.collection("users").where("email", isEqualTo : useremail).get();
  }
  uploadUserInfo(usersMap){
    FirebaseFirestore.instance.collection("users").add(usersMap);
  }

  createchateRoom(String chatroomid,  chatrooMap){
    FirebaseFirestore.instance.collection("ChatRoomm").doc(chatroomid).set(chatrooMap).catchError((e){
      print(e.toString());
    });

  }
}