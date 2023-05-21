import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; //location name for the UI
  String time; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint

  // Constructor

  WorldTime({required this.location, required this.flag, required this.url})
      : time = '';

  Future<void> getTime() async {
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
    time = now.toString();
  }
}
