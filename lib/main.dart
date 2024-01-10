import 'package:fake_store/core/injector/setup_locator.dart';
import 'package:fake_store/core/pages/splash_page.dart';
import 'package:fake_store/features/login/presentation/bloc/auth/authentication_bloc.dart';
import 'package:flutter/material.dart';

import 'features/home/presentation/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(const FakeStoreApp());
}

class FakeStoreApp extends StatelessWidget {
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
