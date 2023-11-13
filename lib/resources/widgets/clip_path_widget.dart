// import 'package:flutter/material.dart';

// import 'package:quran/resources/color_manager.dart';
// import 'package:quran/resources/styles_manager.dart';
// import 'package:quran/resources/widgets/custom_clip.dart';

// class ClipPathWidget extends StatelessWidget {
//   const ClipPathWidget({
//     Key? key,
//     required this.title,
//     this.vis,
//   }) : super(key: key);
//   final String title;
//   final bool? vis;
//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper: CustomClipPath(),
//       child: Container(
//         height: 220,
//         color: ColorManager.primary,
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Visibility(
//               visible: vis ?? true,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 35),
//                 child: IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.white,
//                       size: 35,
//                     )),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: vis ?? true ? 35 : 30),
//               child: Text(
//                 title,
//                 style: vis ?? true
//                     ? getBoldStyle(color: ColorManager.white)
//                         .copyWith(fontSize: 35)
//                     : getBoldStyle(color: ColorManager.primary2)
//                         .copyWith(fontSize: 50, fontFamily: 'DTHULUTH'),
//               ),
//             ),
//             const Spacer(),
//             Image.asset(
//               'assets/icons/decoration.png',
//               height: 150,
//             ),
//           ],
//         ),
//       ),
//     );
  
//   }
// }
