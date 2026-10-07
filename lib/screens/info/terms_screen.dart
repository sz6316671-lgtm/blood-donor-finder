import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> termsData = [
      {
        "title": "1. User Responsibility",
        "desc": "Users must provide authentic information regarding their blood group and contact details. Misleading information can lead to account suspension."
      },
      {
        "title": "2. No Medical Advice",
        "desc": "This app is a communication tool only. All medical procedures and blood testing must be conducted at authorized healthcare facilities."
      },
      {
        "title": "3. Privacy & Safety",
        "desc": "By posting a request, you agree to share your contact number with potential donors. We are not responsible for interactions outside the app."
      },
      {
        "title": "4. Termination",
        "desc": "The administration reserves the right to remove any request or user that violates university code of conduct or app policies."
      },
      {
        "title": "5. Data Usage",
        "desc": "Your data is used only for matching donors with seekers within the university community."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Agreement to Terms",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryRed),
            ),
            const SizedBox(height: 20),


            ...termsData.map((term) => _buildTermItem(
              title: term['title']!,
              description: term['desc']!,
            )),

            const SizedBox(height: 20),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "By using this app, you agree to all the terms mentioned above.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTermItem({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.black87, height: 1.5, fontSize: 14),
          ),
        ],
      ),
    );
  }
}