import 'package:flutter/material.dart';
import '../providers/navigation_provider.dart';
import 'home_content.dart';
import 'skills_content.dart';
import 'projects_content.dart';
import 'experience_content.dart';
import 'education_content.dart';
import 'research_content.dart';
import 'achievements_content.dart';
import 'certifications_content.dart';
import 'activity_content.dart';
import 'contact_content.dart';

/// One entry in the single-page portfolio.
class PortfolioSection {
  final SectionId id;
  final String label;
  final IconData icon;
  final Widget body;

  /// Whether this section appears in the top nav / drawer (all sections are
  /// always rendered in the page regardless).
  final bool showInNav;

  /// Hero gets no eyebrow reveal offset / larger spacing.
  final bool isHero;

  const PortfolioSection({
    required this.id,
    required this.label,
    required this.icon,
    required this.body,
    this.showInNav = true,
    this.isHero = false,
  });
}

/// The ordered list of sections shown in both the website and mobile layouts.
List<PortfolioSection> buildSections({
  VoidCallback? onViewToggle,
  bool isMobileView = false,
}) {
  return [
    PortfolioSection(
      id: SectionId.home,
      label: 'Home',
      icon: Icons.home_outlined,
      isHero: true,
      body: HomeContent(onViewToggle: onViewToggle, isMobileView: isMobileView),
    ),
    const PortfolioSection(
      id: SectionId.skills,
      label: 'Skills',
      icon: Icons.code_outlined,
      body: SkillsContent(),
    ),
    const PortfolioSection(
      id: SectionId.projects,
      label: 'Projects',
      icon: Icons.rocket_launch_outlined,
      body: ProjectsContent(),
    ),
    const PortfolioSection(
      id: SectionId.experience,
      label: 'Experience',
      icon: Icons.work_outline,
      body: ExperienceContent(),
    ),
    const PortfolioSection(
      id: SectionId.education,
      label: 'Education',
      icon: Icons.school_outlined,
      body: EducationContent(),
    ),
    const PortfolioSection(
      id: SectionId.research,
      label: 'Research',
      icon: Icons.auto_graph_outlined,
      body: ResearchContent(),
    ),
    const PortfolioSection(
      id: SectionId.achievements,
      label: 'Achievements',
      icon: Icons.emoji_events_outlined,
      showInNav: false,
      body: AchievementsContent(),
    ),
    const PortfolioSection(
      id: SectionId.certifications,
      label: 'Certifications',
      icon: Icons.verified_outlined,
      showInNav: false,
      body: CertificationsContent(),
    ),
    const PortfolioSection(
      id: SectionId.activities,
      label: 'Activities',
      icon: Icons.volunteer_activism_outlined,
      showInNav: false,
      body: ActivityContent(),
    ),
    const PortfolioSection(
      id: SectionId.contact,
      label: 'Contact',
      icon: Icons.mail_outline,
      body: ContactContent(),
    ),
  ];
}
