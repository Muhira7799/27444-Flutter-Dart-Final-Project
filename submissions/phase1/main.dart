import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       // STATIC: App bar showing the app title
        appBar: AppBar(
          title: const Text('My Study Planner'),
          
        ),
      // STATIC: Heading and hard-coded study goal cards
        body: const Column(
        children: [
           Text('My Study Goals'),
          Card(
            child: ListTile(
              title: Text('Python'),
              subtitle: Text('study Python for 2 hours'),
            ),
           ),
             Card(
            child: ListTile(
              title: Text('Math'),
              subtitle: Text('study Math for 1 hour'),
            ),
           ),
             Card(
            child: ListTile(
              title: Text('Java'),
              subtitle: Text('study Java for 3 hours'),
            ),
           ),
            ],
        ),

        //STATIC: Add Button with '+' icon, with no functionality yet
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}                                                    