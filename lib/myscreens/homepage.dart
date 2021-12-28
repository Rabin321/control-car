import 'package:flutter/material.dart';

import 'package:tesla_app/myscreens/bottomnavbar.dart';
import 'package:tesla_app/myscreens/constants.dart';

import 'package:tesla_app/myscreens/doorlock.dart';
import 'package:tesla_app/myscreens/simpledoor_lock.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  final Controller _carcontroller = Controller();
  late Animation<double> _animationBattery;
  late AnimationController _batteryAnimationControl;
  late Animation<double> _animationBatteryStatus;
  late AnimationController _temperatureAnimationController;
  late Animation<double> _animationCarShift;

  void setupBatteryAnimation() {
    _batteryAnimationControl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationControl,
      curve: Interval(0.0, 0.5), // animation starts at 0 and ed at 0.5.
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _animationBattery,
      curve: Interval(0.6, 1),
    );
  }

  void setupTempAnimation() {
    _temperatureAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1400),
    );
    _animationCarShift = CurvedAnimation(
      parent: _temperatureAnimationController,
      curve: Interval(0.2, 0.4),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationControl.dispose();
    _temperatureAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _carcontroller,
          _batteryAnimationControl,
          _temperatureAnimationController
        ]),
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: Teslaappbottomnavbar(
              onTap: (index) {
                if (index == 1)
                  _batteryAnimationControl.forward();
                else if (_carcontroller.selectedBotTab == 1 && index != 1)
                  _batteryAnimationControl.reverse(from: 0.6);

                if (index == 2)
                  _temperatureAnimationController
                      .forward(); // start animation when clicked on temp icon

                else if (_carcontroller.selectedBotTab == 2 && index != 2)
                  _temperatureAnimationController.reverse(from: 0.4);
                _carcontroller.onBottomNavTabChange(index);
              },
              selectTab: _carcontroller.selectedBotTab,
            ),
            body: SafeArea(child: LayoutBuilder(builder: (context, constrains) {
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    height: constrains.maxHeight,
                    width: constrains.maxWidth,
                  ),
                  Positioned(
                    // shifting car to right when click on temperature botto nav icon.
                    left: constrains.maxWidth / 2.3 * _animationCarShift.value,
                    height: constrains.maxHeight,

                    width: constrains.maxWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constrains.maxHeight * 0.12,
                      ),
                      child: Image.asset(
                        "assets/icons/carrrr.png",
                        width: double.infinity,
                      ),
                    ),
                  ), // we can use 4 positioned for four locks. and use alignment in images.
                  AnimatedPositioned(
                    duration: defaultDuration,

                    //Now just lide the lock icon when clicked in battery bottom nav bar.
                    right: _carcontroller.selectedBotTab == 0 ? 23 : 180,
                    top: 350,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _carcontroller.selectedBotTab == 0 ? 1 : 0,
                      child: DoorLock(
                        isLock: _carcontroller.isRightDoorLock,
                        press: _carcontroller.updateRightDoor,
                      ),
                    ),
                    //This part uses door.lock
                    // some kind of animation... on click on locked icon -> change image to unlock icon
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    left: _carcontroller.selectedBotTab == 0 ? 42 : 170,
                    top: 350,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _carcontroller.selectedBotTab == 0 ? 1 : 0,
                      child: DoorLock(
                        isLock: _carcontroller.isLeftDoorLock,
                        press: _carcontroller.updateLeftDoor,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    top: _carcontroller.selectedBotTab == 0 ? 130 : 280,
                    left: 190,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _carcontroller.selectedBotTab == 0 ? 1 : 0,
                      child: DoorLock(
                        isLock: _carcontroller.isFrontDoorLock,
                        press: _carcontroller.updateFrontDoor,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _carcontroller.selectedBotTab == 0 ? 290 : 290,
                    left: _carcontroller.selectedBotTab == 0 ? 42 : 170,
                    child: AnimatedOpacity(
                      opacity: _carcontroller.selectedBotTab == 0 ? 1 : 0,
                      duration: defaultDuration,
                      child: DoorLock(
                        isLock: _carcontroller.isLeftBackDoorLock,
                        press: _carcontroller.updateLeftBackDoor,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    right: _carcontroller.selectedBotTab == 0 ? 25 : 170,
                    bottom: _carcontroller.selectedBotTab == 0 ? 290 : 290,
                    child: AnimatedOpacity(
                      opacity: _carcontroller.selectedBotTab == 0 ? 1 : 0,
                      duration: defaultDuration,
                      child: DoorLock(
                        isLock: _carcontroller.isRightBackDoorLock,
                        press: _carcontroller.updateRightBackDoor,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    left: 190,
                    bottom: _carcontroller.selectedBotTab == 0 ? 120 : 300,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _carcontroller.selectedBotTab == 0 ? 1 : 0,
                      child: DoorLock(
                        isLock: _carcontroller.isBackDoorLock,
                        press: _carcontroller.updateBackDoor,
                      ),
                    ),
                  ),

                  //main lock haha. Lock all door when clicked.
                  // Positioned(
                  //   top: 0,
                  //   left: 23,
                  //   child: DoorLock(
                  //     isLock: _carcontroller.isMainLock,
                  //     press: _carcontroller.updateMainlock,
                  //     //left.....
                  //   ),
                  // ),

                  //BATTERY
                  Opacity(
                    opacity: _animationBattery.value,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(152, 90, 0, 0),
                      child: Image.asset(
                        "assets/icons/123.png",
                        color: Colors.black,
                        width: constrains.maxWidth * 0.3,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 35 * (2 - _animationBatteryStatus.value),
                    child: Opacity(
                      opacity: _animationBatteryStatus.value,
                      child: BatteryStatus(
                        constraints: constrains,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70 * (2 - _animationBatteryStatus.value),
                    left: 105,
                    child: Opacity(
                      opacity: _animationBatteryStatus.value,
                      child: Stopcharging(
                        constraints: constrains,
                      ),
                    ),
                  )
                ],
              );
            })),
          );
        });
  }
}

class Stopcharging extends StatelessWidget {
  const Stopcharging({
    Key? key,
    required this.constraints,
  }) : super(key: key);
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 595.0, left: 20),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Stop Charging".toUpperCase(),
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.black, //background color of button
              side: BorderSide(
                width: 0.2,
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5)
              //     side: BorderSide(
              //   width: 1.0,
              //   color: Colors.white,

              // )),
              ),
        ),
      ),
    );
  }
}

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    Key? key,
    required this.constraints,
  }) : super(key: key);
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 150),
          child: Row(
            children: [
              Text(
                "Super Charging",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 155),
          child: Row(
            children: [
              Text(
                "14 min remaining",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 390,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "332 mi/hr",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 227.0),
              child: Text(
                "77 kw",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 31,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0, left: 174),
              child: Text(
                "243 mi",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 185.0, top: 3),
              child: Row(
                children: [
                  Text(
                    "78%",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Icon(
                    Icons.battery_charging_full_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
