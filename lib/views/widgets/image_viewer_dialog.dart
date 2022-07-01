import 'package:flutter/material.dart';
import 'package:movies_app/views/widgets/custom_cached_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';

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
