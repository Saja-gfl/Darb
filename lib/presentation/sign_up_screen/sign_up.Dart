import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserDataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserFormScreen(),
    );
  }
}

// Data Provider class
class UserDataProvider extends ChangeNotifier {
  String username = '';
  String password = '';
  String confirmPassword = '';
  String phone = '';

  void updateUsername(String newUsername) {
    username = newUsername;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void updateConfirmPassword(String newConfirmPassword) {
    confirmPassword = newConfirmPassword;
    notifyListeners();
  }

  void updatePhone(String newPhone) {
    phone = newPhone;
    notifyListeners();
  }
}

// Main UI Screen
class UserFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFFFFF),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 94, left: 31, right: 31),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 121, right: 48),
                        width: 37,
                        height: 35,
                        child: Image(image: AssetImage("lib/assets/images/img5935976241859510486.png")),
                          fit: BoxFit.fill,
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          width: 181,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 122,
                                    width: double.infinity,
                                    child: Image(image: AssetImage("lib/assets/images/img5935976241859510486.png")),
                                      //fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                left: 47,
                                width: 41,
                                height: 20,
                                child: Container(
                                  transform: Matrix4.translationValues(0, 5, 0),
                                  child: Text(
                                    "تسجيل",
                                    style: TextStyle(
                                      color: Color(0xFFFBB03B),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Form Section
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFD9D9D9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFFFFFFF),
                ),
                padding: const EdgeInsets.symmetric(vertical: 38),
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username Field
                    FormField(
                      label: ":اسم المستخدم",
                      onChanged: (value) =>
                          context.read<UserDataProvider>().updateUsername(value),
                    ),
                    // Password Field
                    FormField(
                      label: ":كلمة السر",
                      onChanged: (value) =>
                          context.read<UserDataProvider>().updatePassword(value),
                    ),
                    // Confirm Password Field
                    FormField(
                      label: ":تأكيد كلمة السر",
                      onChanged: (value) => context
                          .read<UserDataProvider>()
                          .updateConfirmPassword(value),
                    ),
                    // Phone Number Field
                    FormField(
                      label: ":رقم الهاتف",
                      onChanged: (value) =>
                          context.read<UserDataProvider>().updatePhone(value),
                    ),
                    // Display User Data Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final provider =
                              context.read<UserDataProvider>();
                          print("اسم المستخدم: ${provider.username}");
                          print("كلمة السر: ${provider.password}");
                          print("تأكيد كلمة السر: ${provider.confirmPassword}");
                          print("رقم الهاتف: ${provider.phone}");
                        },
                        child: Text("عرض البيانات"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Form Field
class FormField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;

  FormField({required this.label, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFF7931E),
              fontSize: 16,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFD9D9D9),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFFFFFFF),
          ),
          margin: const EdgeInsets.only(bottom: 11),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
