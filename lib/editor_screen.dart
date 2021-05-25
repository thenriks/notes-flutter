import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_flutter/post_editor.dart';
import 'package:notes_flutter/link_editor.dart';
import 'site.dart';

class EditorScreen extends StatefulWidget {
  final String token;
  EditorScreen({Key key, @required this.token}) : super(key: key);

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  static const BACKEND_URL = '127.0.0.1:8000';
  Future<Site> _site;
  String id = "";
  bool isOpen = false;

  Future<Site> fetchSite() async {
    final siteId =
        await http.get(Uri.http(BACKEND_URL, 'site_id/' + widget.token));
    print('siteId: ' + siteId.body);
    final response =
        await http.get(Uri.http(BACKEND_URL, 'site/' + siteId.body));

    if (response.statusCode == 200) {
      print('Site loaded');
      var resBody = jsonDecode(response.body);

      setState(() {
        id = siteId.body;
        isOpen = resBody['isOpen'];
      });
      return Site.fromJson(jsonDecode(response.body), _removeElement);
    } else {
      throw Exception("Couldn't load site");
    }
  }

  void _removeElement(String id) async {
    final response = await http.post(
      Uri.http(BACKEND_URL, 'remove'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': widget.token,
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      reloadSite();
    } else {
      throw Exception('Couldn\'t remove element.');
    }
  }

  void _closeSite() async {
    //print('closesite');
    final response = await http.post(
      Uri.http(BACKEND_URL, 'close_site'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': widget.token,
      }),
    );

    if (response.statusCode == 200) {
      reloadSite();
    } else {
      throw Exception('Couldn\'t close site.');
    }
  }

  @override
  void initState() {
    super.initState();
    _site = fetchSite();
  }

  void reloadSite() {
    //print('reloadSite()');
    setState(() {
      _site = fetchSite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit site'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.preview),
              ),
              Tab(
                icon: Icon(Icons.mode_comment),
              ),
              Tab(
                icon: Icon(Icons.insert_link),
              ),
              Tab(
                icon: Icon(Icons.info_outline),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: FutureBuilder(
                  future: _site,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var elems = <Widget>[];
                      for (var x in snapshot.data.elements) {
                        elems.add(x);
                      }

                      return ListView(
                        shrinkWrap: true,
                        children: elems,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Load error');
                    }

                    return CircularProgressIndicator();
                  }),
            ),
            Center(
              child: PostEditor(
                token: widget.token,
                updateSite: this.reloadSite,
              ),
            ),
            Center(
              child: LinkEditor(
                token: widget.token,
                updateSite: this.reloadSite,
              ),
            ),
            Column(
              children: [
                Text('Token: ' + widget.token),
                Text('https://notes-nuxt.vercel.app/sites/' + id),
                if (isOpen)
                  ElevatedButton(
                    onPressed: _closeSite,
                    child: Text('Close'),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
