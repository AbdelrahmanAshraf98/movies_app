import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../providers/people_view_model.dart';

class PeopleCardWidget extends StatelessWidget {
  const PeopleCardWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.subColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl:
            'https://image.tmdb.org/t/p/original${Provider.of<PeopleViewModel>(context).peoples[index].profilePath}',
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellowColor))),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: AppColors.subColor.withOpacity(0.5),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  Provider.of<PeopleViewModel>(context).peoples[index].name!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}