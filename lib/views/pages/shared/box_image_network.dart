import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BoxImageNetwork extends StatelessWidget {
  final String src;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool isBanner;

  const BoxImageNetwork(
    this.src, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.isBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      height: height,
      width: width,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return !isBanner
            ? Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.black26,
                      highlightColor: Colors.deepPurple,
                      child: Container(
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
