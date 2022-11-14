import 'package:flutter/material.dart';

import 'models/werkgeverModel.dart';
import 'tabs/werkgever/werkgeverInfo.dart';
import 'tabs/werkgever/werkgeverWhk.dart';
import 'tabs/werkgever/werkgeverCollectieve.dart';
import 'tabs/werkgever/werkgeverPersons.dart';

class WerkgeverDetailsView extends StatelessWidget {
  static const routeName = '/werkgeverDetails';

  final Werkgever werkgever;

  WerkgeverDetailsView(this.werkgever);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(werkgever.naam ?? ''),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Werkgever'),
              Tab(text: 'Whk'),
              Tab(text: 'Collectief'),
              Tab(text: 'Person'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WerkgeverInfo(werkgever: werkgever),
            WerkgeverWhk(werkgever: werkgever),
            WerkgeverCollectieve(werkgever: werkgever),
            WerkgeverPersons(fiscaalNummer:werkgever.fiscaalNummer),
          ],
        ),
      ),
    );
  }
}
