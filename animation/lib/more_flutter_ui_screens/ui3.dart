import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:widget_with_codeview/widget_with_codeview.dart';


class MoreFlutterUI3 extends StatefulWidget {
  static const routeName = "/MoreFlutterUI3";

  @override
  _MoreFlutterUI3State createState() => _MoreFlutterUI3State();
}

class _MoreFlutterUI3State extends State<MoreFlutterUI3> {

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(title: Text('${routeArg["title"]}')),
        body: WidgetWithCodeView(
          child: SomeWidget(),
          sourceFilePath: 'lib/more_flutter_ui_screens/ui3.dart',
          iconBackgroundColor: Colors.white,
          iconForegroundColor: Colors.pink,
          labelBackgroundColor: Theme.of(context).canvasColor,
        ));
    // TODO: implement build
  }
}


class SomeWidget extends StatefulWidget {
  @override
  _SomeWidgetState createState() => new _SomeWidgetState();
}

class Sales {
  final String year;
  final int sales;
  Sales(this.year,this.sales);
}
class _SomeWidgetState extends State<SomeWidget> {

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