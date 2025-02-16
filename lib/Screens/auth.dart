import 'package:firebase_auth/firebase_auth.dart';

class auth1{
  final _auth = FirebaseAuth.instance;

  Future<User?> signingup(String email, String password) async {
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
}

// باقي sign out