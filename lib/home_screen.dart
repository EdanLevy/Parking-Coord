import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_coordinator/parking_lot/parking_space_model.dart';
import 'package:parking_coordinator/user/user_provider.dart';
import 'package:parking_coordinator/user/user_service.dart';
import 'package:provider/provider.dart';
import 'parking_lot/parking_lot.dart';
import 'parking_lot/ui/parking_lot_screen.dart';
import 'parking_spaces_data.dart';
import 'user/auth_service.dart';
import 'user/user.dart' as app_user;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ParkingLot lot = ParkingLot(<int,ParkingSpaceModel>{
    1: createParkingSpace(1) .. occupy("user1"),
    2: createParkingSpace(2),
    3: createParkingSpace(3),
    4: createParkingSpace(4),
    5: createParkingSpace(5),
    6: createParkingSpace(6),
  });
  String title = 'Parking Coordinator';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: StreamBuilder<User?>(
          stream: AuthService().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.active && snapshot.data != null) {
              // this is a bit disgusting, ill fix it later
              app_user.User user = app_user.User.fromFirebaseAuthUser(snapshot.data!);
              return FutureBuilder(
                future: Provider.of<UserProvider>(context, listen: false).setUser(user.id),
                builder: (BuildContext context, AsyncSnapshot<UserProvider> snapshot) => Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  body: Center(
                    child: ParkingLotScreen(lot),
                  ),
                ),
              );
            } else {
              return SignInScreen(title: title);
            }
          }),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
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
}
