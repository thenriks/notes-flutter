import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_flutter/post_editor.dart';
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

  Future<Site> fetchSite() async {
    final siteId =
        await http.get(Uri.http(BACKEND_URL, 'site_id/' + widget.token));
    print('siteId: ' + siteId.body);
    final response =
        await http.get(Uri.http(BACKEND_URL, 'site/' + siteId.body));

    if (response.statusCode == 200) {
      return Site.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Couldn't load site");
    }
  }

  @override
  void initState() {
    super.initState();
    _site = fetchSite();
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
                      var comps = <Widget>[];
                      comps.add(Text('/site/' + snapshot.data.sid.toString()));
                      comps.add(Text(snapshot.data.title));

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
              ),
            ),
            Center(
              child: Text('Isert link'),
            ),
            Center(
              child: Text('Info'),
            ),
          ],
        ),
      ),
    );
  }
}
