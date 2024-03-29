import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/features/app/const/app_const.dart';
import 'package:whatsappclone/features/app/home/home_page.dart';
import 'package:whatsappclone/features/app/splash/splash_screen.dart';
import 'package:whatsappclone/features/app/theme/style.dart';
import 'package:whatsappclone/features/users/presentation/cubit/auth/auth_cubit.dart';
import 'package:whatsappclone/features/users/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatsappclone/features/users/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:whatsappclone/features/users/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatsappclone/features/users/presentation/cubit/user/user_cubit.dart';
import 'package:whatsappclone/firebase_options.dart';
import 'package:whatsappclone/routes/on_generated_routes.dart';
import 'main_injection_container.dart' as di;

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetDeviceNumberCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
              seedColor: tabColor, brightness: Brightness.dark),
          scaffoldBackgroundColor: backgroundColor,
          dialogBackgroundColor: appBarColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
        ),
        initialRoute: "/",
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(uid: authState.uid);
                }
                return SplashScreen();
              },
            );
          },
        },
      ),
    );
  }
}
