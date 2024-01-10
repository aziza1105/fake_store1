// import 'package:fake_store/features/home/presentation/home_page.dart';
// import 'package:fake_store/features/main/presentation/main_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'bloc/auth/authentication_bloc.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final userNameController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: ListView(
//         children: [
//           TextField(
//             controller: userNameController,
//             textInputAction: TextInputAction.next,
//             decoration: const InputDecoration(labelText: 'Username'),
//           ),
//           TextField(
//             controller: passwordController,
//             textInputAction: TextInputAction.done,
//             decoration: const InputDecoration(labelText: 'Password'),
//             onEditingComplete: () {
//               context.read<AuthenticationBloc>().add(AuthenticationEvent.login(
//                 username: userNameController.text,
//                 password: passwordController.text,
//                 onSuccess: () {
//                   Navigator.of(context).pushAndRemoveUntil(
//                       CupertinoPageRoute(builder: (_) => const MainScreen()),
//                           (route) => false);
//                 },
//                 onFailure: (errorMessage) {
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(SnackBar(content: Text(errorMessage)));
//                 },
//               ));
//             },
//           ),
//           const SizedBox(height: 60),
//           MaterialButton(
//             color: Colors.green,
//             onPressed: () {
//               context.read<AuthenticationBloc>().add(AuthenticationEvent.login(
//                 username: userNameController.text,
//                 password: passwordController.text,
//                 onSuccess: () {
//                   Navigator.of(context).pushAndRemoveUntil(
//                       CupertinoPageRoute(builder: (_) => const ProductScreen()),
//                           (route) => false);
//                 },
//                 onFailure: (errorMessage) {
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(SnackBar(content: Text(errorMessage)));
//                 },
//               ));
//             },
//             child: const Text('Login'),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     userNameController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }


import 'package:fake_store/core/injector/setup_locator.dart';
import 'package:fake_store/features/home/presentation/home_page.dart';
import 'package:fake_store/features/main/presentation/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/auth/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: userNameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Password'),
            onEditingComplete: () {
              _performLogin();
            },
          ),
          const SizedBox(height: 60),
          MaterialButton(
            color: Colors.green,
            onPressed: () {
              _performLogin();
            },
            child: const Text('Login'),
          ),
          const Gap(440),
          MaterialButton(
            color: Colors.red,
            onPressed: () {
              _performLogout(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _performLogin() {
    context.read<AuthenticationBloc>().add(AuthenticationEvent.login(
      username: userNameController.text,
      password: passwordController.text,
      onSuccess: () {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (_) => const MainScreen()),
                (route) => false);
      },
      onFailure: (errorMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      },
    ));
  }

  void _performLogout(BuildContext context) async {
    final pref = serviceLocator<SharedPreferences>();
    await pref.remove('token');
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.logout());
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
