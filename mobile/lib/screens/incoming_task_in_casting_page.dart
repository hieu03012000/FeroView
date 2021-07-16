import 'package:fero/components/incoming_task_list_component.dart';
import 'package:fero/screens/model_schedule_page.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomingTaskInCastingPage extends StatelessWidget {
  final int castingId;
  const IncomingTaskInCastingPage({Key key, this.castingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Task'),
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
                  child: FutureBuilder<TaskListViewModel>(
                      future: Provider.of<TaskListViewModel>(context,
                              listen: false)
                          .getIncomingTaskList(castingId),
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
                            return Consumer<TaskListViewModel>(
                                builder: (ctx, data, child) =>
                                    IncomingTaskListComponent(
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
          ))),
    );
  }
}
