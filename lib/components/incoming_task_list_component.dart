import 'package:fero/screens/incoming_task_in_casting_page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:fero/viewmodels/model_task_view_model.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomingTaskListComponent extends StatefulWidget {
  final TaskListViewModel list;
 IncomingTaskListComponent({Key key, this.list}) : super(key: key);

  @override
   IncomingTaskListComponentState createState() =>  IncomingTaskListComponentState();
}

class  IncomingTaskListComponentState extends State<IncomingTaskListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: widget.list.tasks[index], index: index,);
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  final ModelTaskViewModel task;
  final int index;
  const TaskCard({Key key, this.task, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MultiProvider(
      //                 providers: [
      //                   ChangeNotifierProvider(
      //                       create: (_) => TaskListViewModel()),
      //                 ],
      //                 child: FutureBuilder(
      //                   builder: (context, snapshot) {
      //                     return IncomingTaskInCastingPage(
      //                       castingId: casting.id,
      //                     );
      //                   },
      //                 ))),
      //   );
      // },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.5),
                offset: Offset(0, 5),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    'Task ${index + 1}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextColor),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
              ],
            ),
            Row(
              children: [
                Text('Start at: '),
                Text(
                  '${task.startAtTime} ${task.startAtDate}'?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text('End at: '),
                Text(
                  '${task.endAtTime} ${task.endAtDate}'?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
