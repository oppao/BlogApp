import 'package:blog_app/constants/style.dart';
import 'package:blog_app/screens/bloc/signin/signin_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: Icon(Icons.supervised_user_circle),
        title: Text("Sign-in"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Mag Login',
                      style: kTextButton.copyWith(fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Enter email',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                labelText: 'Enter password',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            BlocBuilder<SigninBloc, SigninState>(
                              builder: (context, state) {
                                if (state is SigninLoading) {
                                  return Column(
                                    children: [
                                      CircularProgressIndicator(),
                                      Text('Please wait...'),
                                    ],
                                  );
                                } else if (state is SigninSubmit) {
                                  return Text(
                                    '${state.submitMessage}',
                                  );
                                }
                                Navigator.popAndPushNamed(
                                    context, '/mainscreen');

                                if (state is SigninError) {
                                  return Text('${state.errorMessage}');
                                }
                                return (Text(''));
                              },
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<SigninBloc>(context).add(
                                  Submit(email: email, password: password),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'I-SUBMIT',
                                    style: kTextButton.copyWith(
                                        fontSize: 14, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () =>
                                  Navigator.popAndPushNamed(context, '/signup'),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text('Mag sign-up'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
