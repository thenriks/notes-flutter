import 'package:flutter/material.dart';

class SiteComponent extends StatefulWidget {
  final String type;
  final String text;
  final String url;
  final String id;

  SiteComponent({Key key, this.type, this.text, this.url, this.id})
      : super(key: key);

  @override
  _SiteComponentState createState() => _SiteComponentState();
}

class _SiteComponentState extends State<SiteComponent> {
  Widget build(BuildContext context) {
    if (widget.type == 'text') {
      return Row(
        children: [
          Expanded(
            child: Text(widget.text),
          ),
          GestureDetector(
            onTap: () {
              print('id: ' + widget.id);
            },
            child: Icon(Icons.highlight_remove),
          )
        ],
      );
    } else if (widget.type == 'link') {
      return Row(
        children: [
          Expanded(
            child: Text(widget.url),
          ),
          GestureDetector(
            onTap: () {
              print('id: ' + widget.id);
            },
            child: Icon(Icons.highlight_remove),
          )
        ],
      );
    }

    return Text('Invalid component');
  }
}
