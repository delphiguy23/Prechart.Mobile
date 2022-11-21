import 'package:flutter/material.dart';
import 'package:prechart_mobile/providers/werkgever_provider.dart';
import 'package:prechart_mobile/views/navigation.dart';
import 'package:provider/provider.dart';

import '../endpoints/endpoints.dart';
import '../models/werkgeverModel.dart';
import 'package:prechart_mobile/views/werkgeverDetailedView.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  getWerkgevers() async {
    if (context.read<WerkgeversLists>().werkgevers.isEmpty) {
      werkgevers = await Endpoints().getWerkgevers();

      if (werkgevers != null && werkgevers!.isNotEmpty) {
        context.read<WerkgeversLists>().setWerkgevers(werkgevers!);
      }
    }

    werkgevers= context.read<WerkgeversLists>().werkgevers;

    if (werkgevers != null) {
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
        title: const Text('Werkgever'),
      ),
      body: Visibility(
        visible: _isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
            itemCount: werkgevers != null ?  werkgevers!.length : 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(werkgevers?[index].naam ?? ''),
                leading: const Icon(Icons.work),
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