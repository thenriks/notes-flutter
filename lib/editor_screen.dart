import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_flutter/site_component.dart';
import 'site.dart';

class EditorScreen extends StatefulWidget {
  final String token;
  EditorScreen({Key key, @required this.token}) : super(key: key);

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  Future<Site> _site;

  Future<Site> fetchSite() async {
    final response = await http.get(Uri.http('127.0.0.1:8000', 'site/24'));

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
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(widget.token),
              FutureBuilder<Site>(
                  future: _site,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //return Text(snapshot.data.title);
                      //return Text(snapshot.data.sid.toString());
                      var comps = <SiteComponent>[];

                      for (var x in snapshot.data.elements) {
                        comps.add(SiteComponent(text: x.text));
                      }

                      return Column(
                        children: comps,
                      );

                      //return Text(snapshot.data.elements[0].text);
                    } else if (snapshot.hasError) {
                      return Text('Load error');
                    }

                    return CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
