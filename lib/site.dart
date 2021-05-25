import 'package:flutter/cupertino.dart';
import 'site_component.dart';

class Site {
  String title;
  final int sid;
  bool isOpen;
  var elements = <SiteComponent>[];

  Site({
    @required this.title,
    @required this.sid,
    @required this.isOpen,
    @required this.elements,
  });

  factory Site.fromJson(Map<String, dynamic> json, rf) {
    var elements = <SiteComponent>[];

    for (var x in json['elements']) {
      if (x['type'] == 'text') {
        elements.add(SiteComponent(
            id: x['id'],
            type: 'text',
            text: x['text'],
            isOpen: json['isOpen'],
            remove: rf));
      } else if (x['type'] == 'link') {
        elements.add(SiteComponent(
            id: x['id'],
            type: 'link',
            url: x['url'],
            isOpen: json['isOpen'],
            remove: rf));
      }
    }

    return Site(
      title: json['title'],
      sid: json['sid'],
      isOpen: json['isOpen'],
      elements: elements,
    );
  }
}
