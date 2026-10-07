import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../database/db_helper.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;


  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('userEmail') ?? "";


      var user = await DBHelper().loginCheck(email, _oldPassController.text.trim());

      if (user == null) {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Current password is incorrect"), backgroundColor: Colors.red),
          );
        }
        return;
      }


      await DBHelper().updatePassword(email, _newPassController.text.trim());

      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Updated Successfully!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update your security",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryRed),
              ),
              const SizedBox(height: 10),
              const Text(
                "Ensure your new password is strong and at least 6 characters long.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),

              _buildPasswordField(
                controller: _oldPassController,
                label: "Current Password",
                validator: (val) => (val == null || val.isEmpty) ? "Enter current password" : null,
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                controller: _newPassController,
                label: "New Password",
                validator: (val) {
                  if (val == null || val.isEmpty) return "Enter new password";
                  if (val.length < 6) return "Password must be 6+ characters";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                controller: _confirmPassController,
                label: "Confirm New Password",
                validator: (val) {
                  if (val != _newPassController.text) return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 40),

              _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primaryRed))
                  : MyButton(
                title: "Update Password",
                onTap: _updatePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryRed),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _isObscure = !_isObscure),
        ),
      ),
      validator: validator,
    );
  }
}