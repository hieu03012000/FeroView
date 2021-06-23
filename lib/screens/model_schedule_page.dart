import 'package:fero/components/bottom_navigator.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: ListView(
        children: [
          Center(
            child: Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              'Account',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: 625,
          child: SfCalendar(
            view: CalendarView.workWeek,
            
            backgroundColor: kBackgroundColor,
            timeSlotViewSettings: TimeSlotViewSettings(
              startHour: 0,
              endHour: 24,
              nonWorkingDays: <int>[]
            ),
          ),
        ),
        
        ],
         ),
       bottomNavigationBar: buildNavigationBar(context, 0),
    );
  }

}