import 'package:flutter/material.dart';

class SiteComponent extends StatefulWidget {
  final String type;
  final String text;
  final String url;

  SiteComponent({Key key, this.type, this.text, this.url}) : super(key: key);

  @override
  _SiteComponentState createState() => _SiteComponentState();
}

class _SiteComponentState extends State<SiteComponent> {
  Widget build(BuildContext context) {
    if (widget.type == 'text') {
      return Text(widget.text);
    } else if (widget.type == 'link') {
      return Text(widget.url);
    }
  }
}
