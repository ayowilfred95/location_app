import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDayTime = false; // true  or false if daytime or not

  // Constructor

  WorldTime({required this.location, required this.flag, required this.url})
      : time = '';

  Future<void> getTime() async {
    // Using try and catch method
    //  similar to try and catch method in javascript
    try {
      Response response = await get(Uri.parse(
          'https://worldtimeapi.org/api/timezone/$url')); // keyword: Uri.parse
      Map data = jsonDecode(
          response.body); // jsonDecode uses a package called dart:convert

      // get properties from data
      //using square bracket notation

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3); // keyword:substring
      if (kDebugMode) {
        // print(datatime);
        //print(offset);
      }
      // craete DateTime object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (error) {
      if (kDebugMode) {
        print(error);
        time = 'Could not get time';
      }
    }
  }
}
