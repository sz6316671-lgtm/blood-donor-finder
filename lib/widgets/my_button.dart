import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MyButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.primaryRed,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}