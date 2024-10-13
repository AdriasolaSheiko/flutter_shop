import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/login/login_page.dart';
import 'package:flutter_shop/widgets/firebase_loading.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //    useMaterial3: false,
          ),
      title: 'Flutter shop',
      home: FirebaseLoading(
        builder: (prefs) => LoginPage(
          prefs: prefs,
        ),
      ),
    );
  }
}
