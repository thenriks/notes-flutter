import 'package:flutter/material.dart';

class SiteComponent extends StatefulWidget {
  final String type;
  final String text;
  final String url;
  final String id;
  final bool isOpen;
  final Function(String) remove;

  SiteComponent(
      {Key key,
      this.type,
      this.text,
      this.url,
      this.id,
      this.isOpen,
      this.remove})
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
          if (widget.isOpen)
            GestureDetector(
              onTap: () {
                //print('id: ' + widget.id);
                widget.remove(widget.id);
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
          if (widget.isOpen)
            GestureDetector(
              onTap: () {
                //print('id: ' + widget.id);
                widget.remove(widget.id);
              },
              child: Icon(Icons.highlight_remove),
            )
        ],
      );
    }

    return Text('Invalid component');
  }
}
