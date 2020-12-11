import 'package:blog_app/screens/view_blog/view_blog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'constants/navigation_bar.dart';
import 'screens/bloc/create/create_bloc.dart';
import 'screens/bloc/delete/delete_bloc.dart';
import 'screens/bloc/main_screen/main_screen_bloc.dart';
import 'screens/bloc/personal/personal_bloc.dart';
import 'screens/bloc/signin/signin_bloc.dart';
import 'screens/bloc/signup/signup_bloc.dart';
import 'screens/bloc/update/update_bloc.dart';
import 'screens/blog_screen/blog_screen.dart';
import 'screens/create_screen/create_screen.dart';
import 'screens/main_screen/main_screen.dart';
import 'screens/personal_screen/personal_screen.dart';
import 'screens/signin/signin.dart';
import 'screens/signup/signup.dart';

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
        BlocProvider<MainScreenBloc>(
          create: (BuildContext context) => MainScreenBloc(),
        ),
        BlocProvider<CreateBloc>(
          create: (BuildContext context) => CreateBloc(),
        ),
        BlocProvider<PersonalBloc>(
          create: (BuildContext context) => PersonalBloc(),
        ),
        BlocProvider<DeleteBloc>(
          create: (BuildContext context) => DeleteBloc(),
        ),
        BlocProvider<UpdateBloc>(
          create: (BuildContext context) => UpdateBloc(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/signup': (context) => SignUp(),
          '/signin': (context) => SignIn(),
          '/mainscreen': (context) => MainScreen(),
          '/accountscreen': (context) => CreateScreen(),
          '/personalscreen': (context) => PersonalScreen(),
          '/blogscreen': (context) => BlogScreen(),
          '/viewblog': (context) => ViewBlog(),
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
        home: NavigationBar(),
      ),
    );
  }
}
