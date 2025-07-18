import 'package:books/core/constants/app_breakponts.dart';
import 'package:flutter/material.dart';

bool isMobile(BuildContext context) =>
    MediaQuery.of(context).size.width < AppBreakpoints.mobile;

bool isTablet(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width >= AppBreakpoints.mobile && width < AppBreakpoints.desktop;
}

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= AppBreakpoints.desktop &&
    MediaQuery.of(context).size.width < AppBreakpoints.largeDesktop;

bool isUltraWide(BuildContext context) =>
    MediaQuery.of(context).size.width >= AppBreakpoints.largeDesktop;
