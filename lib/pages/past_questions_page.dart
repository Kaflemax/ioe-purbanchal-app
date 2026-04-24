import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PastQuestionsPage extends StatelessWidget {
  const PastQuestionsPage({super.key});

  // Open link function
  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not open link";
    }
  }

  // Subject Row with link icon
  Widget subjectTile(String subject, String url) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.white),
        title: Text(subject, style: const TextStyle(color: Colors.white)),

        //  Link icon on right
        trailing: IconButton(
          icon: const Icon(Icons.link, color: Colors.white),
          onPressed: () => openLink(url),
        ),
      ),
    );
  }

  //Semester Card
  Widget semester(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // AppBar
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Past Questions",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0B3C8C), Color(0xFF1E5BB8)],
            ),
          ),
        ),
      ),

      //  Body Part
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            semester("Semester 1", [
              subjectTile(
                "C Programming",
                "https://lec.edu.np/uploads/document/638af4229228a.pdf",
              ),
              subjectTile(
                "Mathematics I",
                "https://lec.edu.np/uploads/document/638af47d30b38.pdf",
              ),
              subjectTile(
                "Electrical Engineering",
                "https://lec.edu.np/uploads/document/639054c941a17.pdf",
              ),
            ]),
            semester("Semester 2", [
              subjectTile(
                "C++",
                "https://lec.edu.np/uploads/document/6390592e0ce3f.pdf",
              ),
              subjectTile(
                "DSA",
                "https://lec.edu.np/uploads/document/63b9731caa102.pdf",
              ),
              subjectTile(
                "Web Development",
                "https://hamrocsit.com/semester/fifth/web-tech/question-bank/2076",
              ),
              subjectTile(
                "Math 2",
                "https://hamrocsit.com/semester/fifth/web-tech/question-bank/2076",
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
