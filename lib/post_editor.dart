import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostEditor extends StatefulWidget {
  @override
  _PostEditorState createState() => _PostEditorState();
}

class _PostEditorState extends State<PostEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: TextField()),
          ElevatedButton(
              onPressed: () {
                print('Send');
              },
              child: Text('Send'))
        ],
      ),
    );
  }
}
