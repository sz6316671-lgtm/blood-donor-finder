import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../auth/login_screen.dart';
import 'edit_profile_screen.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import 'faq_screen.dart';
import 'change_password_screen.dart';

import 'terms_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userName = "Loading...";
  String userEmail = "Loading...";
  String userBlood = "--";
  String userDept = "--";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }


  Future<void> _loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? "User";
      userEmail = prefs.getString('userEmail') ?? "Not Available";
      userBlood = prefs.getString('userBlood') ?? "N/A";
      userDept = prefs.getString('userDept') ?? "N/A";
    });
  }

  // Logout handle karne ka function
  Future<void> _handleLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear session data
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Top Header Section (Dynamic)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: AppColors.primaryRed.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),


                  Text(
                    userName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Info Cards Section (Dynamic)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _infoCard(Icons.bloodtype, "Blood", userBlood),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _infoCard(Icons.school, "Dept", userDept),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(),

            // 3. Action Menu
            _buildListTile(Icons.edit, "Edit Profile Information", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
            }),


            _buildListTile(Icons.lock_outline, "Change Password", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
            }),
            const Divider(),
            _buildListTile(Icons.info_outline, "About App", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            }),

            _buildListTile(Icons.question_answer_outlined, "FAQs", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FAQScreen()));
            }),
            _buildListTile(Icons.security, "Privacy Policy", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
            }),
            _buildListTile(Icons.description_outlined, "Terms & Conditions", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsScreen()));
            }),

            // Logout ListTile
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout Account", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: _handleLogout,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper for ListTiles to keep code clean
  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryRed),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryRed),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}