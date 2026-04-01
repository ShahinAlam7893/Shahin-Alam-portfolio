// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../widgets/main_layout.dart';
// import '../widgets/project_card.dart';
// import '../providers/profile_provider.dart';
// import 'package:provider/provider.dart';

// class ProjectsPage extends StatelessWidget {
//   const ProjectsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final projects = Provider.of<ProfileProvider>(context).projects;

//     return MainLayout(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Featured Projects", style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold)),
//           SizedBox(height: 40.h),
//           ...projects.map((p) => Padding(
//                 padding: EdgeInsets.only(bottom: 32.h),
//                 child: ProjectCard(
//                   title: p["title"],
//                   date: p["date"],
//                   desc: p["desc"],
//                   tech: List<String>.from(p["tech"] ?? []),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }