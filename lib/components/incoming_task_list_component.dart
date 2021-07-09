import 'package:fero/screens/incoming_task_in_casting_page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
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
        // return CastingCard(casting: widget.list.tasks[index]);
      },
    );
  }
}

class CastingCard extends StatelessWidget {
  final CastingViewModel casting;
  const CastingCard({Key key, this.casting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                          return IncomingTaskInCastingPage(
                            castingId: casting.id,
                          );
                        },
                      ))),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
                    casting.name?? '',
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
                Text(
                  casting.salary?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kNumberColor),
                ),
              ],
            ),
            Container(
              child: Text(
                casting.description?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              children: [
                Text('Next task: '),
                Text(
                  '${casting.incomingTaskTime} ${casting.incomingTaskDate}'?? '',
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
