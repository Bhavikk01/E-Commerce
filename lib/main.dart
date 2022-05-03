import 'package:e_commerce/app/authWidget.dart';
import 'package:e_commerce/app/pages/UserPage/UserHomePage.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app/pages/AdminPage/AdminHome.dart';
import 'app/pages/authentication/signInPage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = "pk_test_YOURKEYGOESHERE";
  runApp(const ProviderScope(
      child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
          primary: Colors.orange,
          seedColor: Colors.orange
        )
      ),
      home: Scaffold(
        body: AuthWidget(

          signedInBuilder: (context) => const UserHomePage(),
          nonSignedInBuilder: (_) => const SignInPage(),
          adminSignedInBuilder: (_)=> const AdminHomePage(),
          ),
        ),
    );
  }
}
