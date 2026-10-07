import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../../database/db_helper.dart';
import '../seeker/request_blood_form.dart';

class DonorDashboard extends StatefulWidget {
  const DonorDashboard({super.key});

  @override
  State<DonorDashboard> createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  String userName = "User";
  String userBlood = "--";
  List<Map<String, dynamic>> requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }


  Future<void> _loadAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await DBHelper().getRequests();

    setState(() {
      userName = prefs.getString('userName') ?? "User";
      userBlood = prefs.getString('userBlood') ?? "N/A";
      requests = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryRed,
        onPressed: () async {

          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestBloodForm()));
          if (result == true) _loadAllData();
        },
        label: const Text("Request Blood", style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryRed))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome back,", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text(userName, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your Blood Group: $userBlood", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                        const Icon(Icons.opacity, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Emergency Requests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),


            requests.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(40.0),
              child: Center(child: Text("No requests available yet.")),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final req = requests[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50, width: 50,
                            decoration: const BoxDecoration(color: AppColors.primaryRed, shape: BoxShape.circle),
                            child: Center(child: Text(req['bloodGroup'] ?? '?', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(req['patientName'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                Text(req['hospital'] ?? 'Unknown Hospital', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                          ),

                          if (req['isUrgent'] == 1)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(20)),
                              child: const Text("Urgent", style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      const Divider(height: 25),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(req['phone'] ?? 'No phone', style: const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}