import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final bool showBorder;
  final Color? color;
  final BoxFit? fit;
  final Widget? errorWidget;
  final List<BoxShadow>? boxShadow;
  final bool isUser;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.margin,
    this.borderRadius,
    this.border,
    this.color,
    this.fit,
    this.errorWidget,
    this.showBorder = false,
    this.boxShadow,
    this.isUser = false,
    this.padding,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ??
          'https://archive.org/download/no-photo-available/no-photo-available.png',
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: showBorder ? border : null,
          boxShadow: boxShadow,
          color: color ?? Colors.grey[600],
          gradient: gradient,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          border: showBorder ? border : null,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: color ?? Colors.grey[600],
          boxShadow: boxShadow,
        ),
        child: const Center(
          child:
              CircularProgressIndicator(strokeWidth: 0.2, color: Colors.black),
        ),
      ),
      errorWidget: (context, url, error) => isUser
          ? Image.network(
              'https://freeschoolapp.in/assets/img/icon/user-icon.png',
              fit: BoxFit.cover,
              width: width,
              height: height,
            )
          : Container(
              width: width,
              height: height,
              margin: margin,
              padding: padding,
              decoration: BoxDecoration(
                color: color ?? Colors.grey[600] ?? Colors.grey,
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                border: showBorder
                    ? border ??
                        Border.all(
                          color: Colors.black,
                          width: 0.4,
                        )
                    : null,
                boxShadow: boxShadow,
              ),
              child: Center(
                child: errorWidget ??
                    Icon(
                      Icons.error_outline_rounded,
                      color: Colors.grey[600] ?? Colors.grey,
                    ),
              ),
            ),
    );
  }
}
