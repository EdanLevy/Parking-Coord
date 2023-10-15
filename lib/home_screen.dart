import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'parking_lot/parking_lot.dart';
import 'parking_lot/ui/parking_lot_screen.dart';
import 'parking_spaces_data.dart';
import 'user/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ParkingLot lot = parkingLot;
  String title = 'Parking Coordinator';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          } else if (snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              body: Center(
                child: ParkingLotScreen(lot),
              ),
            );
          }
          else {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You are not signed in",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AuthService().signInWithGoogle();
                      },
                      child: const Text("Sign in with Google"),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
