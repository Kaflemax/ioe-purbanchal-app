//Figure 1: FLutter App Initialization and Imports
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Figure 2: Flutter Screen Structure (COntact US Class)
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

//Till here
 //Figure 3: Flutter Input Controllers (Value Extraction)

class _ContactUsState extends State<ContactUs> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  
  bool loading = false;

  Future<void> handleSubmit() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }
   

    setState(() => loading = true);

    try {
      //Figure 6: Firebase Firestore Data Storage
      await FirebaseFirestore.instance.collection("contacts").add({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "message": messageController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });
      //Till here
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Message sent successfully!")),
      );
      // Till here
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() => loading = false);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Widget buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF0B3C8C)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black45),
        filled: true,
        fillColor: const Color(0xFFF5F8FF),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      //Till here
    );
  }

  //Figure 7: Flutter UI Layouy (Body Structure)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B3C8C), Color(0xFF1E5BB8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Get in Touch",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "We’d love to hear from you",
                  style: TextStyle(color: Colors.white70),
                ),
                //Till Here
                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      buildField(
                        controller: nameController,
                        hint: "Full Name",
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 15),

                      buildField(
                        controller: emailController,
                        hint: "Email Address",
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 15),

                      buildField(
                        controller: messageController,
                        hint: "Your Message",
                        icon: Icons.message,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B3C8C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          //Figure 4: Flutter Function Initiation
                          onPressed: loading ? null : handleSubmit,

                          //Till here
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Send Message",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),

                        //Till Here
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
