import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

import '../components/scaffold_widget.dart';

class MoreFlutterUI1 extends StatefulWidget {
  static const routeName = "/MoreFlutterUI1";

  @override
  _MoreFlutterUI1State createState() => _MoreFlutterUI1State();
}

class _MoreFlutterUI1State extends State<MoreFlutterUI1> {

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
          sourceFilePath: 'lib/more_flutter_ui_screens/ui1.dart',
          iconBackgroundColor: Colors.white,
          iconForegroundColor: Colors.pink,
          labelBackgroundColor: Theme.of(context).canvasColor,
        ));
    // TODO: implement build
  }
}

  class SomeWidget extends StatefulWidget {
    @override
    _SomeWidgetState createState() => _SomeWidgetState();
  }
  
  class _SomeWidgetState extends State<SomeWidget> {
    late List<Step> _steps;
    late int _current;

    @override
    void initState() {
      _current = 0;
      _steps = <Step>[
        Step(title: Text('Order Prepared'), content: Text('Order Prepared'),
            isActive: false),
        Step(title: Text('Out for delivery'), content: Text('Out for delivery'),
            isActive: false),
        Step(title: Text('Delivered'),
            content: Text('Delivered'),
            isActive: false),
      ];
    }

    void _stepContinue() {
      setState(() {
        _current++;
        if (_current >= _steps.length) _current = _steps.length - 1;
      });
    }

    void _stepCancel() {
      setState(() {
        _current--;
        if (_current < 0) _current = 0;
      });
    }

    void _stepTap(int index) {
      setState(() {
        _current = index;
      });
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Stepper(
              steps: _steps,
              type: StepperType.vertical,
              currentStep: _current,
              onStepCancel: _stepCancel,
              onStepContinue: _stepContinue,
              onStepTapped: _stepTap,
            ),
          ),
        ),
      );
    }
  }
  