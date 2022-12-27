import 'package:firebase_auth/firebase_auth.dart';

class FireAuth{
static Future<User?> signInUsingEmailPassword({
required String email,
required String password,
})
  async{
  FirebaseAuth auth =FirebaseAuth.instance;
  User ?user;
  try{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    user = userCredential.user;

  }
  on FirebaseAuthException catch(e){
    if(e.code=='user-not-found'){
      print('No user found this email');
    }else if(e.code == 'wrong-password'){
      print('Wrong password');
    }
  }
return user;
  }

  static Future<User?> registerUsingEmailPassword({
  required String name,
    required String email,
    required String password,
    required String phone,
})
  async{
  FirebaseAuth auth =FirebaseAuth.instance;
  User ?user;
  try{
    UserCredential userCredential =await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    user =userCredential.user;
    await user!.reload();
    user = auth.currentUser;
  }
on FirebaseAuthException catch(e){
    if(e.code == 'weak-password'){
      print('Password is week');
    }else if(e.code == 'email-already-taken'){
      print('the account already exist');
    }
}catch(e){
    print(e);
  }
  return user;
  }
}