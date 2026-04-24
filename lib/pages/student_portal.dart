import 'package:flutter/material.dart';
import 'past_questions_page.dart';
import 'exam_form_page.dart';
import 'faculty_page.dart';
import 'contact_page.dart';

class StudentPortal extends StatelessWidget {
  const StudentPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // 🔵 Drawer
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0B3C8C), Color(0xFF1E5BB8)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome Student",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "student@ioe.edu",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            buildDrawerItem(
                context, Icons.history, "Past Questions", const PastQuestionsPage()),
            buildDrawerItem(
                context, Icons.description, "Exam Form", const ExamFormPage()),
            buildDrawerItem(
                context, Icons.school, "Faculty", const FacultyPage()),
            buildDrawerItem(
                context, Icons.contact_mail, "Contact Us", const ContactUs()),
          ],
        ),
      ),

      // 🔵 AppBar
     appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,

  // ✅ Makes back button / menu icon white
  iconTheme: const IconThemeData(color: Colors.white),

  // ✅ Gradient background
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0B3C8C), Color(0xFF1E5BB8)],
      ),
    ),
  ),

  // ✅ Title in white
  title: const Text(
    "Student Portal",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),

  centerTitle: true,
),

      // 🔵 Body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildCard(context, Icons.history, "Past Questions",
                      const PastQuestionsPage()),
                  buildCard(context, Icons.description, "Exam Form",
                      const ExamFormPage()),
                  buildCard(
                      context, Icons.school, "Faculty", const FacultyPage()),
                  buildCard(context, Icons.contact_mail, "Contact Us",
                      const ContactUs()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Drawer Item
  Widget buildDrawerItem(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }

  // 🔹 Attractive Card
  Widget buildCard(
      BuildContext context, IconData icon, String title, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E5BB8), Color(0xFF0B3C8C)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}