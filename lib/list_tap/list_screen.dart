import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
class ListScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height*0.14,
        ),
        CalendarTimeline(
          initialDate: DateTime(2020, 4, 20),
          firstDate: DateTime(2019, 1, 15),
          lastDate: DateTime(2020, 11, 20),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: Colors.black,
          dayColor: Colors.black,
          activeDayColor: Colors.black,
          activeBackgroundDayColor: Colors.white,
          dotsColor: Color(0xFF333A47),
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',dayNameColor: Colors.black,
        )
      ],
    );
  }
}
