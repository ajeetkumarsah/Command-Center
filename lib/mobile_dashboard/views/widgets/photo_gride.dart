import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<File> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;
  final void Function()? onLongPress;

  const PhotoGrid(
      {required this.imageUrls,
      required this.onImageClicked,
      required this.onExpandClicked,
      this.maxImages = 4,
      this.onLongPress,
      Key? key})
      : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      semanticChildCount: 2,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      File imageUrl = widget.imageUrls[index];
      if (index == widget.maxImages - 1) {
        int remaining = numImages - widget.maxImages;
        if (remaining == 0) {
          return GestureDetector(
            onLongPress: widget.onLongPress,
            child: Image.file(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(imageUrl, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+$remaining',
                      style: GoogleFonts.ptSansCaption(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          onLongPress: widget.onLongPress,
          child: Image.file(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}
