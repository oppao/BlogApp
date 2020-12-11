import 'package:blog_app/screens/bloc/personal/personal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/style.dart';
import '../bloc/create/create_bloc.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String title, body, author;
  bool loading = true;

  TextEditingController titleCont = TextEditingController();
  TextEditingController bodyCont = TextEditingController();
  TextEditingController authorCont = TextEditingController();

  void dispose() {
    authorCont.clear();
    bodyCont.clear();
    titleCont.clear();
  }

  final _formKey = GlobalKey<FormState>();

  final form = FormGroup({
    'title': FormControl(validators: [Validators.required]),
    'body': FormControl(validators: [Validators.required]),
    'author': FormControl(validators: [Validators.required]),
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Upload Blog',
          style: kTextButton.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
            tooltip: 'Logout',
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Customize_Container(
                    nameCont: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'Lumikha ng iyong blog',
                              style: kTextButton.copyWith(fontSize: 22),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: titleCont,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide something';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                title = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.title,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Title',
                                hintText: 'ex. The Beginning of Simula',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: bodyCont,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide something';
                                }
                                return null;
                              },
                              maxLines: 5,
                              onChanged: (value) {
                                body = value;
                                if (value.isEmpty) {
                                  return 'Please fill up';
                                }
                              },
                              decoration: InputDecoration(
                                helperText: 'Include your story here',
                                prefixIcon: Icon(
                                  Icons.content_copy_outlined,
                                ),
                                labelText: 'Body',
                                hintText: 'Place your content here...',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: authorCont,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide something';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                author = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.supervised_user_circle_outlined,
                                ),
                                labelText: 'Author',
                                hintText: 'ex. Alice Gonzaga',
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
                            BlocBuilder<CreateBloc, CreateState>(
                              builder: (context, state) {
                                return Customize_Container(
                                  nameCont: Center(
                                    child: InkWell(
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          BlocProvider.of<CreateBloc>(context)
                                              .add(Submit(
                                            title: title,
                                            body: body,
                                            author: author,
                                            context: context,
                                          ));

                                          dispose();
                                        }
                                      },
                                      child: loading == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'I-POST ANG BLOG',
                                                style: kTextButton.copyWith(
                                                    fontSize: 22),
                                              ),
                                            )
                                          : CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            BlocBuilder<CreateBloc, CreateState>(
                              builder: (context, state) {
                                if (state is CreateLoading) {
                                  return loading == state.loading
                                      ? Text(
                                          'not posted',
                                          style: kTextButton,
                                        )
                                      : SpinKitFadingCircle(
                                          color: Colors.grey,
                                          size: 50.0,
                                        );
                                } else if (state is CreateSubmit) {
                                  return Column(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      Text('${state.submitMessage}'),
                                    ],
                                  );
                                } else if (state is CreateError) {
                                  return Column(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                      Text('${state.errorMessage}'),
                                    ],
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<PersonalBloc>(context)
                                    .add(FetchData());
                                Navigator.pushNamed(context, '/personalscreen');
                              },
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'View Blogs',
                                      textAlign: TextAlign.center,
                                      style: kTextButton.copyWith(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Customize_Container extends StatelessWidget {
  final Widget nameCont;
  final Widget iconCont;

  const Customize_Container({Key key, this.nameCont, this.iconCont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: null,
      child: nameCont,
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
    );
  }
}
