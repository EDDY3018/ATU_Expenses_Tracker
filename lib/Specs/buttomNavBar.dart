// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

// import '../Screens/Dashboard/dashboard.dart';
// import '../Screens/Notifications/noti.dart';
// import '../Screens/Search/search.dart';
// import '../Screens/Settings/settings.dart';

// class Navv extends StatefulWidget {
//   const Navv({super.key});

//   @override
//   State<Navv> createState() => _NavvState();
// }

// class _NavvState extends State<Navv> {
//   final List<Widget> _pages = [
//     const HomePage(),
//     const Search(),
//     const Notifications(),
//     const Settings()
//   ];
//   int _pageIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Color.fromARGB(210, 24, 54, 104),
//           ),
//           child: GNav(
//             onTabChange: (value) {
//               _pageIndex = value;
//               setState(() {});
//             },
//             tabBorderRadius: BorderSide.strokeAlignOutside,
//             curve: Curves.easeInCubic,
//             // backgroundColor: Color.fromARGB(210, 24, 54, 104),
//             color: Colors.white,
//             activeColor: Colors.yellow,
//             gap: 8,
//             padding: const EdgeInsets.all(30),
//             tabs: [
//               GButton(
//                 icon: Icons.house_outlined,
//                 text: 'Home',
//               ),
//               GButton(
//                 icon: Icons.person_2_outlined,
//                 text: 'Search',
//               ),
//               GButton(
//                 icon: Icons.temple_hindu_outlined,
//                 text: 'Notification',
//               ),
//               GButton(
//                 icon: Icons.temple_hindu_outlined,
//                 text: 'Notification',
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Center(
//         child: _pages.elementAt(_pageIndex),
//       ),
//     );
//   }
// }
