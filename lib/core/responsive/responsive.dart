import 'package:books/core/responsive/breakpoints.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class R {
  static bool mobile() => ScreenUtil().screenWidth < Breakpoints.mobile;
  static bool isDesktopOrTablet() =>
      ScreenUtil().screenWidth >= Breakpoints.mobile;
  static bool tablet() =>
      ScreenUtil().screenWidth >= Breakpoints.mobile &&
      ScreenUtil().screenWidth < Breakpoints.tablet;
  static bool desktop() => ScreenUtil().screenWidth >= Breakpoints.tablet;

  static double value({
    required double mobile,
    required double tablet,
    double? desktop,
  }) {
    if (R.mobile()) return mobile.w;
    if (R.tablet()) return tablet.w;
    return desktop?.w ?? tablet.w;
  }

  static double valueH({
    required double mobile,
    required double tablet,
    double? desktop,
  }) {
    if (R.mobile()) return mobile.h;
    if (R.tablet()) return tablet.h;
    return desktop?.h ?? tablet.h;
  }
}
