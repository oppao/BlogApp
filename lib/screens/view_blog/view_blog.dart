import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../constants/style.dart';

class ViewBlog extends StatefulWidget {
  String title, author, body;
  ViewBlog({this.title, this.author, this.body});

  @override
  _ViewBlogState createState() => _ViewBlogState();
}

class _ViewBlogState extends State<ViewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          '${widget.title}',
          style: kTextButton.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${widget.title}',
                  style:
                      kTextButton.copyWith(color: Colors.black, fontSize: 28),
                ),
                Row(
                  children: [
                    Text('Published by: '),
                    Text('${widget.author}'),
                  ],
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.body}',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
