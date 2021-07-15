import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:fero/services/task_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ModelSchedulePage extends StatefulWidget {
  ModelSchedulePage({Key key}) : super(key: key);

  @override
  _ModelSchedulePageState createState() => _ModelSchedulePageState();
}

class _ModelSchedulePageState extends State<ModelSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kTextColor,
        onPressed: () => {_showDateTimePicker(context)},
      ),
      body: FutureBuilder<TaskListViewModel>(
        future: Provider.of<TaskListViewModel>(context, listen: false)
            .getTaskList(),
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
              return Consumer<TaskListViewModel>(
                  builder: (ctx, data, child) => Center(
                        child: scheduleView(context: ctx, tasks: null),
                      ));
            }
          }
        },
      ),
    );
  }

  ListView scheduleView({BuildContext context, TaskListViewModel tasks}) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Schedule',
              style: TextStyle(
                  color: kTextColor, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: size.height - 165,
          child: SfCalendar(
            view: CalendarView.workWeek,
            dataSource:
                tasks != null ? TaskDataSource(getAppointment(tasks)) : null,
            backgroundColor: kBackgroundColor,
            timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 0, endHour: 24, nonWorkingDays: <int>[]),
          ),
        ),
      ],
    );
  }

  TextEditingController fromController, toController, desController;
  void _showDateTimePicker(BuildContext context) {
    return DateTimeRangePicker(
        startText: "From",
        endText: "To",
        doneText: "Yes",
        cancelText: "Cancel",
        initialStartTime: DateTime.now(),
        initialEndTime: DateTime.now(),
        mode: DateTimeRangePickerMode.dateAndTime,
        minimumTime: DateTime.now().subtract(Duration(days: 1)),
        maximumTime: DateTime.now().add(Duration(days: 30)),
        use24hFormat: true,
        onConfirm: (start, end) async {
          if (start.isBefore(end)) {
            var modelId = (await FlutterSession().get("modelId")).toString();
            Map<String, dynamic> params = Map<String, dynamic>();
            params['startAt'] = start.toString();
            params['endAt'] = end.toString();
            params['modelId'] = modelId;
            print(start);
            print(end);
            var status = await TaskService().createFreeTime(params);
            if (status) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (_) => TaskListViewModel()),
                            ],
                            child: FutureBuilder(
                              builder: (context, snapshot) {
                                return ModelSchedulePage();
                              },
                            ))),
              );
            }
          } else {
            Fluttertoast.showToast(msg: 'Incorrect date');
          }
        }).showPicker(context);
  }
}
