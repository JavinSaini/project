import 'package:flutter/material.dart';
import 'add_chore_screen.dart';
import 'edit_chore_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(ChoresMateApp());
}

class ChoresMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChoresMate',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ChoresListScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChoresMate'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Chores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ChoresListScreen extends StatefulWidget {
  @override
  _ChoresListScreenState createState() => _ChoresListScreenState();
}

class _ChoresListScreenState extends State<ChoresListScreen> {
  List<Chore> chores = [
    Chore(id: '1', name: 'Dishes', status: 'Pending'),
    Chore(id: '2', name: 'Vacuum Living Room', status: 'In Progress'),
    Chore(id: '3', name: 'Take out Trash', status: 'Completed'),
  ];

  void addChore(Chore newChore) {
    setState(() {
      chores.add(newChore);
    });
  }

  void updateChore(Chore updatedChore) {
    setState(() {
      int index = chores.indexWhere((chore) => chore.id == updatedChore.id);
      if (index != -1) {
        chores[index] = updatedChore;
      }
    });
  }

  void deleteChore(String id) {
    setState(() {
      chores.removeWhere((chore) => chore.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chores.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.task_alt, color: _getStatusColor(chores[index].status)),
            title: Text(chores[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Status: ${chores[index].status}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditChoreScreen(
                          chore: chores[index],
                          onUpdateChore: updateChore,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteChore(chores[index].id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.red;
      case 'In Progress':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class Chore {
  String id;
  String name;
  String status;

  Chore({required this.id, required this.name, required this.status});
}
