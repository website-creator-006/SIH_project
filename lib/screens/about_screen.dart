import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Jharkhand"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Jharkhand is known for its rich cultural heritage, beautiful waterfalls, hills, and vibrant tribal culture. Discover scenic landscapes and experience the best of India's heartland.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
