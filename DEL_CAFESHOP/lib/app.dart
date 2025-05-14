import 'package:del_cafeshop/features/authentication/screens/onboarding/onboarding.dart';
import 'package:del_cafeshop/utils/theme/theme.dart';
import 'package:del_cafeshop/initial_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(), // tambahkan ini
      themeMode: ThemeMode.system,
      theme: TAppTHeme.lightTheme,
      darkTheme: TAppTHeme.darkTheme,
      home: const OnBoardingScreen(),
    );
  }
}
