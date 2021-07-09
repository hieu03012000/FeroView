import 'package:fero/components/casting_card.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelApplyCastingPage extends StatelessWidget {
  const ModelApplyCastingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'To me'),
                Tab(
                  text: 'From me',
                )
              ],
              indicatorColor: kTextColor,
              indicatorWeight: 3,
              labelColor: kTextColor,
              unselectedLabelColor: kTextColor.withOpacity(0.8),
            ),
            title: Text('Request'),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: SizedBox(
                      height: height - 162,
                      child: FutureBuilder<CastingListViewModel>(
                          future: Provider.of<CastingListViewModel>(context,
                                  listen: false)
                              .modelApplyCasting(),
                          builder: (context, data) {
                            if (data.connectionState ==
                                ConnectionState.waiting) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 150,
                                  ),
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            } else {
                              if (data.error == null) {
                                return Consumer<CastingListViewModel>(
                                    builder: (ctx, data, child) =>
                                        CastingListComponent(
                                          list: data,
                                        ));
                              } else {
                                return Center(
                                  child: SizedBox(
                                    child: Text('Not found'),
                                  ),
                                );
                              }
                            }
                          }),
                    ),
                  )
                ],
              )),
              SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: SizedBox(
                      height: height - 162,
                      child: FutureBuilder<CastingListViewModel>(
                          future: Provider.of<CastingListViewModel>(context,
                                  listen: false)
                              .modelApplyCasting(),
                          builder: (context, data) {
                            if (data.connectionState ==
                                ConnectionState.waiting) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 150,
                                  ),
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            } else {
                              if (data.error == null) {
                                return Consumer<CastingListViewModel>(
                                    builder: (ctx, data, child) =>
                                        CastingListComponent(
                                          list: data,
                                        ));
                              } else {
                                return Center(
                                  child: SizedBox(
                                    child: Text(
                                        'You haven\'t applied to any casting'),
                                  ),
                                );
                              }
                            }
                          }),
                    ),
                  )
                ],
              )),
            ],
          )),
    ));
  }
}
