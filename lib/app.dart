import 'package:flutter/material.dart';
import 'router.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final bool seenIntro;
  const MyApp({super.key, required this.seenIntro});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter(seenIntro),
    );
  }
}
