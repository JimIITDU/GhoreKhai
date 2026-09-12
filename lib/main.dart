import 'package:flutter/material.dart';
import 'models/models.dart';
import 'screens/auth/auth_gate_screen.dart';
import 'screens/root_screen.dart';
import 'theme.dart';

void main() {
  runApp(const GhoreKhaiApp());
}

class GhoreKhaiApp extends StatelessWidget {
  const GhoreKhaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghore Khai',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const AppRoot(),
    );
  }
}

/// Shows the verification flow first; once it hands back a verified
/// [AppUser], swaps to [RootScreen]. There's no persistence yet, so
/// closing the app resets verification too — see docs/ROADMAP.md.
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  AppUser? _user;

  @override
  Widget build(BuildContext context) {
    final user = _user;
    if (user == null) {
      return AuthGateScreen(onVerified: (u) => setState(() => _user = u));
    }
    return RootScreen(user: user);
  }
}
