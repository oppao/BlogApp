import 'package:blog_app/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: (context, widget) => ResponsiveWrapper.builder(
      //   BouncingScrollWrapper.builder(context, widget),
      //   maxWidth: 1200,
      //   minWidth: 450,
      //   defaultScale: true,
      //   breakpoints: [
      //     ResponsiveBreakpoint.resize(450, name: MOBILE),
      //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //     ResponsiveBreakpoint.autoScale(1000, name: TABLET),
      //     ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      //     ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      //   ],
      // ),
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUp(),
    );
  }
}
