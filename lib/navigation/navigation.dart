
import 'package:flutter/material.dart';
import 'package:learning_b/navigation/home.dart';
import 'package:learning_b/navigation/profile.dart';
import 'package:learning_b/navigation/reservations.dart';
import 'package:learning_b/navigation/top.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_b/modules/map/map_sample.dart';

class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    home(),
    top(),
    reservations(),
    profile(),
    MapSample(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkTutorial();
  }

  Future<void> _checkTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isTutorialDone = prefs.getBool('tutorialDone');
    final previousRouteName = ModalRoute.of(context)?.settings.arguments;
    if (previousRouteName != "tutorial") {
      if (isTutorialDone == null) {
        Navigator.pushNamed(context, "/tutorial");
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Top 5',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_service),
            label: 'Reservacion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapaa',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}









