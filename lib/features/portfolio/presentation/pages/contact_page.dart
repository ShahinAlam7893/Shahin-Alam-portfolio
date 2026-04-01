// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../widgets/main_layout.dart';
// import '../providers/profile_provider.dart';
// import 'package:provider/provider.dart';

// class ContactPage extends StatelessWidget {
//   const ContactPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final profile = Provider.of<ProfileProvider>(context);

//     return MainLayout(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Let's Connect",
//                   style:
//                       TextStyle(fontSize: 52.sp, fontWeight: FontWeight.bold))
//               .animate()
//               .fadeIn()
//               .slideY(),
//           SizedBox(height: 30.h),
//           Text(
//               "I'm always open to discussing new opportunities, collaborations, or just a conversation about technology and Flutter/AI.",
//               style: TextStyle(fontSize: 18.sp, height: 1.6)),
//           SizedBox(height: 60.h),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _contactItem(Icons.phone, profile.phone),
//                     _contactItem(Icons.email, profile.email),
//                     _contactItem(Icons.location_on, profile.location),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(40.w),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     borderRadius: BorderRadius.circular(24.r),
//                   ),
//                   child: Column(
//                     children: [
//                       Text("Send a Message", style: TextStyle(fontSize: 24.sp)),
//                       const SizedBox(height: 30),
//                       // Simple form (you can enhance with TextFields later)
//                       ElevatedButton.icon(
//                         onPressed: () =>
//                             launchUrl(Uri.parse("mailto:${profile.email}")),
//                         icon: const Icon(Icons.send),
//                         label: const Text("Send Email"),
//                         style: ElevatedButton.styleFrom(
//                             minimumSize: Size(double.infinity, 60.h)),
//                       ),
//                     ],
//                   ),
//                 ).animate().fadeIn(delay: 300.ms),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _contactItem(IconData icon, String text) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFF00E6A8)),
//       title: Text(text),
//     ).animate().fadeIn();
//   }
// }
