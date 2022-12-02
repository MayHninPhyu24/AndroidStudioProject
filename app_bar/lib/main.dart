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
  int _value = 0;
  String _date_time = '';
  String _footer = '';
  List<BottomNavigationBarItem> _items = ArrayList<>();

  int _index = 0;
  String _navValue = '';

  void _add()=>setState(()=> _value++);
  void _remove()=>setState(()=> _value--);

  void _onClicked()=>setState(()=> _date_time= new DateTime.now().toString());
  void _onFooterClick(String value)=>setState(()=> _footer= value);

  void initState() {
    _items.add(new BottomNavigationBarItem(icon:new Icon(Icons.people),title:Text('People')));
    _items.add(new BottomNavigationBarItem(icon:new Icon(Icons.map),title:Text('Map')));
    _items.add(new BottomNavigationBarItem(icon:new Icon(Icons.message),title:Text('message')));
  };
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: _add,),
          IconButton(icon: Icon(Icons.remove), onPressed: _remove,),
        ]
      ),
    drawer: Drawer(
      child: Container(
        padding:EdgeInsets.all(32.0),
        child: Column(
          children:<Widget> [
            Text("Hello Drawer"),
            RaisedButton(onPressed: ()=>Navigator.pop(context),child:Text('Close'),)
          ],
        )
      ),
    ),
    persistentFooterButtons: <Widget>[
      new IconButton(icon: new Icon(Icons.timer), onPressed: () => _onFooterClick('Button 1')),
      new IconButton(icon: new Icon(Icons.people), onPressed: () => _onFooterClick('Button 2')),
      new IconButton(icon: new Icon(Icons.map), onPressed: () => _onFooterClick('Button 3')),
      new IconButton(icon: new Icon(Icons.celebration), onPressed: () => _onFooterClick('Button 3')),
      new IconButton(icon: new Icon(Icons.title), onPressed: () => _onFooterClick('Button 3')),
      new IconButton(icon: new Icon(Icons.map), onPressed: () => _onFooterClick('Button 3')),
      new IconButton(icon: new Icon(Icons.map), onPressed: () => _onFooterClick('Button 3')),
    ],

    floatingActionButton:FloatingActionButton(
        onPressed:_onClicked,
        backgroundColor: Colors.redAccent,
        mini:false,
        child:Icon(Icons.timer),
    ),
    body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
            child: Column(
              children: <Widget>[
                Text(_value.toString(),style: new TextStyle(fontWeight:FontWeight.bold,fontSize: 37.0),),
                Text(_date_time.toString()),
                Text(_footer),
              ],
            )
        ),
    ),
      bottomNavigationBar: new BottomNavigationBar(
        items: _items,
        fixedColor: Colors.blue,
        currentIndex: _index,
        onTap: (int item) {
          setState((){
            _index = item;
            _navValue = "Current value is: ${_index.toString()}";
          });
        },

      ),
    );
  }
}