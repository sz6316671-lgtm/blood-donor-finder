import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  // Dummy Data ko State mein le aaye taake change kar saken
  final List<Map<String, String>> myRequests = [
    {"blood": "B+", "hospital": "Jinnah Hospital", "date": "12 April 2026", "status": "Pending"},
    {"blood": "O-", "hospital": "Mayo Hospital", "date": "05 March 2026", "status": "Completed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("My Blood Requests", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        centerTitle: true,
      ),
      body: myRequests.isEmpty
          ? const Center(child: Text("You haven't posted any requests yet."))
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: myRequests.length,
        itemBuilder: (context, index) {
          final req = myRequests[index];
          bool isCompleted = req['status'] == "Completed";

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: isCompleted ? Colors.green : AppColors.primaryRed,
                        child: Text(req['blood']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(req['hospital']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("Posted on: ${req['date']}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isCompleted ? Colors.green.shade50 : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          req['status']!,
                          style: TextStyle(
                            color: isCompleted ? Colors.green : Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // 1. Mark Resolved Logic
                      if (!isCompleted)
                        TextButton.icon(
                          onPressed: () {
                            // setState screen ko refresh karta hai
                            setState(() {
                              myRequests[index]['status'] = "Completed";
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Request marked as Completed!")),
                            );
                          },
                          icon: const Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
                          label: const Text("Mark Resolved", style: TextStyle(color: Colors.green)),
                        ),
                      const SizedBox(width: 10),
                      // 2. Delete Logic
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            myRequests.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Request Deleted"), backgroundColor: Colors.red),
                          );
                        },
                        icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                        label: const Text("Delete", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}