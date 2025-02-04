import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/app/asset_path.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key, this.width, this.height, this.boxFit,
  });

  final double? width;
  final double? height;
  final BoxFit? boxFit;

  // Get the current theme's brightness


  @override
  Widget build(BuildContext context) {

    Brightness brightness = Theme.of(context).brightness;

    // Determine which logo to show based on the theme
    String logoAsset = brightness == Brightness.light
        ? AssetsPath.appLightLogoSvg  // For light theme
        : AssetsPath.appDarkLogoSvg;  // For dark theme


    return SvgPicture.asset(logoAsset,
      // width: width ?? 120,
      // height: height ?? 120,
      fit: boxFit ?? BoxFit.scaleDown,
    );
  }
}



class AuthAppLogoWidget extends StatelessWidget {
  const AuthAppLogoWidget({
    super.key, this.width, this.height, this.boxFit,
  });

  final double? width;
  final double? height;
  final BoxFit? boxFit;

  // Get the current theme's brightness


  @override
  Widget build(BuildContext context) {

    Brightness brightness = Theme.of(context).brightness;

    // Determine which logo to show based on the theme
    String logoAsset = brightness == Brightness.light
        ? AssetsPath.authLightLogo  // For light theme
        : AssetsPath.authDarkLogo;  // For dark theme


    return SvgPicture.asset(logoAsset,
      width: width ?? 120,
      height: height ?? 120,
      fit: boxFit ?? BoxFit.scaleDown,
    );
  }
}