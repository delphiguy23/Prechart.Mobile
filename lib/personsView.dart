import 'package:flutter/material.dart';

class PersonsView extends StatefulWidget {
  static const routeName = '/persons';

  @override
  State<PersonsView> createState() => _PersonsViewState();
}

class _PersonsViewState extends State<PersonsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persons'),
      ),
      // body: PersonsList(),
    );
  }
}
