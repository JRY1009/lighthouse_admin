import 'dart:convert';

import 'package:flutter/material.dart';

class TabPageData {
  String id;
  String name;
  String url;

  TabPageData({
    this.id,
    this.name,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }

  factory TabPageData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TabPageData(
      id: map['id'],
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TabPageData.fromJson(String source) => TabPageData.fromMap(json.decode(source));
}
