import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class ExamFormPage extends StatefulWidget {
  const ExamFormPage({super.key});

  @override
  State<ExamFormPage> createState() => _ExamFormPageState();
}

class _ExamFormPageState extends State<ExamFormPage> {
  final name = TextEditingController();
  final id = TextEditingController();

  bool isLoading = false;

  Map<String, bool> subjects = {
    "C Programming": false,
    "Mathematics": false,
    "Electrical Engineering": false,
    "Chemistry": false,
    "DSA": false,
  };

  Future<void> submit() async {
    if (name.text.isEmpty || id.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (!subjects.containsValue(true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select at least one subject")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseService.submitExam(
        name.text.trim(),
        id.text.trim(),
        subjects,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exam Form Submitted Successfully")),
      );

      // Clear form
      name.clear();
      id.clear();
      subjects.updateAll((key, value) => false);
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    name.dispose();
    id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // AppBar
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Exam Form", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0B3C8C), Color(0xFF1E5BB8)],
            ),
          ),
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            //  Header Card
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E5BB8), Color(0xFF0B3C8C)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exam Registration",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Fill your details carefully",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //  FORM CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Name
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Student Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ID
                  TextField(
                    controller: id,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.badge),
                      labelText: "Student ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Subjects",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subjects
                  ...subjects.keys.map((sub) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CheckboxListTile(
                        activeColor: const Color(0xFF1E5BB8),
                        title: Text(sub),
                        value: subjects[sub],
                        onChanged: (val) {
                          setState(() {
                            subjects[sub] = val!;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //  SUBMIT BUTTON 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF1E5BB8),
                ),
                onPressed: isLoading ? null : submit,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Submit Exam Form",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, 
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
