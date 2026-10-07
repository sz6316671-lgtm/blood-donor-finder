import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/my_button.dart';
import '../main_wrapper.dart';
import 'login_screen.dart';
import '../../database/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  String _selectedBloodGroup = 'A+';
  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _deptController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {

      Map<String, dynamic> userData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'dept': _deptController.text,
        'bloodGroup': _selectedBloodGroup,
        'phone': _phoneController.text,
        'password': _passwordController.text,
      };

      try {

        await DBHelper().registerUser(userData);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', _nameController.text.trim());
        await prefs.setString('userEmail', _emailController.text.trim());
        await prefs.setString('userBlood', _selectedBloodGroup);
        await prefs.setString('userDept', _deptController.text.trim());
        await prefs.setBool('isLoggedIn', true);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account Created Successfully!")),
          );


          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainWrapper()),
                (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: Email already exists or DB issue")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text("Create Account",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryRed)),
                const SizedBox(height: 25),

                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                  validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email Address", border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                  validator: (value) => value!.isEmpty || !value.contains('@') ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _deptController,
                  decoration: const InputDecoration(
                      labelText: "Department",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work)
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter your department' : null,
                ),
                const SizedBox(height: 15),

                const Text("Select Blood Group:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: _bloodGroups.map((group) {
                    return ChoiceChip(
                      label: Text(group),
                      selected: _selectedBloodGroup == group,
                      selectedColor: AppColors.primaryRed,
                      labelStyle: TextStyle(
                        color: _selectedBloodGroup == group ? Colors.white : Colors.black,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedBloodGroup = group;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "Phone Number", border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone)),
                  validator: (value) => value!.length < 11 ? 'Enter valid phone' : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                  validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
                ),
                const SizedBox(height: 30),


                MyButton(
                  title: "Register",
                  onTap: _handleSignUp,
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen())
                        );
                      },
                      child: const Text("Login",
                          style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}