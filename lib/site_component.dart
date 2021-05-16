import 'package:flutter/material.dart';

class SiteComponent extends StatefulWidget {
  final String text;
  SiteComponent({Key key, @required this.text}) : super(key: key);

  @override
  _SiteComponentState createState() => _SiteComponentState();
}

class _SiteComponentState extends State<SiteComponent> {
  Widget build(BuildContext context) {
    return Text(widget.text);
  }
}
