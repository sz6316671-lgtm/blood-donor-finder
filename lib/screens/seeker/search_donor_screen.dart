import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../database/db_helper.dart';
import 'donor_detail_screen.dart';

class SearchDonorScreen extends StatefulWidget {
  const SearchDonorScreen({super.key});

  @override
  State<SearchDonorScreen> createState() => _SearchDonorScreenState();
}

class _SearchDonorScreenState extends State<SearchDonorScreen> {
  String _selectedGroup = 'B+';
  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  List<Map<String, dynamic>> _donors = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDonors();
  }


  Future<void> _loadDonors() async {
    setState(() => _isLoading = true);

    final data = await DBHelper().searchDonors(_selectedGroup);

    setState(() {
      _donors = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text("Find Donors",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primaryRed)),
            const SizedBox(height: 20),

            const Text("Select Blood Group:", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),


            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _bloodGroups.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedGroup == _bloodGroups[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedGroup = _bloodGroups[index]);
                      _loadDonors();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryRed : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryRed),
                      ),
                      child: Center(
                        child: Text(_bloodGroups[index],
                            style: TextStyle(color: isSelected ? Colors.white : AppColors.primaryRed, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
            Text("Available $_selectedGroup Donors", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),


            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primaryRed))
                  : _donors.isEmpty
                  ? const Center(child: Text("No donors found for this group."))
                  : ListView.builder(
                itemCount: _donors.length,
                itemBuilder: (context, index) {
                  final donor = _donors[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.primaryRed,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(donor['name'] ?? "Unknown"),
                      subtitle: Text(donor['dept'] ?? "Superior University"),
                      trailing: IconButton(
                        icon: const Icon(Icons.info_outline, color: AppColors.primaryRed),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonorDetailScreen(

                                  name: donor['name'],
                                  bloodGroup: donor['bloodGroup'],
                                  phone: donor['phone'],
                                  dept: donor['dept']
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}