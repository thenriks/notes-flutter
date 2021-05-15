import 'package:flutter/cupertino.dart';

class SiteElement {
  String type;
  String text;

  SiteElement({
    @required this.type,
    this.text,
  });
}

class Site {
  String title;
  final int sid;
  bool isOpen;
  var elements = <SiteElement>[];

  Site({
    @required this.title,
    @required this.sid,
    @required this.isOpen,
    @required this.elements,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    var elements = <SiteElement>[];

    for (var x in json['elements']) {
      //print(x['type']);
      elements.add(SiteElement(type: 'text', text: x['text']));
    }

    return Site(
      title: json['title'],
      sid: json['sid'],
      isOpen: json['isOpen'],
      elements: elements,
    );
  }
}
