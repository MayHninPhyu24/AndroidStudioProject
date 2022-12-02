import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class MoreFlutterUI5 extends StatefulWidget {
  static const routeName = "/MoreFlutterUI5";
  @override
  _MoreFlutterUI5State createState() => new _MoreFlutterUI5State();
}

class Sales {
  final int year;
  final int sales;
  charts.Color color;

  Sales(this.year,this.sales,this.color);
}
class _MoreFlutterUI5State extends State<MoreFlutterUI5> {

  List<Sales> _data = <Sales>[];

  final List<charts.Series<Sales, int>> _chartdata = <charts.Series<Sales, int>>[];

  void _makeData() {
    _data = <Sales>[
      new Sales(0,100, charts.MaterialPalette.red.shadeDefault),
      new Sales(1,75, charts.MaterialPalette.blue.shadeDefault),
      new Sales(2,25, charts.MaterialPalette.green.shadeDefault),
      new Sales(3,5, charts.MaterialPalette.yellow.shadeDefault),
    ];

    _chartdata.add( charts.Series(
        id: 'Sales',
        //colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault, //Old version
        data: _data,
        colorFn: (Sales sales,__) => sales.color,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        displayName: 'sales'
    )
    );
  }

  @override
  void initState() {
    _makeData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Charts'),
      ),
      body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
          child: Column(
            children: <Widget>[
              Text('Sales Data'),
              //new Expanded(child: new charts.BarChart<Sales>(_chartdata))
              Expanded(child: new charts.PieChart<dynamic>( //new version
                  _chartdata,
                  animate: true,
                  animationDuration: new Duration(seconds: 5)
              )),
            ],
          ),
        ),
      ),
    );
  }
}