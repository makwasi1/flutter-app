import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountDown extends StatefulWidget {
  final int seconds;

  CountDown({this.seconds});

  @override
  CountDownState createState() => CountDownState();
}

class CountDownState extends State<CountDown> with TickerProviderStateMixin {
  CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: controller,
      onEnd: onEnd,
      endTime: endTime,
      widgetBuilder: (_, CurrentRemainingTime time) {
        if (time == null) {
          return TextButton(
            child: Text('Resend Code'),
            onPressed: () {  },
          );
        }
        return Text("Didn't receive the code?  ${time.sec}");
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
