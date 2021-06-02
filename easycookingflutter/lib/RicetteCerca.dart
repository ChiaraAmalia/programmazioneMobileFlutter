import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Ricette());
}

class Ricette extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Cooking',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: RicetteCerca(title: 'Ricette Cerca'),
    );
  }
}

class RicetteCerca extends StatefulWidget {
  RicetteCerca({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RicetteCercaState createState() => _RicetteCercaState();
}

class _RicetteCercaState extends State<RicetteCerca> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Dispensa',
      style: optionStyle,
    ),
    Text(
      'Cerca Ricette',
      style: optionStyle,
    ),
    Text(
      'RicetteTue',
      style: optionStyle,
    ),
    Text(
      'Lista della spesa',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                image: DecorationImage(image: AssetImage("assets/images/food.png"),
                fit:BoxFit.cover)
              ),
              child: Text(
                'Easy Cooking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Contattaci'),
              /*onTap: () {
                Navigator.of(context).pop();
              },*/
            ),
            ListTile(
              leading: Icon(Icons.wb_incandescent_outlined),
              title: Text('Ispirami'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.refrigerator ,color: Colors.red),
            label: 'Dispensa',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.rolling_pin, color: Colors.red),
            label: 'Cerca Ricette',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.apron, color: Colors.red),
            label: 'RicetteTue',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.vegetable_box, color: Colors.red),
            label: 'ListaSpesa',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}