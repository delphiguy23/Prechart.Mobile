import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prechart_mobile/endpoints/endpoints.dart';
import 'package:prechart_mobile/models/personModel.dart';

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
    print('getPersons');
    persons = await Endpoints().getPersons(widget.fiscaalNummer);

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
              // onTap: () {
              //   Navigator.of(context).pushNamed('/person', arguments: persons![index].fiscaalNummer);
              // },
            );
          }),
      // child: Container(
      //   child: Column(
      //     children: <Widget>[
      //       ListTile(
      //         title: Text('Fiscaalnummer'),
      //         subtitle: Text(widget.fiscaalNummer),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}