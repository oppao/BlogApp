import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../constants/style.dart';
import '../bloc/update/update_bloc.dart';

class BlogScreen extends StatefulWidget {
  final String uid, title, body, author;
  BlogScreen({this.uid, this.title, this.body, this.author});

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String uid, title, body, author;
  bool loading = true;

  TextEditingController titleCont = TextEditingController();
  TextEditingController bodyCont = TextEditingController();
  TextEditingController authorCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final form = FormGroup({
    'title': FormControl(value: "awts", validators: [Validators.required]),
    'body': FormControl(value: "awts", validators: [Validators.required]),
    'author': FormControl(value: "awts", validators: [Validators.required]),
  });

  @override
  void initState() {
    // TODO: implement initState
    //print("mfbvn${widget.uid}");
    uid = widget.uid;
    title = widget.title;
    body = widget.body;
    author = widget.author;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Update Blog',
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
      body: BlocBuilder<UpdateBloc, UpdateState>(
        builder: (context, state) {
          if (state is UpdateLoading) {
            return Column(
              children: [
                SpinKitFadingCircle(
                  color: Colors.grey,
                  size: 50.0,
                ),
                Text('${state.loadingMessage}')
              ],
            );
          } else if (state is UpdateDone) {
            return Column(
              children: [
                Container(
                    width: double.infinity,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${state.doneMessage}',
                        textAlign: TextAlign.center,
                        style: kTextButton.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: widget.title,
                            // controller: titleCont,
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
                            initialValue: widget.author,
                            //controller: authorCont,
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
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: widget.body,
                            //controller: bodyCont,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide something';
                              }
                              return null;
                            },
                            maxLines: 20,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is UpdateError) {
            return Container(
                width: double.infinity,
                color: Colors.green,
                child: Text('${state.errorMessage}'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: widget.title,
                      // controller: titleCont,
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
                      initialValue: widget.author,
                      //controller: authorCont,
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
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: widget.body,
                      //controller: bodyCont,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide something';
                        }
                        return null;
                      },
                      maxLines: 20,
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomSheet: InkWell(
        onTap: () {
          BlocProvider.of<UpdateBloc>(context).add(SubmitUpdate(
              uid: uid,
              title: title,
              body: body,
              author: author,
              context: context));
        },
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.deepPurple,
          child: Center(
            child: Text(
              'Update',
              style: kTextButton.copyWith(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
