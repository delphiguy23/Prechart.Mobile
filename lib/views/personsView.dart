import 'package:flutter/material.dart';
import 'package:prechart_mobile/endpoints/endpoints.dart';
import 'package:prechart_mobile/models/personModel.dart';
import 'package:prechart_mobile/providers/navigation_provider.dart';
import 'package:prechart_mobile/views/navigation.dart';
import 'package:prechart_mobile/providers/persons_provider.dart';
import 'package:prechart_mobile/views/personDetailedView.dart';
import 'package:provider/provider.dart';

class PersonsView extends StatefulWidget {
  static const routeName = '/persons';

  @override
  State<PersonsView> createState() => _PersonsViewState();
}

class _PersonsViewState extends State<PersonsView> {
  bool _isLoaded = false;
  List<Person>? persons;

  @override
  void initState() {
    super.initState();
    getPersons();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPersons() async {
    if (context.read<PersonsLists>().persons.isEmpty) {
      persons = await Endpoints().getEmployeePersons();

      context.read<PersonsLists>().clearPersons();

      if (persons != null && persons!.isNotEmpty) {
        context.read<PersonsLists>().setPersons(persons!);
      }
    }

    persons= context.read<PersonsLists>().persons;

    if (persons != null) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navigation(),
      appBar: AppBar(
        title: Text('Persons'),
      ),
      body: Visibility(
        visible: _isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
            itemCount: persons != null ? persons!.length : 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text( '${persons![index].significantAchternaam ?? ''} (${persons![index].voorletter ?? ''})'  ),
                leading: Icon(Icons.person),
                subtitle: Text(persons![index].sofiNr ?? ''),
                onTap: () async {
                  context.read<NavigationIndex>().setIndex(0);
                  await Future.delayed(const Duration(milliseconds: 600));
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => PersonDetailedView(persons![index])), (route) => false);
                },
              );
            }),
        ),
    );
  }
}

