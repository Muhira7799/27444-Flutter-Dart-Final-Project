import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //LOGIC: Store study goals 
  List<Map<String, dynamic>> goals = [
    {'subject': 'Python', 'hours': 2, 'done': false},
    {'subject': 'Math', 'hours': 1, 'done': false},
    {'subject': 'Java', 'hours': 3, 'done': false},
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         //STATIC: AppBar showing the app title
        appBar: AppBar(
          title: const Text('My Study Planner'),
      
        ),
        
        // LOGIC: Build the goal list from data
       // CONNECTION: Connect the goals list to the UI
        body: ListView.builder(
          itemCount: goals.length,
          itemBuilder: (context, index) {
            final goal = goals[index];
            return Card(
              child: ListTile(
                title: Text(
                  goal['subject'],
                  style:TextStyle(
                    decoration: goal['done'] 
                    ? TextDecoration.lineThrough
                     : TextDecoration.none,
                  ),
                  ),
                 subtitle: Text( 'Study for ${goal['hours']} hours',
              
                ),
                trailing: Row(
                 mainAxisSize: MainAxisSize.min,
                children: [
                  // LOGIC: Update goal completion status
                  Checkbox(
                    value: goal['done'],
                    onChanged: (value) {
                      setState(() {
                        goals[index]['done'] = value!;
                      });
                    },
                  ),
                  // LOGIC: Delete a goal
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        goals.removeAt(index);
                      });
                    },
                  ),
                ]
               
              ),
            ),
      
        );
           },
         ),
// CONNECTION: Add a sample goal when the button is pressed
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              goals.add({
                'subject': 'New Subject',
                 'hours': 1,
                  'done': false,
                  });
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}       