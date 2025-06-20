import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final FirebaseAuth _auth;
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final TextEditingController _imageController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formkey;
  late final CollectionReference<Map<String, dynamic>> _users;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _imageController = TextEditingController();
    _passwordController = TextEditingController();
    _formkey = GlobalKey<FormState>();
    _users = FirebaseFirestore.instance.collection('users');
  }

  Future<void> _register() async {
    if (_formkey.currentState!.validate()) {
      try {
        String email = _emailController.text.trim();
        String name = _nameController.text.trim();
        String password = _passwordController.text.trim();
        String image = _imageController.text.trim();

        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        await _users.doc(userCredential.user!.uid).set({
          'email': email,
          'name': name,
          'profile_picture': image,
          'created_at': FieldValue.serverTimestamp(),
        });

        _formkey.currentState!.reset();

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Register Completed')));

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Register Failed : ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(imageUrl, height: 240, fit: BoxFit.contain),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(label: const Text('Email')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(label: const Text('Name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      label: const Text('Image Link'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input Image Link';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        imageUrl = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(label: const Text('Password')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input Password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
