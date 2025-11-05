import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtons extends StatelessWidget {
  final Widget child;
  final Color? buttonColor;
  final double border;
  const CustomButtons({
    super.key,
    required this.child,
    this.buttonColor,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: border),
        borderRadius: BorderRadius.circular(21.r),
        color: buttonColor ?? Colors.transparent,
      ),
      child: Padding(padding: EdgeInsets.all(10.0.sp), child: child),
    );
  }
}
