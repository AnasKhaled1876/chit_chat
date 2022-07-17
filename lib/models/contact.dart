import 'package:flutter/material.dart';

class Contact {
  final String name;
  final Image image;

  Contact(this.name, this.image, this.recentMessage);

  final String recentMessage;
}
