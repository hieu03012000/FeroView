import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:fero/screens/main_screen.dart';
import 'package:fero/services/task_service.dart';
import 'package:fero/utils/common.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        onPressed: () => {_showDateTimePicker(context)},
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

  DateTime _date = DateTime.now();
  TextEditingController fromController, toController, desController;

  void _selectDate(String type) async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1190, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              surface: kPrimaryColor,
              onSurface: Colors.black,
              primaryVariant: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        if (type == 'from') {
          fromController = TextEditingController()
            ..text = formatDate(newDate.toString());
        } else {
          toController = TextEditingController()
            ..text = formatDate(newDate.toString());
        }
      });
    }
  }

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(page: 0),
                  ));
            }
          } else {
            Fluttertoast.showToast(msg: 'Incorrect date');
          }
        }).showPicker(context);
  }

  void _showDialog(BuildContext context) {
    fromController = TextEditingController()
      ..text = formatDate(_date.toString());
    toController = TextEditingController()..text = formatDate(_date.toString());
    desController = TextEditingController()..text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Set free time"),
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              // var height = MediaQuery.of(context).size.height;
              // var width = MediaQuery.of(context).size.width;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 180,
                width: 350,
                child: ListView(
                  children: [
                    TextFormField(
                      cursorColor: kPrimaryColor,
                      controller: fromController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline),
                        labelText: 'From',
                      ),
                    ),
                    TextFormField(
                      cursorColor: kPrimaryColor,
                      controller: toController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline),
                        labelText: 'To',
                      ),
                    ),
                    TextFormField(
                      cursorColor: kPrimaryColor,
                      controller: desController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline),
                        labelText: 'Descripton',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text(
                'Search',
                style: TextStyle(color: kPrimaryColor),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(page: 0),
                    ));
              },
            ),
          ],
        );
      },
    );
  }
}
