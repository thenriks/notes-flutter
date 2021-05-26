import 'package:flutter/material.dart';
import 'editor_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  //static const BACKEND_URL = '127.0.0.1:8000';
  TextEditingController tokenTextController = new TextEditingController();

  void _newSite() async {
    final response = await http.post(
      Uri.http(Globals.BACKEND_URL, 'new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJSON = jsonDecode(response.body);
      print(responseJSON['token']);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditorScreen(token: responseJSON['token'])),
      );
    } else {
      throw Exception('Couldn\'t create site.');
    }
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
                  onPressed: _newSite,
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
