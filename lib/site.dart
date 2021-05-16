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

  factory Site.fromJson(Map<String, dynamic> json) {
    var elements = <SiteComponent>[];

    for (var x in json['elements']) {
      if (x['type'] == 'text') {
        elements.add(SiteComponent(type: 'text', text: x['text']));
      } else if (x['type'] == 'link') {
        elements.add(SiteComponent(type: 'link', url: x['url']));
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
