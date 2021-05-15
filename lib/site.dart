import 'package:flutter/cupertino.dart';

class SiteElement {
  String type;
}

class Site {
  String title;
  final int sid;
  bool isOpen;
  var elements = [];

  Site({
    @required this.title,
    @required this.sid,
    @required this.isOpen,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      title: json['title'],
      sid: json['sid'],
      isOpen: json['isOpen'],
    );
  }
}
