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

          final phoneQuery = await _firestore
        .collection(isDriver ? 'driverdata' : 'userdata')
        .where('phone', isEqualTo: phone)
        .get();

    if (phoneQuery.docs.isNotEmpty) {
      throw FirebaseAuthException(
        code: 'phone-already-in-use',
        message: 'رقم الهاتف مسجل مسبقاً. يرجى استخدام رقم آخر.',
      );
    }
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // إنشاء مستند في Firestore
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
        throw Exception('كلمة المرور ضعيفة. يرجى اختيار كلمة مرور أقوى.');
      } else if (e.code == 'phone-already-in-use') {
        throw Exception(
            'رقم الهاتف مسجل مسبقاً. يرجى استخدام رقم آخر.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception(
            'البريد الإلكتروني مسجل مسبقاً. يرجى استخدام بريد آخر.');
      } else if (e.code == 'invalid-email') {
        throw Exception('صيغة البريد الإلكتروني غير صحيحة.');
      } else {
        throw Exception('حدث خطأ أثناء التسجيل: ${e.message}');
      }
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('المستخدم غير موجود. يرجى التحقق من البريد الإلكتروني.');
      } else if (e.code == 'wrong-password') {
        throw Exception('كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.');
      } else {
        throw Exception('حدث خطأ أثناء تسجيل الدخول: ${e.message}');
      }
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
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
