import 'package:fero/components/incoming_casing_list_component.dart';
import 'package:fero/screens/model_schedule_page.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomingCastingPage extends StatelessWidget {
  const IncomingCastingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Booking'),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  child: Icon(Icons.schedule),
                  onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (_) => TaskListViewModel()),
                            ],
                            child: FutureBuilder(
                              builder: (context, snapshot) {
                                return ModelSchedulePage(
                                );
                              },
                            ))),
              );
                  },
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: SizedBox(
                  height: height - 162,
                  child: FutureBuilder<CastingListViewModel>(
                      future: Provider.of<CastingListViewModel>(context,
                              listen: false)
                          .imcomingCasting(),
                      builder: (context, data) {
                        if (data.connectionState == ConnectionState.waiting) {
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
                                    IncomingCastingListComponent(
                                      list: data,
                                    ));
                          } else {
                            return Center(
                              child: SizedBox(
                                child: Center(child: Text('Not have any booking'),),
                              ),
                            );
                          }
                        }
                      }),
                ),
              )
            ],
          ))),
    );
  }
}
