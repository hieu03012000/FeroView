import 'package:fero/services/task_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ModelSchedulePage extends StatefulWidget {
  final String modelId;
  ModelSchedulePage({Key key, this.modelId}) : super(key: key);

  @override
  _ModelSchedulePageState createState() => _ModelSchedulePageState();
}

class _ModelSchedulePageState extends State<ModelSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
        onPressed: () => {},
      ),
      body: FutureBuilder<TaskListViewModel>(
        future: Provider.of<TaskListViewModel>(context, listen: false)
            .getTaskList(widget.modelId),
        builder: (ctx, prevData) {
          if (prevData.connectionState == ConnectionState.waiting) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            if (prevData.error == null) {
              return Consumer<TaskListViewModel>(
                  builder: (ctx, data, child) => Center(
                        child: scheduleView(context: ctx, tasks: data),
                      ));
            } else {
              return Text('Error');
            }
          }
        },
      ),
    );
  }

  ListView scheduleView({BuildContext context, TaskListViewModel tasks}) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Schedule',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: 650,
          child: SfCalendar(
            view: CalendarView.workWeek,
            dataSource: TaskDataSource(getAppointment(tasks)),
            backgroundColor: kBackgroundColor,
            timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 0, endHour: 24, nonWorkingDays: <int>[]),
          ),
        ),
      ],
    );
  }
}
