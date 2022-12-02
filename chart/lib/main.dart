import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(new MaterialApp(
    home:new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class Sales {
  final String year;
  final int sales;
  Sales(this.year,this.sales);
}
class _State extends State<MyApp> {

  List<Sales> _laptop = <Sales>[];
  List<Sales> _desktop = <Sales>[];

  List<charts.Series<Sales, String>> _chartdata = <charts.Series<Sales, String>>[];

  void _makeData() {
    final rnd = Random();
    for(int i = 2010; i < 2019; i++) {
      _laptop.add(Sales(i.toString(), rnd.nextInt(1000)));
      _desktop.add(Sales(i.toString(), rnd.nextInt(1000)));
    }
    _chartdata.add( charts.Series(
        id: 'Sales',
        //colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault, //Old version
        colorFn: (Sales sales,__) => charts.MaterialPalette.red.shadeDefault,
        data: _laptop,
        domainFn: (Sales sales, _) => sales.year, //Show Row Text
        measureFn: (Sales sales, _) => sales.sales, //Shoe Column Text
        //fillPatternFn: (_,__) => charts.FillPatternType.forwardHatch, // Old version
        fillPatternFn: (Sales sales,__) => charts.FillPatternType.solid, //forwardHatch,solid etc
        displayName: 'sales'
    )
    );
    _chartdata.add( charts.Series(
        id: 'Sales',
        //colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault, //Old version
        colorFn: (Sales sales,__) => charts.MaterialPalette.green.shadeDefault,
        data: _desktop,
        domainFn: (Sales sales, _) => sales.year, //Show Row Text
        measureFn: (Sales sales, _) => sales.sales, //Shoe Column Text
        //fillPatternFn: (_,__) => charts.FillPatternType.forwardHatch, // Old version
        fillPatternFn: (Sales sales,__) => charts.FillPatternType.solid, //forwardHatch,solid etc
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
              Text('Sales Data Bar Chart'),
              //new Expanded(child: new charts.BarChart<Sales>(_chartdata))
              Expanded(child: charts.BarChart(_chartdata,vertical:false)), //default=>vertical:true
            ],
          ),
        ),
      ),
    );
  }
}