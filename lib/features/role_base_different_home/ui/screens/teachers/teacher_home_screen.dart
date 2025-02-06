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
import 'package:project/features/role_base_different_home/ui/screens/teachers/teacher_profile_screen.dart';
import 'package:project/features/role_base_different_home/ui/widget/role_base_bottom_nav_bar.dart';
import 'package:project/features/student/ui/screens/route_select.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  static const String name = '/teacher_home-screen';

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  /// todo katsi nav bar

  int _currentIndexRoleBase = 0;

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

      bottomNavigationBar: RoleBaseBottomNavBarWidget(
        currentIndexRoleBase: _currentIndexRoleBase,
        onNavBarTappedRoleBase: onNavBarTappedRoleBase,
      ),
    );
  }

  void onNavBarTappedRoleBase(int index) async {
    setState(() {
      _currentIndexRoleBase = index;
    });

    if (index == 0) {

    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TeacherProfileScreen()),
      );
    }
  }
}
