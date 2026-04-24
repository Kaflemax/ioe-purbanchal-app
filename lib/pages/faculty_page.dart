import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FacultyPage extends StatelessWidget {
  const FacultyPage({super.key});

  final List<Map<String, String>> faculty = const [
    {
      "name": "Er. Ram Dhakal",
      "subject": "C Programming",
      "link": "https://ioesolutions.esign.com.np/contents/c-programming-ct-401",
    },
    {
      "name": "Er. Sita Sharma",
      "subject": "Math",
      "link":
          "https://ioesolutions.esign.com.np/contents/engineering-mathematics-i-sh-401",
    },
    {
      "name": "Er. Hari Karki",
      "subject": "Electrical",
      "link":
          "https://ioesolutions.esign.com.np/contents/basic-electrical-engineering-ee-401",
    },
  ];

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty"),
        backgroundColor: const Color(0xFF0B3C8C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B3C8C), Color(0xFF1E5BB8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: faculty.length,
          itemBuilder: (context, index) {
            final f = faculty[index];

            return Card(
              color: Colors.white,
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                title: Text(
                  f["name"]!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  f["subject"]!,
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new, color: Color(0xFF0B3C8C)),
                  onPressed: () => openUrl(f["link"]!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
