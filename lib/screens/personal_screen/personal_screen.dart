import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

import '../../constants/style.dart';
import '../bloc/delete/delete_bloc.dart';
import '../bloc/personal/personal_bloc.dart';
import '../blog_screen/blog_screen.dart';

class PersonalScreen extends StatefulWidget {
  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

final blogRef = FirebaseFirestore.instance.collection('blog');

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  void initState() {
    super.initState();
  }

  var uid, author, body, title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          ' Personal Blogs',
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
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
                            builder: (context) => BlogScreen(
                              uid: uid,
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
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                //print(state.blog[index]);

                                uid = (state.blog[index].id);
                                print(uid);
                                BlocProvider.of<DeleteBloc>(context)
                                    .add(Delete(uid: uid, context: context));
                              },
                            ),

                            // trailing: BlocBuilder<DeleteBloc, DeleteState>(
                            //   builder: (context, state) {
                            //     if (state is DeleteLoading) {
                            //       return Column(
                            //         children: [
                            //           CircularProgressIndicator(
                            //             strokeWidth: 1,
                            //           ),
                            //           uid =
                            //               (state.deleteBlog[index]["title"]),
                            //           Text("${state.loadingMessage}"),
                            //         ],
                            //       );
                            //     } else if (state is DeleteDone) {}

                            //     return IconButton(
                            //         icon: Icon(
                            //           Icons.delete,
                            //           color: Colors.redAccent,
                            //         ),
                            //         onPressed: () {
                            //           BlocProvider.of<DeleteBloc>(context)
                            //               .add(Delete(uid: uid));
                            //         });
                            //   },
                            // ),
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
      floatingActionButton: BlocBuilder<DeleteBloc, DeleteState>(
        builder: (context, state) {
          if (state is DeleteLoading) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.grey,
                size: 50.0,
              ),
            );
          } else if (state is DeleteDone) {
            return Text('${state.doneMessage}');
          } else if (state is DeleteError) {
            return Text('${state.errorMessage}');
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

// getBlog() async {
//   final DocumentSnapshot doc = await blogRef.doc().get();
//   print(doc.data().toString());
//   print(doc.exists);
// }

class Customize_Container extends StatelessWidget {
  final Widget widget;

  const Customize_Container({Key key, this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: widget,
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

Widget loadingWidget(BuildContext context) {
  return Scaffold(
    body: Center(
      child: SpinKitFadingCircle(
        color: Colors.grey,
        size: 50.0,
      ),
    ),
  );
}
