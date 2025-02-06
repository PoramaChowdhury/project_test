import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/driver/ui/screens/map_screen.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider_image.dart';
import 'package:project/features/home/ui/widgets/drawer_widgets.dart';
import 'package:project/features/home/ui/widgets/grid_view_item.dart';
import 'package:project/features/home/ui/widgets/home_app_bar.dart';
import 'package:project/features/home/ui/widgets/home_section_header.dart';
import 'package:project/features/role_base_different_home/ui/screens/drivers/driver_profile_screen.dart';
import 'package:project/features/role_base_different_home/ui/widget/role_base_bottom_nav_bar.dart';


class DriverHomeScreen extends StatefulWidget {

  const DriverHomeScreen({super.key});

  static const String name = '/driver_home-screen';

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
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
                            String driverId = FirebaseAuth.instance.currentUser!.uid; // Get the current user's UID
                                ; // This should be the actual driver ID, fetch it from SharedPreferences or Firebase
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(driverId: driverId),  // Pass the driverId here
                              ),
                            );
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
        MaterialPageRoute(builder: (context) => const DriverProfileScreen()),
      );
    }
  }
}
