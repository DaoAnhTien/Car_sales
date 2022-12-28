import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/image_shimmer.dart';
import 'package:oke_car_flutter/widgets/loading_animation.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final String? defaultUrl;
  final String? blurHash;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? token;
  final ShimmerDirection shimmerDirection;
  final Duration shimmerDuration;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Color? shimmerBackColor;
  final Widget? errorWidget;
  final BoxDecoration? boxDecoration;
  final double radius;

  const CachedImage(
      this.url, {
        this.defaultUrl,
        this.blurHash,
        this.width = 300,
        this.height = 300,
        this.fit = BoxFit.fill,
        this.token,
        this.shimmerDirection = ShimmerDirection.ltr,
        this.shimmerDuration = const Duration(milliseconds: 1500),
        this.shimmerBaseColor,
        this.shimmerHighlightColor,
        this.shimmerBackColor,
        this.errorWidget,
        this.boxDecoration,
        this.radius = 0,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: url,
      httpHeaders: {
        'Authorization': token ?? '',
      },
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) {
        return ImageShimmerWidget(
          width: width,
          height: height,
          shimmerDirection: shimmerDirection,
          shimmerDuration: shimmerDuration,
          baseColor: shimmerBaseColor ?? const Color.fromRGBO(64, 64, 64, 0.5),
          highlightColor:
          shimmerHighlightColor ?? const Color.fromRGBO(166, 166, 166, 1.0),
          backColor:
          shimmerBackColor ?? const Color.fromRGBO(217, 217, 217, 0.5),
          boxDecoration: boxDecoration,
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: AssetImage(defaultUrl!),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}

