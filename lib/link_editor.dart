import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

class LinkEditor extends StatefulWidget {
  final String token;
  final Function() updateSite;
  LinkEditor({Key key, @required this.token, @required this.updateSite})
      : super(key: key);

  @override
  _LinkEditorState createState() => _LinkEditorState();
}

class _LinkEditorState extends State<LinkEditor> {
  //static const BACKEND_URL = '127.0.0.1:8000';
  TextEditingController _linkController = new TextEditingController();

  Future<String> addLink() async {
    final response = await http.post(
      Uri.http(Globals.BACKEND_URL, 'add_link'),
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
                if (_linkController.text.startsWith('http://') ||
                    _linkController.text.startsWith('https://')) {
                  addLink().then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Link added')));
                    _linkController.text = '';
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter valid link')));
                }
              },
              child: Text('Send'))
        ],
      ),
    );
  }
}
