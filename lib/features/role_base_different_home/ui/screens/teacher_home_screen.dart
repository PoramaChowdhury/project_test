import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/ai/ui/screens/ai_screen.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider_image.dart';
import 'package:project/features/home/ui/widgets/drawer_widgets.dart';
import 'package:project/features/home/ui/widgets/grid_view_item.dart';
import 'package:project/features/home/ui/widgets/home_app_bar.dart';
import 'package:project/features/home/ui/widgets/home_section_header.dart';
import 'package:project/features/student/ui/screens/route_select.dart';



class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  static const String name = '/teacher_home-screen';

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
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
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 5,
                ),
                itemCount: 2,
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
                        icon: Lottie.asset(AssetsPath.aiIcon),
                        label: 'Ai',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AiScreen()));
                        },
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomCarouselSliderImage(),
              /*const SizedBox(height: 16),
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
              ),*/
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
