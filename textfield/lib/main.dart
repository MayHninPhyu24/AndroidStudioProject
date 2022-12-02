import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home:new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  String _value = "";
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  int _radio1 = 0;
  int _radio2 = 0;
  bool _switch1 =false;
  bool _switch2 = false;
  double _slider1 = 0.0;
  String _datepicker1 = '';

    void _onChanged1(bool? value) => setState(()=>_checkbox1 = value!);
    void _onChanged2(bool? value) => setState(()=>_checkbox2 = value!);

    void _onChange(String value){
      setState(()=>_value = 'Change: ${value}');
    }
    void _onSubmit(String value){
      setState(()=>_value = 'Submit: ${value}');
    }
    void _setValue1(int? value) => setState(()=> _radio1 = value!);
    void _setValue2(int? value) => setState(()=> _radio2 = value!);

    Widget makeRadios() {
      List<Widget> list = <Widget> [];
      for (int i=0; i<3; i++){
        list.add(Radio(value:i, groupValue:_radio1,onChanged:_setValue1));
      }
      Column column = Column(children:list,);
      return column;
    }

    Widget makeRadioTiles() {
      List<Widget> list = <Widget> [];

      for (int i=0; i<3; i++){
        list.add(new RadioListTile(
            value:  i,
            groupValue: _radio2,
            onChanged:  _setValue2,
            activeColor:  Colors.green,
            controlAffinity: ListTileControlAffinity.trailing,
            title: new Text('Item:${i}'),
            subtitle: new Text('sub title'),
        ));
      }
      Column column = Column(children:list,);
      return column;
    }

    void _onChangedSwitch1(bool? value) => setState(()=>_switch1 = value!);
    void _onChangedSwitch2(bool? value) => setState(()=>_switch2 = value!);

    void _setValueSlider(double? value) => setState(() => _slider1 = value!);

    Future _selectDate() async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime(2016),
          lastDate: new DateTime(2099)
        );
        if(picked != null) setState(()=> _datepicker1 = picked.toString());
        
}

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Name Here'),
        ),
        body: Container (
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(_value),
                TextField(
                  decoration : new InputDecoration(
                      labelText : "Name",
                      hintText: "Eg.Mg Mg",
                      icon: new Icon(Icons.people)
                  ),
                  autocorrect: true,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  onChanged: _onChange,
                  onSubmitted: _onSubmit,
                ),
                //Checkbox(value: _checkbox1, onChanged: _onChanged1),
                CheckboxListTile(
                  value: _checkbox2,
                  onChanged: _onChanged2,
                  title: new Text('Male'),
                  controlAffinity: ListTileControlAffinity.leading,
                  subtitle: new Text('Gender'),
                  secondary: new Icon(Icons.archive),
                  activeColor: Colors.red,
                ),
                //makeRadios(),
                //makeRadioTiles(),
                //new Switch(value: _switch1, onChanged: _onChangedSwitch1),
                new SwitchListTile(
                  value: _switch2,_selectDate
                  onChanged: _onChangedSwitch2,
                  title: new Text('Hello World',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ))
                  ),
                new Text('Value: ${(_slider1 * 100).round()}'),
                new Slider(value: _slider1, onChanged: _setValueSlider),
                new Text(_datepicker1),
                new RaisedButton(onPressed:_selectDate,child:new Text('Click Me'))
              ],
            ),
          ),

        ),
      );
    }
  }
