import 'package:camara_comunicaciones/src/App/view/theme/light_theme.dart';
import 'package:camara_comunicaciones/src/App/view/theme/scroll_behavior.dart';
import 'package:camara_comunicaciones/src/providers.dart';
import 'package:camara_comunicaciones/src/router.dart';
import 'package:camara_comunicaciones/transmissor_src/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CamaraCCApp extends StatefulWidget {
  const CamaraCCApp({super.key});

  @override
  State<CamaraCCApp> createState() => _CamaraCCAppState();
}

class _CamaraCCAppState extends State<CamaraCCApp> {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MultiProvider(
        providers: providers(),
        child: MaterialApp.router(
          title: "Cámara - Comunicaciones",
          scrollBehavior: const ScrollBehaviorModified(),
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
        ),
      ),
    );
  }
}
