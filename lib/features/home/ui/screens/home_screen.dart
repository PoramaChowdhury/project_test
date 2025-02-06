/*

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project/features/common/controller/main_bottom_nav_controller.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider.dart';
import 'package:project/features/home/ui/widgets/drawer_widgets.dart';
import 'package:project/features/home/ui/widgets/grid_view_item.dart';
import 'package:project/features/home/ui/widgets/home_app_bar.dart';
import 'package:project/features/student/student_assistant/cgpa.dart';
import 'package:project/features/student/transportation/ui/screens/bus_locator_and_seat_book.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainBottomNavBarController _bottomNavbarController = Get.put(MainBottomNavBarController());

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First item in Row
                  Container(
                    width: (MediaQuery.of(context).size.width - 64) / 3,
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GridViewItem(
                      icon: Icons.bus_alert,
                      label: 'Transport',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BusLocatorAndSeatBook(),
                          ),
                        );
                      },
                      color: Colors.teal,
                    ),
                  ),
                  // Second item in Row
                  Container(
                    width: (MediaQuery.of(context).size.width - 64) / 3,  // Adjust width for 3 items per row
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: GridViewItem(
                      icon: Icons.person,
                      label: 'Student Assistant',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CgpaCalculatorWithUid(),
                          ),
                        );
                      },
                      color: Colors.blue,
                    ),
                  ),
                  // Third item in Row
                  Container(
                    width: (MediaQuery.of(context).size.width - 64) / 3,  // Adjust width for 3 items per row
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GridViewItem(
                      icon: Icons.bus_alert,
                      label: 'Department Information',
                      onTap: () {},
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First item in Row
                  Container(
                    width: (MediaQuery.of(context).size.width - 64) / 3,  // Adjust width for 3 items per row
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GridViewItem(
                      icon: Icons.bus_alert,
                      label: 'Guidance For Newbie',
                      onTap: () {},
                      color: Colors.orange,
                    ),
                  ),
                  // Second item in Row
                  Container(
                    width: (MediaQuery.of(context).size.width - 64) / 3,  // Adjust width for 3 items per row
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: GridViewItem(
                      icon: Icons.bus_alert,
                      label: 'Resource',
                      onTap: () {},
                      color: Colors.red,
                    ),
                  ),
                  // Third item in Row
                  Container(
                    width: (MediaQuery.of(context).size.width - 64) / 3,  // Adjust width for 3 items per row
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GridViewItem(
                      icon: Icons.bus_alert,
                      label: 'Pc/Laptop Suggestion',
                      onTap: () {},
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _bottomNavbarController.selectedIndex,
        height: 60.0,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF008080),
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.account_box_outlined, size: 30, color: Colors.white),
          Icon(Icons.fitness_center_sharp, size: 30, color: Colors.white),
        ],
        onTap: _bottomNavbarController.changeIndex,
      ),
    );
  }
}*/

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/account/ui/screens/profile_screen.dart';
import 'package:project/features/ai/ui/screens/ai_bottom_nav_screen.dart';
import 'package:project/features/ai/ui/screens/ai_screen.dart';
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

// 'package:project/features/student/transportation/ui/screens/route_select.dart';
// import 'package:project/features/student/transportation/ui/screens/seat_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// todo katsi nav bar

  int _currentIndex = 0;

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
                itemCount: 6,
                // Total items to display
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.busIcon,
                            height: 70, width: 70),
                        label: 'Bus Locator',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectRoutesScreen(),
                            ),
                          );
                        },
                      );
                    case 1:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.seat,
                            height: 70, width: 70),
                        label: 'Seat Booking',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeatBookingScreen(),
                            ),
                          );
                        },
                      );
                    case 2:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.studentIcon,
                            height: 70, width: 70),
                        label: 'Cgpa',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CgpaCalculatorWithUid(),
                            ),
                          );
                        },
                      );
                    case 3:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.fee),
                        label: 'Semester Fee',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SemesterFeeCalculator(),
                            ),
                          );
                        },
                      );
                    case 4:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.aiIcon),
                        label: 'Ai',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AiScreen()));
                        },
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomCarouselSliderImage(),
              const SizedBox(height: 16),
              const HomeSectionHeader(
                title: 'Information',
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
                itemCount: 6,
                // Total items to display
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.teacherIcon),
                        label: 'Teacher Info',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const TeacherInfoListScreen()));

                        },
                      );
                    case 1:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.pcInfo),
                        label: 'PcSuggestion',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PcSuggestionScreen()));
                        },
                      );
                    case 2:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.busIcon),
                        label: 'Alumni Info',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AlumniListScreen()));
                        },
                      );
                    case 3:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.busIcon),
                        label: 'Achievement',
                        onTap: () {},
                      );
                    case 4:
                      return GridViewItem(
                        icon: Lottie.asset(AssetsPath.busIcon),
                        label: 'Resource',
                        onTap: () { },
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
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
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }

  void _onNavBarTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      // Handle Home or do nothing if it's the current screen
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AiBottomNavScreen(),
        ),
      );
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
  }
}
