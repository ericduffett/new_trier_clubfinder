import 'search_parameters.dart';
import 'package:flutter/material.dart';

class MeetingDays extends StatefulWidget {
  const MeetingDays({Key? key}) : super(key: key);

  @override
  _MeetingDaysState createState() => _MeetingDaysState();
}

class _MeetingDaysState extends State<MeetingDays> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Days of the Week'),
      content: SingleChildScrollView(
        child: ListBody(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 32) / 3,
                child: CheckboxListTile(
                    title: Text('Monday'),
                    value: monday,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {

                      setState(() {
                        monday = newValue!;
                      });


                    }
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 32) / 3,
                child: CheckboxListTile(
                    title: Text('Tuesday'),
                    value: tuesday,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {
                      setState(() {
                        tuesday = newValue!;
                      });
                    }
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 32) / 3,
                child: CheckboxListTile(
                    title: Text('Wednesday'),
                    value: wednesday,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {
                      setState(() {
                        wednesday = newValue!;
                      });

                    }
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 32) / 3,
                child: CheckboxListTile(
                    title: Text('Thursday'),
                    value: thursday,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {

                      setState(() {
                        thursday = newValue!;
                      });


                    }
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 32) / 3,
                child: CheckboxListTile(
                    title: Text('Friday'),
                    value: friday,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {
                      setState(() {
                        friday = newValue!;
                      });
                    }
                ),
              ),

            ]
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Clear'),
          onPressed: () {
            setState(() {
              resetMeetingDays();
              Navigator.of(context).pop();
            });
          },
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {

            selectedMeetingDays.clear();

            if (monday) {
              selectedMeetingDays.add('Monday');
            }
            if (tuesday) {
              selectedMeetingDays.add('Tuesday');
            }
            if (wednesday) {
              selectedMeetingDays.add('Wednesday');
            }
            if (thursday) {
              selectedMeetingDays.add('Thursday');
            }
            if (friday) {
              selectedMeetingDays.add('Friday');
            }


            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
