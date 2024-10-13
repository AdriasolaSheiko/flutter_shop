import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shop/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseLoading extends StatelessWidget {
  const FirebaseLoading({
    super.key,
    required this.builder,
  });

  final Widget Function(SharedPreferences) builder;

  @override
  Widget build(BuildContext context) {
    const loading = Material(
      color: Color(0xFF00BAD9),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData ? builder(snapshot.data) : loading;
                  },
                )
              : loading;
        });
  }
}
