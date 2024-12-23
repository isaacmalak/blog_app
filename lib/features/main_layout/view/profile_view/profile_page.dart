import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
       
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/profile.png')),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Supabase.instance.client.auth.currentUser!.userMetadata!['name'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            Supabase.instance.client.auth.currentUser!.userMetadata!['email'],
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
