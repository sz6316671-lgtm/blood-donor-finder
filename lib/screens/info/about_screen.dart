import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../main_wrapper.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Icon(Icons.bloodtype, size: 100, color: AppColors.primaryRed),
              const SizedBox(height: 15),
              const Text(
                "Uni Blood Donor",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const Text("Version 1.0.0", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 40),

              const Text(
                "This application is a dedicated platform for university students to connect blood donors with those in urgent need. Our mission is to ensure no medical emergency goes unanswered within our campus community.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
              ),

              const SizedBox(height: 50),
              const Divider(),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryRed.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.primaryRed.withOpacity(0.1)),
                ),
                child: const Column(
                  children: [
                    Text("Developed By", style: TextStyle(color: Colors.grey, fontSize: 13)),
                    SizedBox(height: 8),
                    Text(
                        "Ali Ahmed",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryRed)
                    ),
                    Text(
                      "BS Software Engineering\nSuperior University, Lahore",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Text(
                "© 2026 Uni Blood Donor. All Rights Reserved.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}