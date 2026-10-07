import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DonorDetailScreen extends StatelessWidget {
  final String name;
  final String bloodGroup;
  final String phone;
  final String dept;

  const DonorDetailScreen({
    super.key,
    required this.name,
    required this.bloodGroup,
    required this.phone,
    required this.dept,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text("Donor Information", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(dept, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            const SizedBox(height: 20),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      _infoRow(Icons.person, "Full Name", name),
                      const Divider(),
                      _infoRow(Icons.bloodtype, "Blood Type", bloodGroup),
                      const Divider(),
                      _infoRow(Icons.phone, "Contact", phone), // DB Phone
                      const Divider(),
                      _infoRow(Icons.work, "Department", dept), // DB Dept
                      const Divider(),
                      _infoRow(Icons.location_on, "Campus", "Superior University"),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Please respect the donor's privacy and contact only for genuine blood requirements.",
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryRed, size: 24),
          const SizedBox(width: 15),
          Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}