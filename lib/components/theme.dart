import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/constants.dart';

class AppTheme {
  AppTheme(this.context);

  BuildContext context;

  ThemeData initTheme() {
    return ThemeData(
      primarySwatch: createMaterialColor(Color.fromARGB(255, 209, 148, 245)),
      primaryColor: kPrimaryColor,
      //   buttonColor: AppColor.kPrimaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(0, 0.h),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
          ),
          foregroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          backgroundColor: MaterialStateProperty.all(
            kPrimaryLightColor,
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            const StadiumBorder(),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            kPrimary2,
          ),
          minimumSize: MaterialStateProperty.all(
            Size(0, 56.h),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: kPrimaryLightColor,
            ),
          ),
        ),
      ),

      // textTheme: TextTheme(
      //   headline1: GoogleFonts.notoSans(
      //     fontSize: 32.sp,
      //     color: AppColor.kTitle,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   headline2: GoogleFonts.notoSans(
      //     fontSize: 32.sp,
      //     color: AppColor.kTitle,
      //   ),
      //   headline3: GoogleFonts.notoSans(
      //     fontSize: 24.sp,
      //     color: AppColor.kTitle,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   headline4: GoogleFonts.notoSans(
      //     fontSize: 24.sp,
      //     color: AppColor.kTitle,
      //   ),
      //   headline5: GoogleFonts.notoSans(
      //     fontSize: 20.sp,
      //     color: AppColor.kTitle,
      //   ),
      //   headline6: GoogleFonts.notoSans(
      //     fontSize: 16.sp,
      //     color: AppColor.kTitle,
      //   ),
      //   bodyText1: GoogleFonts.notoSans(
      //     fontSize: 12.sp,
      //     color: AppColor.kTitle,
      //   ),
      //   bodyText2: GoogleFonts.notoSans(
      //     fontSize: 14.sp,
      //     color: AppColor.kTitle,
      //   ),
      // ),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    ;
    return MaterialColor(color.value, swatch);
  }
}
