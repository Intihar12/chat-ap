import 'package:chat_ap/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth _auth= FirebaseAuth.instance;

  Users? _userfromfirebaseUser(User user){
    return user != null ? Users(userid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential  result=await _auth.signInWithEmailAndPassword(email: email, password: password);
User? firebaseUser = result.user;
return _userfromfirebaseUser(firebaseUser!);
    }catch(e){
      print(e.toString());
    }
  }


  Future signUpWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
   User? firebaseuUser= result.user;
return _userfromfirebaseUser(firebaseuUser!);
    }catch(e){
      print(e.toString());
    }
  }

  Future resetPass(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }
  Future signout()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}

