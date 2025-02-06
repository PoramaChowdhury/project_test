import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';


class CustomCarouselSlider extends StatefulWidget {
  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final List<CarouselItem> items = [

    CarouselItem(
        animation: AssetsPath.bus,
        title: 'Book Your Seat'
    ),
    CarouselItem(
        animation: AssetsPath.mapWithMarker,
        title: 'Track Your Bus'
    ),
    CarouselItem(
        animation: AssetsPath.student,
        title: 'Student Assistant'
    ),

    CarouselItem(
        animation: AssetsPath.ai,
        title: 'Asked to AI!'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: items.map((item) {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                //color: Colors.teal.withOpacity(0.09),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.09)
                    : Colors.teal.withOpacity(0.09),

                borderRadius: BorderRadius.circular(8),
                // image: DecorationImage(
                //   image: AssetImage(item.image),
                //   fit: BoxFit.cover,
                // ),

              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lottie animation widget
                    Expanded(
                      child: Lottie.asset(
                        item.animation,
                        width: double.infinity, // Set your desired width
                        height: double.infinity, // Set your desired height
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // Increased opacity for dark theme for better visibility
                            : Colors.black,
                       //color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            viewportFraction: 0.95,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              print('Page changed: $index');
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}


class CarouselItem {
  //final String image;
  final String animation;
  final String title;

  CarouselItem({required this.animation, required this.title});
}