import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
// instance of auth
final FirebaseAuth _auth=FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? getCurrentUsr(){
  return _auth.currentUser;
}


// signin

Future<UserCredential>signInwithEmailPassword(String email,password)async{
  try{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }on FirebaseAuthException catch (e){
    throw Exception(e.code);
  }
}
// signup
Future<UserCredential> signUpwithemailandPass(String email,password) async{
  try{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
   return userCredential;
  }on FirebaseAuthException catch(e){
    throw Exception(e.code);
  }


}


//signout
Future<void> signOut ()async{
  return await _auth.signOut();
}

//error

}