import 'package:flutter/material.dart';
import 'package:tesla_app/myscreens/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Using this in positioned(car lock).

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.press,
    required this.isLock,
  }) : super(key: key);

  final VoidCallback press;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: AnimatedSwitcher(
          // switchInCurve: Curves.bounceIn,
          duration: defaultDuration,
          child: isLock
              ? SvgPicture.asset(
                  "assets/icons/door_lock.svg",
                  color: Colors.red,
                  key: ValueKey(
                      "lock"), //  here  I used key because flutter these lock and unlock img as a same widgets. so animated doesn't appear.
                  // so by using key, it thinks they are different.
                )
              : SvgPicture.asset(
                  "assets/icons/door_unlock.svg",
                  key: ValueKey("unlock"),
                  color: Colors.greenAccent[400],
                ),
        )
        // we can use ontap to show unlock logo when we click on lock icon.
        );
  }
}
