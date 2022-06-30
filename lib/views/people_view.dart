import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/providers/people_view_model.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PeopleViewModel>(context, listen: false)
            .getPopularPeople(),
        builder: (context, snapshots) {
          if (snapshots.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.yellowColor,
                color: AppColors.subColor,
              ),
            );
          } else {
            if (Provider.of<PeopleViewModel>(context)
               .peoples
                .isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Text(
                    Provider.of<PeopleViewModel>(context)
                        .peoples[index]
                        .name!,
                    style: const TextStyle(color: Colors.white),
                  );
                },
                itemCount: Provider.of<PeopleViewModel>(context)
                    .peoples
                    .length,
              );
            } else {
              return Text(
                Provider.of<PeopleViewModel>(context).failure.message,
                style: const TextStyle(color: Colors.white),
              );
            }
          }
        },
      ),
    );
  }
}
