import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final u = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(u?.phoneNumber ?? "Unknown"),
            subtitle: Text(u?.uid ?? ""),
            trailing: ElevatedButton(
              onPressed: () async => FirebaseAuth.instance.signOut(),
              child: const Text("Sign out"),
            ),
          ),
        ),
      ),
    );
  }
}
