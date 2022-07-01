import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../common/app_colors.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    this.imgPath,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final String? imgPath;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/original${imgPath}',
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator.adaptive(
              valueColor:
              AlwaysStoppedAnimation<Color>(AppColors.yellowColor))),
      errorWidget: (context, url, error) => Container(color: AppColors.subColor,child: const Icon(Icons.error)),
      fit: boxFit,
    );
  }
}
