import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../common/app_colors.dart';
import '../models/PopularPeopleDataResponse.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.person}) : super(key: key);
  final People person;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .6,
              width: double.infinity,
              child: Hero(
                tag: 'photo',
                child: CustomCachedNetworkImage(
                    imgPath: widget.person.profilePath!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.00),
              child: Column(
                children: [
                  Text(
                    widget.person.name!,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 14.0),
                  Row(
                    children: [
                      Icon(Icons.assistant),
                      SizedBox(width: 5.0),
                      Center(
                        child: Text(
                          widget.person.knownForDepartment!,
                          style:const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.0),
                  Row(
                    children: [
                      Icon(Icons.people),
                      SizedBox(width: 5.0),
                      Center(
                        child: Text(
                          widget.person.popularity.toString(),
                          style:const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 20.0,
              ),
              itemBuilder: (context, index) {
                String imgPath = widget.person.knownFor![index].backdropPath!;
                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ImageViewerDialog(imgPath: imgPath);
                        });
                  },
                  child: Hero(
                    tag: 'photo1',
                    child: CustomCachedNetworkImage(imgPath: imgPath),
                  ),
                );
              },
              itemCount: widget.person.knownFor!.length,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewerDialog extends StatelessWidget {
  const ImageViewerDialog({
    Key? key,
    required this.imgPath,
  }) : super(key: key);

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'photo1',
              child: CustomCachedNetworkImage(
                imgPath: imgPath,
                boxFit: BoxFit.fitWidth,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          Fluttertoast.showToast(
                              msg: "Download Started",
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.white,
                              backgroundColor: Colors.grey,
                              fontSize: 16.0);
                          var imageId =
                              await ImageDownloader.downloadImage(imgPath);

                          Fluttertoast.showToast(
                              msg: imageId != null
                                  ? "Downloaded Successfully"
                                  : "Download Failed",
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.white,
                              backgroundColor: Colors.grey,
                              fontSize: 16.0);
                        }),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.imgPath,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final String imgPath;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/original${imgPath}',
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator.adaptive(
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.yellowColor))),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: boxFit,
    );
  }
}
