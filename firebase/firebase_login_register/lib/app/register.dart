// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final users = FirebaseFirestore.instance.collection('users');

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        // creates a new Firebase Auth account using the given email and password.
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        // add email to database
        // 'userCredential.user!.uid' gives you the unique user ID (UID) assigned by Firebase.
        // 'doc(userCredential.user!.uid)' creates a document where the document ID is the same as the Firebase Auth UID.
        // set() = "Create this document or replace its content."
        await users.doc(userCredential.user!.uid).set({
          'email': email,
          'createdAt': Timestamp.now(),
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("สมัครสมาชิกสำเร็จ!")));

        Navigator.pop(context); // กลับไปหน้าก่อนหน้า (Login)
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("เกิดข้อผิดพลาด: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("สมัครสมาชิก")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "อีเมล"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณากรอกอีเมล";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "รหัสผ่าน"),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _register, child: Text("สมัครสมาชิก")),
            ],
          ),
        ),
      ),
    );
  }
}
