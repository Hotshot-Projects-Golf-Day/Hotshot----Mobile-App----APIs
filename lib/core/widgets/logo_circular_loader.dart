// import 'package:flutter/material.dart';


// class LogoCircularLoader extends StatelessWidget {
//   const LogoCircularLoader({super.key});

//   static const double _size = 60;
//   static const double _strokeWidth = 4;
//   static const Color _color = Color(0xFF1F333C);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: _size,
//       height: _size,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CircularProgressIndicator(
//             strokeWidth: _strokeWidth,
//             valueColor: AlwaysStoppedAnimation<Color>(_color),
//           ),
//           Image.asset(
//             AppAssets.loginLogo,
//             width: 28,
//             height: 28,
//             fit: BoxFit.contain,
//           ),
//         ],
//       ),
//     );
//   }
// }
