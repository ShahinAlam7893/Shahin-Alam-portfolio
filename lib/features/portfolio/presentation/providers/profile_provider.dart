import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final String name = "Shahin Alam";
  final String title = "Flutter Developer & AI Researcher";
  final String location = "Dhaka, Bangladesh";
  final String phone = "+880 1609-500994";
  final String email = "shahinalam7892@gmail.com";
  final String researchgate = "https://www.researchgate.net/profile/Shahin-Alam-2";
  final String github = "https://github.com/shahinalam7893";
  final String about = "Flutter Developer and Software Engineer with experience in building scalable cross-platform mobile applications..."; // full from resume

  // Skills grouped
  final Map<String, List<String>> skills = {
    "Programming Languages": ["Dart", "Python", "PHP", "JavaScript", "C"],
    "Frameworks & Tools": ["Flutter", "Provider", "Firebase", "REST APIs", "Laravel", "Git", "WebSocket", "FCM"],
    "AI & ML": ["Machine Learning", "Deep Learning", "NLP", "ANN", "CNN", "XGBoost"],
  };

  final List<Map<String, dynamic>> projects = [
    {
      "title": "CircleSlate",
      "date": "2024 - Present",
      "desc": "Real-time scheduling app with WebSocket chat and Google Calendar integration.",
      "tech": ["Flutter", "WebSocket", "REST API", "Google Calendar"]
    },
    {
      "title": "SayTask",
      "date": "2024",
      "desc": "AI-powered task management with voice input and real-time sync.",
      "tech": ["Flutter", "Firebase", "AI Voice", "OAuth"]
    },
    {
      "title": "Florle",
      "date": "2023",
      "desc": "Real-time garden visualization system with AI photo optimization.",
      "tech": ["Flutter", "AI", "Firebase"]
    },
  ];

  final List<Map<String, dynamic>> experiences = [
    {
      "role": "Flutter Developer",
      "company": "Join Venture AI (JVAI)",
      "date": "2025 - Present",
      "desc": "Developed scalable AI-powered Flutter applications with REST APIs and Firebase."
    },
    {
      "role": "Lecturer",
      "company": "Chittagong Technical College",
      "date": "2025",
      "desc": "Taught Python, C and mentored students."
    },
  ];

  final List<Map<String, dynamic>> education = [
    {
      "degree": "B.Sc. in Computer Science and Engineering",
      "institute": "Port City International University",
      "date": "2019 – 2024",
      "grade": "CGPA: 3.74/4.00"
    }
  ];
}