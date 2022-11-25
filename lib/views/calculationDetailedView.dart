import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculationDetails extends StatefulWidget {
  static const routeName = '/calculationdetails';

  // final int? woonlandId;
  // final String? processDatum;
  // final int? loontijdvak;
  // final double? incomeWit;
  // final double? incomeGroen;
  // final String? birthDate;
  // final double? basisDagen;
  // final String? taxNo;
  // final bool? algemeneInd;

  // const CalculationDetails({
  //   Key? key,
  //   // this.woonlandId,
  //   // this.processDatum,
  //   // this.loontijdvak,
  //   // this.incomeWit,
  //   // this.incomeGroen,
  //   // this.birthDate,
  //   // this.basisDagen,
  //   // this.taxNo,
  //   // this.algemeneInd,
  // }) : super(key: key);

  @override
  State<CalculationDetails> createState() => _CalculationDetailsState();
}

class _CalculationDetailsState extends State<CalculationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Calculation View')],
        ),
      ),
    );
  }
}
