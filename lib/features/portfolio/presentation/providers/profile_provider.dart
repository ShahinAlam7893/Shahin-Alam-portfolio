// lib/features/portfolio/presentation/providers/profile_provider.dart
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final String name = "Shahin Alam";
  final String title = "Flutter Developer & AI Researcher";
  final String location = "Dhaka, Bangladesh";
  final String phone = "+880 1609-500994";
  final String email = "shahinalam7892@gmail.com";
  final String github = "https://github.com/ShahinAlam7893";
  final String researchgate = "https://www.researchgate.net/profile/Shahin-Alam-26";
  final String linkedin = "https://www.linkedin.com/in/shahin-alam7892";

  final String about = "Flutter Developer and Software Engineer with experience in building scalable cross-platform mobile applications, REST API integration, and AI-powered systems. Proven ability to develop real-time features, optimize performance, and deliver user-centric applications. Strong foundation in machine learning and data analysis.";

  final Map<String, List<String>> skills = {
    "Programming Languages": ["Dart", "Python", "PHP", "JavaScript", "C"],
    "Mobile & Frameworks": ["Flutter", "Provider", "Firebase", "WebSocket", "FCM"],
    "Backend & Tools": ["REST APIs", "Laravel", "Git", "Postman", ],
    "AI & Machine Learning": ["Machine Learning", "Deep Learning", "NLP", "TensorFlow", "Scikit-learn"],
    "Others Tools" : ["Colab", "VS Code", "Android Studio", "Figma", "Canva", "Microsoft Office", "Google Workspace",],
  };

  final List<Map<String, dynamic>> projects = [
    {
      "title": "CircleSlate",
      "date": "2025",
      "desc": "Real-time scheduling app with WebSocket chat and Google Calendar integration.",
      "tech": ["Flutter", "WebSocket", "REST API", "Google Calendar"]
    },
    {
      "title": "SayTask",
      "date": "2025",
      "desc": "AI-powered task management and call scheduling with voice input and real-time sync.",
      "tech": ["Flutter", "Firebase", "AI Voice", "OAuth"]
    },
    {
      "title": "Florle",
      "date": "2026",
      "desc": "Real-time garden visualization system with AI photo optimization.",
      "tech": ["Flutter", "AI", "Firebase"]
    },
  ];

  final List<Map<String, String>> research = [
    {"title": "A Comparative Analysis of Cardiovascular Disease (CVD) Detection Using Machine Learning and Deep Learning", 
      "date": "2024",
    "desc": "Applied 11 single ML/DL models and 5 hybrid models. Achieved 96% accuracy with ANN and CNN+XGBoost, outperforming previous research."},
    {"title": "Sentiment Analysis of Product Reviews: A Comparative Study of NLP and Deep Learning Approaches", 
      "date": "2025",
    "desc": "DOI: DOI: 10.1109/QPAIN66474.2025.11171988"},
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
      "desc": "Taught Computer Science and Technology and mentored students."
    },
  ];

  final List<Map<String, dynamic>> education = [
    {
      "degree": "B.Sc. in Computer Science and Engineering",
      "institute": "Port City International University",
      "date": "2019 – 2024",
      "grade": "CGPA: 3.74/4.00"
    },
    {
      "degree": "Heigher School Certificate (HSC) in Science",
      "institute": "Principal Kazi Faruque College",
      "date": "2017 – 2019",
      "grade": "A Grade"
    },
    {
      "degree": "Secondary School Certificate (SSC) in Science",
      "institute": "Sermon School and College",
      "date": "2015 – 2017",
      "grade": "A Grade"
    }
  ];
  final List<Map<String, String>> achievements = [
    {"title": "2nd Place", "event": "PCIU Programming Contest 2024"},
    {"title": "Participant", "event": "ICPC Preliminary 2023"},
    {"title": "3rd Place", "event": "Programming Contest 2022"},
  ];

  final List<Map<String, String>> certifications = [
    {"title": "Full-Stack Web Development", "issuer": "OSTAD • 2024"},
    {"title": "PHP and Laravel Framework", "issuer": "BASIS • 2023"},
    {"title": "Skills for Career Progression", "issuer": "PCIU • 2022"},
    {"title": "Digital Marketing", "issuer": "SR Dream IT • 2022"},
  ];
  
   final List<Map<String, String>> activities = [
    {"title": "PCIU Computer Club", "issuer": "Finance Secretary • 2023-2024"},
    {"title": "Sponsor Team Head", "issuer": "PCIU Volunteers • 2023"},
    {"title": "Executive Member", "issuer": "School of Engineers • 2023-2024"},
    {"title": "Media Editor", "issuer": "The Sheild • 2022-2023"},
  ];
  
  
}


