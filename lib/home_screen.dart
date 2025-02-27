import 'package:biblereels/collections/collections_screen.dart';
import 'package:biblereels/facts/all_facts_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const AllFactsScreen(),
    CollectionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 800;
    return Scaffold(
      body: Row(children: [
        if (isLargeScreen)
        NavigationRail(
          groupAlignment: 0,
          indicatorColor: const Color.fromARGB(71, 255, 255, 255),
          unselectedLabelTextStyle: const TextStyle(color: Colors.white),
          selectedLabelTextStyle: const TextStyle(color: Colors.white),
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          selectedIndex: currentIndex,
          labelType: NavigationRailLabelType.all,
          onDestinationSelected: (index) {
            setState(() => currentIndex = index);
          },
          backgroundColor: Colors.black,
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.auto_stories),
              label: Text('Stories'),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.collections),
              label: Text('Collections'),
            ),
          ]
        ),
        Expanded(child: screens[currentIndex])
      ]),
      bottomNavigationBar: isLargeScreen ? null : BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Stories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Collections',
          ),
        ],
        currentIndex: currentIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          setState(() => currentIndex = index);
        },
      )
    );
  }
}