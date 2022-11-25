import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prechart_mobile/endpoints/endpoints.dart';
import 'package:prechart_mobile/models/personModel.dart';
import 'package:prechart_mobile/providers/navigation_provider.dart';
import 'package:prechart_mobile/providers/persons_provider.dart';
import 'package:prechart_mobile/providers/user_token_provider.dart';
import 'package:prechart_mobile/views/personDetailedView.dart';
import 'package:provider/provider.dart';

class WerkgeverPersons extends StatefulWidget{
  final String fiscaalNummer;

  WerkgeverPersons({required this.fiscaalNummer});

  @override
  State<WerkgeverPersons> createState() => _WerkgeverPersonsState();
}

class _WerkgeverPersonsState extends State<WerkgeverPersons> {
  List<Person>? persons ;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    getPersons();
  }

  getPersons() async {
    persons = context.read<PersonsLists>().personsWerkgever(taxno: widget.fiscaalNummer);
    var tokens = context.read<UserTokens>().user;

    if (persons == null || (persons?.isEmpty ?? true)) {
      persons = await Endpoints().getEmployeePersons(tokens);

      if (persons != null && persons!.isNotEmpty) {
        context.read<PersonsLists>().setPersons(persons!);
      }
    }

    persons = context.read<PersonsLists>().personsWerkgever(taxno: widget.fiscaalNummer);

    if (persons != null) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isLoaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: ListView.builder(
          itemCount: persons != null ?  persons!.length : 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text( '${persons![index].significantAchternaam ?? ''} (${persons![index].voorletter ?? ''})'  ),
              leading: Icon(Icons.person),
              subtitle: Text(persons![index].sofiNr ?? ''),
              onTap: () async {
                context.read<NavigationIndex>().setIndex(0);
                await Future.delayed(const Duration(milliseconds: 200));
                Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => PersonDetailedView(persons![index])), (route) => false);
              },
            );
          }),
    );
  }
}