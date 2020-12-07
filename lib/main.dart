import 'package:blog_app/screens/bloc/signin/signin_bloc.dart';
import 'package:blog_app/screens/bloc/signup/signup_bloc.dart';
import 'package:blog_app/screens/main_screen/main_screen.dart';
import 'package:blog_app/screens/signin/signin.dart';
import 'package:blog_app/screens/signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
          create: (BuildContext context) => SignupBloc(),
        ),
        BlocProvider<SigninBloc>(
          create: (BuildContext context) => SigninBloc(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/signup': (context) => SignUp(),
          '/signin': (context) => SignIn(),
          '/mainscreen': (context) => MainScreen(),
        },
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }
}
