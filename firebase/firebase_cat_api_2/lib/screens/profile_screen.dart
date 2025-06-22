import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _uid;
  late String _imageUrl;
  late String _name;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _uid = FirebaseAuth.instance.currentUser!.uid;
    _getUserData(_uid);
  }

  Future<void> _getUserData(uid) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _imageUrl = data['profile_picture'];
          _name = data['name'];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error : $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(BuildContext context, imageUrl, name, uid) {
    final TextEditingController imageUrlController = TextEditingController(
      text: imageUrl,
    );
    final TextEditingController nameController = TextEditingController(
      text: name,
    );
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    Future<void> submit(uid) async {
      if (formkey.currentState!.validate()) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'name': nameController.text.trim(),
          'profile_picture': imageUrlController.text.trim(),
        });

        _getUserData(uid);
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit your profile'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Image.network(imageUrlController.text),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            label: Text('Name'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: imageUrlController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            label: Text('Image URL'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                submit(uid);
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(_imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_name, style: const TextStyle(fontSize: 30)),
                          ElevatedButton(
                            onPressed: () =>
                                _showDialog(context, _imageUrl, _name, _uid),
                            child: const Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
