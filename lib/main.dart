import 'package:brillo_assessment/app/shared/pages/onboard/onboard.dart';
import 'package:brillo_assessment/app/shared/theme/app_theme.dart';
import 'package:brillo_assessment/core/setups/run.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Setups.run();
  runApp(const ProviderScope(
    child: BrilloApp(),
  ));
}

class BrilloApp extends HookConsumerWidget {
  const BrilloApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Assessment',
      theme: AppTheme.lightThemeData,
      home: const Onboard(),
    );
  }
}
