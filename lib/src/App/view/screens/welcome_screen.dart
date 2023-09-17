import 'package:camara_comunicaciones/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(Routes.liveStreaming),
          child: Text("Iniciar transmisión"),
        ),
      ),
    );
  }
}
