import 'package:flutter/material.dart';
import 'package:flutter_timer/provider/prvdr.dart';
import 'package:provider/provider.dart';

class TimerScreenHome extends StatefulWidget {
  const TimerScreenHome({Key? key}) : super(key: key);

  @override
  State<TimerScreenHome> createState() => _TimerScreenHomeState();
}

class _TimerScreenHomeState extends State<TimerScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Timer Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<TimeService>(context, listen: false).reset();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<TimeService>(
            builder: (context, timeService, child) {
              int minutes = (timeService.currentDuration ~/ 60).toInt();
              int seconds = (timeService.currentDuration % 60).toInt();
              return Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  '$minutes:${seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: TimeService.selectedTimes.map((time) {
                int minutes = int.parse(time) ~/ 60;
                bool isSelected = Provider.of<TimeService>(context).selectedTime == double.parse(time);
                return GestureDetector(
                  onTap: () {
                    Provider.of<TimeService>(context, listen: false)
                        .selectTime(double.parse(time));
                    Provider.of<TimeService>(context, listen: false).start();
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$minutes min',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.blue,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<TimeService>(
                builder: (context, timeService, child) => IconButton(
                  onPressed: () {
                    if (timeService.timerPlaying) {
                      timeService.pause();
                    } else {
                      timeService.start();
                    }
                  },
                  icon: Icon(
                    timeService.timerPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
