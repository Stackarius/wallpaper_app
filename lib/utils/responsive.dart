import 'package:flutter/material.dart';

class Responsive {
  static const double desktopBreakpoint = 1200;
  static const double tabletBreakpoint = 800;

  static int getGridColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= desktopBreakpoint) return 3;
    if (width >= tabletBreakpoint) return 2;
    return 1;
  }

  static double getAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= desktopBreakpoint) return 1.5;
    if (width >= tabletBreakpoint) return 1.3;
    return 1.1;
  }

  static double getGridSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= desktopBreakpoint) return 24;
    if (width >= tabletBreakpoint) return 16;
    return 12;
  }
}
