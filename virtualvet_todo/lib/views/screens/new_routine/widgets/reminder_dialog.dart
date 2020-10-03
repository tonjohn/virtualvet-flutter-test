import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

addReminder(BuildContext context, {DateTime date}) async {
  DateTime time;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 60.0,
          bottom: 60.0,
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "REMINDER",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                    child: Center(
                  child: SizedBox(
                    height: 140.0,
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (date) {
                        time = date;
                      },
                    ),
                  ),
                )),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          time = null;
                          Navigator.pop(context);
                        },
                        child: Text(
                          "CANCEL",
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (time != null) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  return time;
}
