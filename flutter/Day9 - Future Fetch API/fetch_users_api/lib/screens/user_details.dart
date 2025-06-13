import 'package:flutter/material.dart';
import 'package:fetch_users_api/models/user_model.dart';

class UserDetails extends StatelessWidget {
  final String name;
  final String email;
  final Address address;
  final String phone;
  final String website;

  const UserDetails({
    super.key,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade100,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                _infoTile(Icons.email, "Email", email),
                _infoTile(Icons.phone, "Phone", phone),
                _infoTile(Icons.language, "Website", website),
                const Divider(),
                const SizedBox(height: 10),
                Text('Address', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('${address.street}, ${address.suite}'),
                Text('${address.city}, ${address.zipcode}'),
                const SizedBox(height: 8),
                Text(
                  'Lat: ${address.geo.lat}, Lng: ${address.geo.long}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(value, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
