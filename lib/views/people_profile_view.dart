import 'package:flutter/material.dart';
import 'package:movies_app/views/widgets/custom_cached_image.dart';
import 'package:movies_app/views/widgets/image_viewer_dialog.dart';
import '../models/PopularPeopleDataResponse.dart';

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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                width: double.infinity,
                child: Hero(
                  tag: 'photo',
                  child: CustomCachedNetworkImage(
                      imgPath: widget.person.profilePath),
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
                    const SizedBox(height: 14.0),
                    Row(
                      children: [
                        const Icon(Icons.assistant),
                        const SizedBox(width: 5.0),
                        Center(
                          child: Text(
                            widget.person.knownForDepartment!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      children: [
                        const Icon(Icons.people),
                        const SizedBox(width: 5.0),
                        Center(
                          child: Text(
                            widget.person.popularity.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemBuilder: (context, index) {
                    String imgPath =
                        widget.person.knownFor![index].backdropPath!;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
