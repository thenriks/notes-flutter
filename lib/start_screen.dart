import 'package:flutter/material.dart';
import 'editor_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController tokenTextController = new TextEditingController();

  void _newNote() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditorScreen(token: 'UUSI')),
    );
  }

  void _editNote() {
    print(tokenTextController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditorScreen(token: tokenTextController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('Noteshare')),
        body: Center(
          child: Container(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: Text('New'),
                  onPressed: _newNote,
                ),
                ElevatedButton(
                  child: Text('Edit'),
                  onPressed: _editNote,
                ),
                TextField(
                  controller: tokenTextController,
                  maxLength: 6,
                  decoration: InputDecoration(labelText: 'Token'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
