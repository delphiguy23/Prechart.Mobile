import 'package:flutter/material.dart';

Widget LineListTile(String? title, String? text) {
  return ListTile(
    isThreeLine: true,
    title: Text(title ?? ''),
    subtitle: Text(text ?? ''),
  );
}