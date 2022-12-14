import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:person_portal/controller/menu_controller.dart';
import 'package:person_portal/widget/menu_widget.dart';

class MainPage extends GetView<MenuController>{
  @override
  Widget build(BuildContext context) => Scaffold(
    // backgroundColor: Colors.indigo,
    appBar: AppBar(
      title: const Text('Main'),
      automaticallyImplyLeading: false,
      leading: MenuWidget(),

    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.person,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'Main',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome to the main page',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
  );
}

