import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

class PostEditor extends StatefulWidget {
  final String token;
  final Function() updateSite;
  PostEditor({Key key, @required this.token, @required this.updateSite})
      : super(key: key);

  @override
  _PostEditorState createState() => _PostEditorState();
}

class _PostEditorState extends State<PostEditor> {
  //static const BACKEND_URL = '127.0.0.1:8000';
  TextEditingController _postController = new TextEditingController();

  Future<String> addText() async {
    final response = await http.post(
      Uri.http(Globals.BACKEND_URL, 'add_text'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': widget.token,
        'text': _postController.text,
      }),
    );

    if (response.statusCode == 200) {
      widget.updateSite();
      print('response.body: ' + response.body);
      return 'Successfully added text';
    } else {
      throw Exception('Failed to add text.');
    }
  }

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
                addText().then((value) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Message added')));
                  _postController.text = '';
                });
              },
              child: Text('Send'))
        ],
      ),
    );
  }
}
