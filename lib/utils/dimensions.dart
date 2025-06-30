// import 'package:get/get.dart';

// class Dimensions {
//   static double screenHeight = Get.context!.height;
//   static double screenWidth = Get.context!.width;

//   // PageView
//   static double pageView = screenHeight / 2.64;
//   static double pageViewContainer = screenHeight / 3.84;
//   static double pageViewTextContainer = screenHeight / 7.03;

//   // Dynamic height padding and margin
//   static double height5 = screenHeight / 168.8;
//   static double height10 = screenHeight / 84.4;
//   static double height15 = screenHeight / 56.27;
//   static double height20 = screenHeight / 42.2;
//   static double height25 = screenHeight / 33.76;
//   static double height30 = screenHeight / 28.13;
//   static double height45 = screenHeight / 18.76;
//   static double height60 = screenHeight / 14.07;

//   // Dynamic width padding and margin
//   static double width5 = screenWidth / 168.8;
//   static double width10 = screenWidth / 84.4;
//   static double width15 = screenWidth / 56.27;
//   static double width20 = screenWidth / 42.2;
//   static double width25 = screenWidth / 33.76;
//   static double width30 = screenWidth / 28.13;
//   static double width45 = screenWidth / 18.76;
//   static double width60 = screenWidth / 14.07;

//   // Font sizes
//   static double font12 = screenHeight / 70.33;
//   static double font14 = screenHeight / 60.29;
//   static double font16 = screenHeight / 52.75;
//   static double font18 = screenHeight / 46.89;
//   static double font20 = screenHeight / 42.2;
//   static double font24 = screenHeight / 35.15;
//   static double font26 = screenHeight / 32.46;
//   static double font30 = screenHeight / 28.13;

//   // Radius
//   static double radius5 = screenHeight / 168.8;
//   static double radius10 = screenHeight / 84.4;
//   static double radius15 = screenHeight / 56.27;
//   static double radius20 = screenHeight / 42.2;
//   static double radius25 = screenHeight / 33.76;
//   static double radius30 = screenHeight / 28.13;

//   // Icon Sizes
//   static double iconSize12 = screenHeight / 70.33;
//   static double iconSize16 = screenHeight / 52.75;
//   static double iconSize20 = screenHeight / 42.2;
//   static double iconSize24 = screenHeight / 35.15;
//   static double iconSize30 = screenHeight / 28.13;

//   // ListView sizes
//   static double listViewImgSize = screenWidth / 3.25;
//   static double listViewTextContSize = screenWidth / 3.9;

//   // Popular Coffee
//   static double popularCoffeeImgSize = screenHeight / 2.41;

//   // Bottom bar height
//   static double bottomHeightBar = screenHeight / 7.03;

//   // Button sizes
//   static double buttonHeight = screenHeight / 14.07;
//   static double buttonWidth = screenWidth / 2.5;

//   // App Bar
//   static double appBarHeight = screenHeight / 12.5;

//   // Spacing
//   static double spacing5 = screenHeight / 168.8;
//   static double spacing10 = screenHeight / 84.4;
//   static double spacing15 = screenHeight / 56.27;
//   static double spacing20 = screenHeight / 42.2;

//   // Widget specific
//   static double cardHeight = screenHeight / 4.5;
//   static double cardWidth = screenWidth / 2.8;

//   // Avatar size
//   static double avatarSize = screenHeight / 10;

//   // General widget sizes
//   static double imageSizeSmall = screenWidth / 6;
//   static double imageSizeMedium = screenWidth / 4;
//   static double imageSizeLarge = screenWidth / 2.5;
// }
import 'package:flutter/material.dart';

class Dimensions {
  final double screenHeight;
  final double screenWidth;

  Dimensions(BuildContext context)
      : screenHeight = MediaQuery.of(context).size.height,
        screenWidth = MediaQuery.of(context).size.width;

  // Dynamic height padding and margin
  double get height5 => screenHeight / 168.8;
  double get height10 => screenHeight / 84.4;
  double get height15 => screenHeight / 56.27;
  double get height20 => screenHeight / 42.2;
  double get height30 => screenHeight / 28.13;
  double get height45 => screenHeight / 18.76;

  // Dynamic width padding and margin
  double get width5 => screenWidth / 168.8;
  double get width10 => screenWidth / 84.4;
  double get width15 => screenWidth / 56.27;
  double get width20 => screenWidth / 42.2;
  double get width30 => screenWidth / 28.13;

  // Font sizes
  double get font20 => screenHeight / 42.2;
  double get font26 => screenHeight / 32.46;

  // Radius
  double get radius15 => screenHeight / 56.27;
  double get radius20 => screenHeight / 42.2;
  double get radius30 => screenHeight / 28.13;

  // Icon sizes
  double get iconSize24 => screenHeight / 35.15;
  double get iconSize16 => screenHeight / 52.75;

  // List view size
  double get listViewImgSize => screenWidth / 3.25;
  double get listViewTextContSize => screenWidth / 3.9;

  // Popular image size
  double get popularCoffeeImgSize => screenHeight / 2.41;

  // Bottom height
  double get bottomHeightBar => screenHeight / 7.03;

  // Custom size calculation
  double customHeight(double ratio) => screenHeight / ratio;
  double customWidth(double ratio) => screenWidth / ratio;
}
