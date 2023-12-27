import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  const CustomShimmer(
      {super.key, this.width, this.height, this.borderRadius, this.margin});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200.0,
      height: height ?? 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey[350]!,
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          width: width ?? 200.0,
          height: height ?? 100.0,
        ),
      ),
    );
  }
}
