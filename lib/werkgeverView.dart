// https://prd-zekerheyd-person.prechart.com/
// https://prd-zekerheyd-user.prechart.com/
// https://prd-zekerheyd-werkgever.prechart.com/

import 'package:flutter/material.dart';

import 'endpoints/endpoints.dart';
import 'models/werkgeverModel.dart';
import 'package:prechart_mobile/werkgeverDetailedView.dart';

class WerkgeverView extends StatefulWidget {
  static const routeName = '/werkgever';

  @override
  State<WerkgeverView> createState() => _WerkgeverViewState();
}

class _WerkgeverViewState extends State<WerkgeverView> {
  bool _isLoaded = false;
  List<Werkgever>? werkgevers;

  @override
  void initState() {
    super.initState();
    getWerkgevers();
    print('initState');
  }

  @override
  void dispose() {
    getWerkgevers();
    super.dispose();
  }

  getWerkgevers() async {
    print('bla');
    werkgevers = await Endpoints().getWerkgevers();

    if (werkgevers != null) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Werkgever'),
      ),
      body: Visibility(
        visible: _isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
            itemCount: werkgevers != null ?  werkgevers!.length : 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(werkgevers![index].naam ?? ''),
                leading: Icon(Icons.work),
                trailing: Icon(Icons.developer_board),
                subtitle: Text(werkgevers![index].fiscaalNummer),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WerkgeverDetailsView(
                            werkgevers![index],
                          ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}