import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LinkEditor extends StatefulWidget {
  final String token;
  final Function() updateSite;
  LinkEditor({Key key, @required this.token, @required this.updateSite})
      : super(key: key);

  @override
  _LinkEditorState createState() => _LinkEditorState();
}

class _LinkEditorState extends State<LinkEditor> {
  static const BACKEND_URL = '127.0.0.1:8000';
  TextEditingController _linkController = new TextEditingController();

  Future<String> addLink() async {
    final response = await http.post(
      Uri.http(BACKEND_URL, 'add_link'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': widget.token,
        'url': _linkController.text,
      }),
    );

    if (response.statusCode == 200) {
      widget.updateSite();
      print('response.body: ' + response.body);
      return 'Successfully added link';
    } else {
      throw Exception('Failed to add link.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _linkController,
              maxLines: null,
              decoration: InputDecoration(labelText: 'Link'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                //print(widget.token);
                //print(_linkController.text);
                addLink();
              },
              child: Text('Send'))
        ],
      ),
    );
  }
}
