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
    return null;
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
    return null;
  }
    Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent, {required Null Function(FirebaseAuthException e) verificationFailed}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithPhoneNumber(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(credential);
  }
}


