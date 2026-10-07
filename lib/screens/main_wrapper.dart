import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/bottom_nav.dart';
import 'donor/donor_dashboard.dart';
import 'seeker/search_donor_screen.dart';
import 'info/profile_screen.dart';


class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;


  final List<Widget> _screens = [
    const DonorDashboard(),
    const SearchDonorScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryRed,
        title: const Text("Uni Blood Donor", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        actions: [
         /* // Bell icon se Notifications screen khulegi
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                );
              },
              icon: const Icon(Icons.notifications, color: Colors.white)
          ) */
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}