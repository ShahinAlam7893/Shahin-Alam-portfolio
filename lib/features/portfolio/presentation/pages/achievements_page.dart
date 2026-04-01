// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shahin_portfolio/features/portfolio/presentation/widgets/main_layout.dart';


// class AchievementsPage extends StatelessWidget {
//   const AchievementsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MainLayout(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Achievements & Recognition", style: TextStyle(fontSize: 52.sp, fontWeight: FontWeight.bold))
//               .animate().fadeIn().slideY(),

//           SizedBox(height: 60.h),

//           Wrap(
//             spacing: 24.w,
//             runSpacing: 24.h,
//             children: [
//               _achievementCard(context, "2nd Place", "PCIU Programming Contest 2024", Icons.emoji_events),
//               _achievementCard(context, "ICPC Preliminary", "Participant 2023", Icons.code),
//               _achievementCard(context, "3rd Place", "Programming Contest 2022", Icons.emoji_events_outlined),
//             ].map((card) => card.animate().fadeIn().scale()).toList(),
//           ),

//           SizedBox(height: 80.h),

//           Text("Publications", style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600)),
//           SizedBox(height: 20.h),
//           Container(
//             padding: EdgeInsets.all(32.w),
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(20.r),
//             ),
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Sentiment Analysis using NLP & Deep Learning", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
//                 Text("IEEE Conference • 2025", style: TextStyle(color: Colors.grey)),
//                 Text("DOI: 10.1109/QPAIN66474.2025.11171988"),
//               ],
//             ),
//           ).animate().fadeIn(delay: 400.ms),
//         ],
//       ),
//     );
//   }

//   Widget _achievementCard(BuildContext context, String title, String subtitle, IconData icon) {
//     return Container(
//       width: 380.w,
//       padding: EdgeInsets.all(28.w),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 48, color: const Color(0xFF00E6A8)),
//           SizedBox(width: 20.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 Text(subtitle, style: const TextStyle(fontSize: 16)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }