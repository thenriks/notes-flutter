import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostEditor extends StatefulWidget {
  final String token;
  PostEditor({Key key, @required this.token}) : super(key: key);

  @override
  _PostEditorState createState() => _PostEditorState();
}

class _PostEditorState extends State<PostEditor> {
  TextEditingController _postController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _postController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 500,
              decoration: InputDecoration(labelText: 'Message'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print(widget.token);
                print(_postController.text);
              },
              child: Text('Send'))
        ],
      ),
    );
  }
}
