import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تغيير كلمة المرور",
          style: TextStyle(color: Color(0xFFFFB300)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Current Password
                _buildPasswordField(
                  controller: _currentPasswordController,
                  label: "كلمة المرور الحالية",
                  obscureText: _obscureCurrentPassword,
                  onToggleVisibility: () => setState(() {
                    _obscureCurrentPassword = !_obscureCurrentPassword;
                  }),
                ),
                SizedBox(height: 16.h),

                // New Password
                _buildPasswordField(
                  controller: _newPasswordController,
                  label: "كلمة المرور الجديدة",
                  obscureText: _obscureNewPassword,
                  onToggleVisibility: () => setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور الجديدة';
                    }
                    if (value.length < 6) {
                      return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Confirm New Password
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: "تأكيد كلمة المرور الجديدة",
                  obscureText: _obscureConfirmPassword,
                  onToggleVisibility: () => setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  }),
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return 'كلمات المرور غير متطابقة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.h, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                    ),
                    child: Text(
                      "حفظ التغييرات",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid - you can add your database logic here later
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم تغيير كلمة المرور بنجاح")),
      );
      Navigator.pop(context);
    }
  }
}
