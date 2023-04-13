import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hookwidget_test/SettingsPage.dart';

import 'DrawerWidget.dart';
import 'Timer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

class MyStatefulWidget extends HookWidget {
  MyStatefulWidget({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> widgetOptions = <Widget>[
    const SettingsPage(),
    const Pomodoro(),
    Center(
      child: ElevatedButton(
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: const Text('Open Drawer'),
      ),
    ),
  ];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(1);
    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF7562E0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF7562E0),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Pomodoro App'),
      ),
      // drawer:
      body: Center(
        child: widgetOptions.elementAt(selectedIndex.value),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: const Color(0xFF7562E0),
        items: [
          Icon(Icons.settings),
          Icon(Icons.timer),
          Icon(Icons.person),
        ],
        onTap: onItemTapped,
        animationDuration: Duration(milliseconds: 300),
      ),
      drawer: const Drawer2(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
