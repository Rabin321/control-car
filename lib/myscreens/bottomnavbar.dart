import 'package:flutter/material.dart';
import 'package:tesla_app/myscreens/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Teslaappbottomnavbar extends StatelessWidget {
  const Teslaappbottomnavbar({
    Key? key,
    required this.selectTab,
    required this.onTap,
  }) : super(key: key);

  final int selectTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectTab,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      items: List.generate(
          navigationIcons.length,
          (index) => BottomNavigationBarItem(
                icon: SvgPicture.asset(navigationIcons[index],
                    color: index == selectTab ? primaryColor : Colors.white70),
                label: "",
              )),
    );
  }
}

List<String> navigationIcons = [
  "assets/icons/Lock.svg",
  "assets/icons/Charge.svg",
  "assets/icons/Temp.svg",
  "assets/icons/Tyre.svg"
];


//  BottomNavigationBarItem(
//           icon: SvgPicture.asset("assets/icons/Lock.svg"),
//           label: "",
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset("assets/icons/Charge.svg"),
//           label: "",
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset("assets/icons/Temp.svg"),
//           label: "",
//         ),