import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/providers/people_view_model.dart';
import 'package:movies_app/views/widgets/people_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final RefreshController _refreshController = RefreshController();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FutureBuilder(
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
              if (Provider.of<PeopleViewModel>(context).peoples.isNotEmpty) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: true,
                  onRefresh: () async {
                    await Provider.of<PeopleViewModel>(context, listen: false)
                        .getPopularPeople();
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    bool flag = await Provider.of<PeopleViewModel>(context,
                            listen: false)
                        .getPopularPeople(more: true);
                    flag
                        ? _refreshController.loadComplete()
                        : _refreshController.loadFailed();
                  },
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemBuilder: (context, index) {
                      return PeopleCardWidget(index: index);
                    },
                    itemCount:
                        Provider.of<PeopleViewModel>(context).peoples.length,
                  ),
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
      ),
    );
  }
}
