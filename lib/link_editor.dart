import 'package:flutter/material.dart';

class LinkEditor extends StatefulWidget {
  final String token;
  LinkEditor({Key key, @required this.token}) : super(key: key);

  @override
  _LinkEditorState createState() => _LinkEditorState();
}

class _LinkEditorState extends State<LinkEditor> {
  TextEditingController _linkController = new TextEditingController();

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
                print(widget.token);
                print(_linkController.text);
              },
              child: Text('Send'))
        ],
      ),
    );
  }
}
