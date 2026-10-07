import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Privacy Matters",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryRed),
            ),
            const SizedBox(height: 10),
            const Text(
              "Last Updated: April 2026",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 25),

            _buildPolicySection(
                "1. Information Collection",
                "We collect your name, blood group, department, and contact number to facilitate blood donation requests within the university."
            ),
            _buildPolicySection(
                "2. How We Use Data",
                "Your contact information is only visible to registered users who are searching for donors or responding to emergency blood requests."
            ),
            _buildPolicySection(
                "3. Data Security",
                "We take reasonable measures to protect your personal information from unauthorized access or disclosure."
            ),
            _buildPolicySection(
                "4. User Control",
                "You can update your profile information or hide your availability for donation at any time through the profile settings."
            ),

            const SizedBox(height: 30),
            const Center(
              child: Text(
                "For any queries, contact us at:\nsupport.uniblood@university.edu",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
          ),
        ],
      ),
    );
  }
}