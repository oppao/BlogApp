import 'package:blog_app/screens/bloc/delete/delete_bloc.dart';
import 'package:blog_app/screens/bloc/personal/personal_bloc.dart';
import 'package:blog_app/screens/blog_screen/blog_screen.dart';
import 'package:blog_app/screens/view_blog/view_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants/style.dart';

class MainScreen extends StatefulWidget {
  final _auth = FirebaseAuth.instance;
  @override
  _MainScreenState createState() => _MainScreenState();
}

var uid, author, body, title;

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<PersonalBloc>(context).add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Blog Feed',
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
      body: BlocBuilder<PersonalBloc, PersonalState>(
        builder: (context, state) {
          if (state is PersonalLoading) {
            return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      color: Colors.grey,
                      size: 50.0,
                    ),
                    Text('${state.loadingMessage}'),
                  ],
                ));
          } else if (state is PersonalDataFetch) {
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.blog == null ? 0 : state.blog.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: InkWell(
                      onTap: () {
                        uid = (state.blog[index].id);
                        author = (state.blog[index]["author"]);
                        body = (state.blog[index]["body"]);
                        title = (state.blog[index]["title"]);
                        print(uid);
                        print(author);
                        print(body);
                        print(title);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewBlog(
                              author: author,
                              body: body,
                              title: title,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            title: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Title: '),
                                      Text(
                                        "${state.blog[index]["title"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Author: '),
                                      Text(
                                        "${state.blog[index]["author"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(
                                            height: 1,
                                            thickness: 0.5,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text('Content: '),
                                        Text(
                                          // "${state.blog[index]["body"]}",
                                          "${state.blog[index]["body"]}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Text('');
        },
      ),
      bottomSheet: InkWell(
        onTap: () {
          BlocProvider.of<PersonalBloc>(context).add(FetchData());
        },
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.deepPurple,
          child: Center(
            child: Text(
              'Refresh',
              style: kTextButton.copyWith(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}

class Customize_Container extends StatelessWidget {
  const Customize_Container({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
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

//create
createBlog() async {
  try {
    final blogRef = FirebaseFirestore.instance.collection('blog');
    await blogRef
        .doc("sdsffsdff")
        .set({"title": "fdggffdg", "body": "fgdsgfdgd", "author": "fdsfdff"});
  } catch (e) {
    print(e);
  }
}

//update
updateBlog() async {
  try {
    final blogRef = FirebaseFirestore.instance.collection('blog');
    await blogRef
        .doc("sdsffsdff")
        .update({"title": "yow", "body": "fgdsgfdgd", "author": "fdsfdff"});
  } catch (e) {
    print(e);
  }
}

//delete
deleteBlog() async {
  try {
    final blogRef = FirebaseFirestore.instance.collection('blog');
    await blogRef.doc("sdsffsdff").delete();
  } catch (e) {
    print(e);
  }
}
