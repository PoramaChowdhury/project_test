import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/app/asset_path.dart';

class PcCarouselSliderImage extends StatefulWidget {
  @override
  State<PcCarouselSliderImage> createState() => _PcCarouselSliderImageState();
}

class _PcCarouselSliderImageState extends State<PcCarouselSliderImage> {
  final List<CarouselItemImage> items = [
    CarouselItemImage(
      image: AssetsPath.pcOne, // Replace with your image asset path
    ),
    CarouselItemImage(
      image: AssetsPath.pcTwo, // Replace with your image asset path
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: items.map((item) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.09)
                    : Colors.teal.withOpacity(0.09),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display only images
                    Expanded(
                      child: Image.asset(
                        item.image,
                        width: double.infinity,
                        height: 150, // Fixed height
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 150,
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

class CarouselItemImage {
  final String image;

  CarouselItemImage({required this.image});
}
