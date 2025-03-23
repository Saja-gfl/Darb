import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FireStore.dart';

class FirebaseAuthServises {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> signup({
     required String email,
    required String password,
    required String username,
    required String address,
    required String phone,
    required bool isDriver,
    String? carType,
    String? plateNumber,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        //create doc in firestore
        FirestoreService().createUserData(
          userId: user.uid,
          nameController: username,
          emailController: email,
          addressController: address,
          phoneController: phone,
          selectedGender: "null",
          isDriver: isDriver,
          carType: carType,
          plateNumber: plateNumber,
        );

      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('كلمة المرور ضعيفة');
      } else if (e.code == 'email-already-in-use') {
        print('الحساب مسجل مسبقاً');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> login(
    String email,
    String password,
  ) async {
    try {
      UserCredential Credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

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

  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent,
      {required Null Function(FirebaseAuthException e)
          verificationFailed}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification  failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(credential);
  }
}
