import 'package:fake_store/core/injector/setup_locator.dart';
import 'package:fake_store/features/login/presentation/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
          MaterialButton(
            padding: const EdgeInsets.all(16),
            onPressed: () async{
              final pref = serviceLocator<SharedPreferences>();
              await pref.remove('token');
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false);
            },
            color: Colors.red,
            child: Text('Logout'),
          )
      ],
    )
    );
  }
}
