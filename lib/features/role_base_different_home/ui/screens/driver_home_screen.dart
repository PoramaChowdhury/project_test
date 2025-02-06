import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/account/ui/screens/profile_screen.dart';
import 'package:project/features/ai/ui/screens/ai_screen.dart';
import 'package:project/features/authorities/transport/student_count.dart';
import 'package:project/features/driver/ui/screens/map_screen.dart';
import 'package:project/features/home/ui/widgets/bottom_nav_bar_widget.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider_image.dart';
import 'package:project/features/home/ui/widgets/drawer_widgets.dart';
import 'package:project/features/home/ui/widgets/grid_view_item.dart';
import 'package:project/features/home/ui/widgets/home_app_bar.dart';
import 'package:project/features/home/ui/widgets/home_section_header.dart';
import 'package:project/features/student/alumni_info/ui/screen/alumni_list_screen.dart';
import 'package:project/features/student/pc_suggestion/screen/pc_suggestion_screen.dart';
import 'package:project/features/student/student_assistant/calculatefee/fee.dart';
import 'package:project/features/student/student_assistant/cgpa.dart';
import 'package:project/features/student/teacher_info/ui/screen/teacher_info_list_screen.dart';
import 'package:project/features/student/ui/screens/route_select.dart';
import 'package:project/features/student/ui/screens/seat_booking_screen.dart';



class DriverHomeScreen extends StatefulWidget {

  const DriverHomeScreen({super.key});

  static const String name = '/driver_home-screen';

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  /// todo katsi nav bar

  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomCarouselSlider(),
              const SizedBox(height: 16),
              const HomeSectionHeader(
                title: 'Daily Necessary',
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 5,
                ),
                itemCount: 1,
                // Total items to display
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.busIcon,
                            height: 70, width: 70),
                        label: 'Map',
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => MapScreen(driverId: driverId),
                          //   ),
                          // );
                          /*Navigator.pushNamed(context, MapScreen.name);*/
                        },
                      );

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomCarouselSliderImage(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   // index: _bottomNavbarController.selectedIndex,
      //   height: 60.0,
      //   backgroundColor: Colors.transparent,
      //   color: const Color(0xFF008080),
      //   animationDuration: const Duration(milliseconds: 300),
      //   items: const [
      //     Icon(Icons.home, size: 30, color: Colors.white),
      //     Icon(Icons.account_box_outlined, size: 30, color: Colors.white),
      //     Icon(Icons.fitness_center_sharp, size: 30, color: Colors.white),
      //   ],
      //   // onTap: _bottomNavbarController.changeIndex,
      // ),
      /*bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),*/
    );
  }

/* void _onNavBarTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      // Handle Home or do nothing if it's the current screen
    } else if (index == 1) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const AccountScreen(),
      //   ),
      // );
    } else if (index == 2) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const TrackerScreen()),
      // );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }*/
}
