import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        "q": "Kaun khoon (blood) donate kar sakta hai?",
        "a": "18 se 65 saal ki umar ke sehat-mand log jinka wazan 50kg se zyada ho."
      },
      {
        "q": "Main kitni baar donate kar sakta hoon?",
        "a": "Aap har 3 se 4 mahine (90-120 din) baad khoon donate kar sakte hain."
      },
      {
        "q": "Kya blood donation mehfooz (safe) hai?",
        "a": "Ji haan, har donor ke liye nayi aur saaf suhri suiyan (needles) istemal hoti hain."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: faqs.length,
        itemBuilder: (context, index) {

          return _buildFAQItem(
            question: faqs[index]['q']!,
            answer: faqs[index]['a']!,
          );
        },
      ),
    );
  }


  Widget _buildFAQItem({required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        iconColor: AppColors.primaryRed,
        collapsedIconColor: Colors.grey,
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(
              answer,
              style: const TextStyle(
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}