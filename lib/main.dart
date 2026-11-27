import 'package:flutter/material.dart';

const orange = Color(0xFFF57E1E);
const pink = Color(0xFFF52380);

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: Phase2()),
);

// STATIC: stateful screen
class Phase2 extends StatefulWidget {
  const Phase2({super.key});

  @override
  State<Phase2> createState() => _Phase2State();
}

class _Phase2State extends State<Phase2> {
  // LOGIC: Calculate total study hours
int get totalHours =>
    goals.fold(0, (sum, goal) => sum + (goal['hours'] as int));

    //LOGIC: Calculate completed goals
int get completedGoals =>
    goals.where ((goal) => goal['done'] as bool).length;

    // LOGIC: Calculate remaining goals
int get remainingGoals =>
    goals.where ((goal) => !(goal['done'] as bool)).length;
  // LOGIC: list of 5 goal maps
  var goals = [
    {'subject': 'Mathematics', 'hours': 5, 'done': false},
    {'subject': 'Mobile App Development', 'hours': 8, 'done': false},
    {'subject': 'Databases', 'hours': 4, 'done': false},
    {'subject': 'Networking', 'hours': 3, 'done': false},
    {'subject': 'Operating Systems', 'hours': 6, 'done': false},
  ];

  // LOGIC: subject names for new goals
  var subjects = [
    'Data Structures',
    'Software Testing',
    'Artificial Intelligence',
    'Computer Security',
    'Web Engineering',
  ];

  // LOGIC: add a subject goal
  void addGoal() => setState(() {
    goals.add({
      'subject': subjects[goals.length % subjects.length],
      'hours': 3,
      'done': false,
    });
  });

  // LOGIC: toggle done
  void toggleGoal(int i) => setState(() {
    goals[i]['done'] = !(goals[i]['done'] as bool);
  });

  // LOGIC: remove goal
  void deleteGoal(int i) => setState(() => goals.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      // STATIC: gradient top bar
      appBar: AppBar(
        title: const Text('My Study Planner'),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [orange, pink]),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // STATIC: welcome banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [pink, orange]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.school, color: Colors.white, size: 34),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Ready to study?\nPlan your goals and crush them!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //STATIC: statistics row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
            children: [
              Expanded(
                child: StatisticsCard(
                  title: 'Total Hours',
                  value: totalHours,
                  color: orange,
                ),
              ),
              Expanded(
                child: StatisticsCard(
                  title: 'Completed Goals',
                  value: completedGoals,
                  color: pink,
                ),
              ),
              Expanded(
                child: StatisticsCard(
                  title: 'Remaining Goals',
                  value: remainingGoals,
                  color: orange,
                ),
              ),
              ],
            ),
          ),
          // STATIC: heading
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'My Study Goals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          // CONNECTION: connects goals list and logic to ListView.builder
          Expanded(
            child: goals.isEmpty
                ? const Center(
                    child: Text(
                      'No goals yet. Tap "Add goal" to get started!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: goals.length,
              itemBuilder: (context, i) {
                var g = goals[i];
                var done = g['done'] as bool;
                // STATIC: goal card
                return Card(
                  color: done ? Colors.grey.shade200 : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    onTap: () => toggleGoal(i),
                    leading: Checkbox(
                      value: done,
                      activeColor: i.isEven ? orange : pink,
                      onChanged: (_) => toggleGoal(i),
                    ),
                    title: Text(
                      g['subject'] as String,
style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('${g['hours']} hours'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: pink),
                      onPressed: () => deleteGoal(i),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // CONNECTION: connects button to addGoal
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGoalScreen()),
          );
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              goals.add({
                'subject': result['subject'],
                'hours': result['hours'],
                'done': false,
              });
            });
          }
        },
        backgroundColor: pink,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add goal'),
      ),
    );
  }
}
//STATIC: Reusable Statistics card widget
class StatisticsCard extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  const StatisticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//STATI: Add goal screen
class AddGoalScreen extends StatefulWidget {

  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  String? errorMessage;
  @override     
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Goal'),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [orange, pink]),
          ),
        ),
      ),

     body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: _hoursController,
              decoration: const InputDecoration(labelText: 'Hours'),
              keyboardType: TextInputType.number,
            ),
            if(errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final subject = _subjectController.text;
                final hours = int.tryParse(_hoursController.text) ?? 0;
                if (subject.trim().isNotEmpty && hours > 0) {
                  Navigator.pop(context, {'subject': subject, 'hours': hours});
                } else {
  setState(() {
    errorMessage = 'Please enter a valid subject and hours.';
  });
}
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: pink,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add Goal'),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {  
    _subjectController.dispose();
    _hoursController.dispose();
    super.dispose();
  }
}