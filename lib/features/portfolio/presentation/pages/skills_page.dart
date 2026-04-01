// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../widgets/main_layout.dart';
// import '../providers/profile_provider.dart';
// import 'package:provider/provider.dart';
// import '../widgets/skill_group_card.dart';

// class SkillsPage extends StatelessWidget {
//   const SkillsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final skills = Provider.of<ProfileProvider>(context).skills;

//     return MainLayout(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Technical Skills", style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold))
//               .animate().fadeIn().slideY(),

//           SizedBox(height: 60.h),

//           Wrap(
//             spacing: 24.w,
//             runSpacing: 24.h,
//             children: skills.entries.map((entry) => SkillGroupCard(title: entry.key, skills: entry.value)).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }