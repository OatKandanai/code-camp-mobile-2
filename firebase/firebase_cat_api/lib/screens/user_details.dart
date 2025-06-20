import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late final String? _uid;
  late final TextEditingController _nameController;
  late final TextEditingController _imageController;
  String? _imageUrl;
  late final GlobalKey<FormState> _formkey;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser?.uid;
    _nameController = TextEditingController();
    _imageController = TextEditingController();
    _formkey = GlobalKey<FormState>();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (_uid == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text('user not found')));
      return;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _nameController.text = data['name'] ?? '';
        _imageController.text = data['profile_picture'] ?? '';
        _imageUrl = data['profile_picture'] ?? '';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('user data not found')));
    }
  }

  Future<void> _submitData() async {
    if (_formkey.currentState!.validate() && _uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'name': _nameController.text.trim(),
        'profile_picture': _imageController.text.trim(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Updated')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Center(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Image.network(
                        _imageUrl!,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(label: const Text('Name')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Input something';
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
                            return 'Input something';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _imageUrl = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitData,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
