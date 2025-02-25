import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServises{
  final _auth = FirebaseAuth.instance;

  Future<User?> signup(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('كلمة المرور ضعيفة');
      } else if (e.code == 'email-already-in-use') {
        print('الحساب مسجل مسبقاً');
      }
    } catch (e) {
      print(e); 
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential Credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
     
      return Credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print('ايميل او كلمة مرور خاطئة');
      } else {
        print('An error occurred: ${e.code}');
      }
    } catch (e) {
      print(e);
    }
  }
}

// باقي sign out