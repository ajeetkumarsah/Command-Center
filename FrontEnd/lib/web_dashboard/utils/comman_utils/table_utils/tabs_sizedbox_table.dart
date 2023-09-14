import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class TabsSizedBoxTable extends StatelessWidget {
  final Function() onTap;
  final int selectedIndex;
  final int index;
  final List arrayRetailing;

  const TabsSizedBoxTable(
      {super.key,
      required this.onTap,
      required this.selectedIndex,
      required this.index,
      required this.arrayRetailing});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
        ),
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? MyColors.whiteColor
                : MyColors.transparent,
            border: Border.all(width: 1, color: MyColors.whiteColor),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Center(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      arrayRetailing[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedIndex == index
                              ? MyColors.toggletextColor
                              : MyColors.whiteColor,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.w400,
                          fontFamily: fontFamily),
                    ))),
          ),
        ),
      ),
    );
  }
}

// class TabsSizedBoxTable extends StatelessWidget {
//   final Function() onTap;
//   final int selectedIndex;
//   final int index;
//   final List arrayRetailing;
//   const TabsSizedBoxTable({super.key, required this.onTap, required this.selectedIndex, required this.index, required this.arrayRetailing});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: 30,
//         ),
//         child: Container(
//           width: 200,
//           decoration: BoxDecoration(
//             color: MyColors.whiteColor,
//             border: Border.all(
//                 width: 1,
//                 color: MyColors.whiteColor),
//             borderRadius:
//             BorderRadius.circular(30.0),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 left: 8.0, right: 8.0),
//             child: Center(
//                 child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       arrayRetailing[index],
//                       textAlign: TextAlign
//                           .center,
//                       style: TextStyle(
//                           color: MyColors
//                               .toggletextColor,
//                           fontWeight:
//                           selectedIndex ==
//                               index
//                               ? FontWeight
//                               .bold
//                               : FontWeight
//                               .w400,
//                           fontFamily: fontFamily),
//                     ))),
//           ),
//         ),
//       ),
//     );
//   }
// }
