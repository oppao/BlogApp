import 'package:blog_app/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Customize_Container(),
            Customize_Container(),
          ],
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
