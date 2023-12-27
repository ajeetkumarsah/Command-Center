import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;
  const CustomLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: color ?? AppColors.primary,
      ),
    );
  }
}
