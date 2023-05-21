import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:location_app/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading';

  void setupWorldTime() async {
    // WordlTime was initialized by passing the object props
    // into it , the time was exception cos an instance has been
    // passed to it asa variable
    WorldTime instance = WorldTime(
      location: 'Berlin',
      flag: 'germany.png',
      url: 'Europe/London',
    );
    await instance.getTime();
    if (kDebugMode) {
      print(instance.time);
    }
    setState(() {
      time = instance.time; // Update the time variable
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(time),
      )),
    );
  }
}
