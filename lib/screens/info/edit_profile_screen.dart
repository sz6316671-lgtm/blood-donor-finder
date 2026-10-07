import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../database/db_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _deptController = TextEditingController();
  String _userEmail = "";

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }


  Future<void> _loadCurrentData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('userEmail') ?? "";
      _nameController.text = prefs.getString('userName') ?? "";
      _phoneController.text = prefs.getString('userPhone') ?? "";
      _deptController.text = prefs.getString('userDept') ?? "";
    });
  }


  Future<void> _updateProfile() async {
    String newName = _nameController.text.trim();
    String newPhone = _phoneController.text.trim();
    String newDept = _deptController.text.trim();

    if (newName.isEmpty || newPhone.isEmpty || newDept.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields"), backgroundColor: Colors.orange),
      );
      return;
    }


    await DBHelper().updateUserProfile(_userEmail, newName, newPhone, newDept);


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', newName);
    await prefs.setString('userPhone', newPhone);
    await prefs.setString('userDept', newDept);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully!"), backgroundColor: Colors.green),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _deptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primaryRed,
              child: Icon(Icons.edit, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 40),

            // Name Field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person, color: AppColors.primaryRed),
              ),
            ),
            const SizedBox(height: 20),

            // Phone Number Field
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone, color: AppColors.primaryRed),
              ),
            ),
            const SizedBox(height: 20),

            // Department Field
            TextField(
              controller: _deptController,
              decoration: const InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school, color: AppColors.primaryRed),
              ),
            ),
            const SizedBox(height: 40),

            // Save Changes Button
            MyButton(
                title: "Save Changes",
                onTap: _updateProfile
            ),
          ],
        ),
      ),
    );
  }
}