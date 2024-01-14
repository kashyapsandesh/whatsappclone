import 'package:flutter/material.dart';
import 'package:whatsappclone/features/app/const/app_const.dart';
import 'package:whatsappclone/features/app/splash/splash_screen.dart';
import 'package:whatsappclone/features/app/theme/style.dart';
import 'package:whatsappclone/routes/on_generated_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
              seedColor: tabColor, brightness: Brightness.dark),
          scaffoldBackgroundColor: backgroundColor,
          dialogBackgroundColor: appBarColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          )),
      initialRoute: '/',
      onGenerateRoute: OnGenerateRoute.route,
      routes: {'/': (context) => SplashScreen()},
    );
  }
}