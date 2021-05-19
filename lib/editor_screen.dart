import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
                      var comps = <Widget>[];
                      comps.add(Text('/site/' + snapshot.data.sid.toString()));
                      comps.add(Text(snapshot.data.title));

                      var elems = <Widget>[];
                      for (var x in snapshot.data.elements) {
                        elems.add(x);
                      }

                      comps.add(ListView(
                        shrinkWrap: true,
                        children: elems,
                      ));

                      return Column(
                        children: comps,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Load error');
                    }

                    return CircularProgressIndicator();
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Bottom'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
