import 'package:flutter/material.dart';
import 'main.dart';

class EditChoreScreen extends StatefulWidget {
  final Chore chore;
  final Function(Chore) onUpdateChore;

  EditChoreScreen({required this.chore, required this.onUpdateChore});

  @override
  _EditChoreScreenState createState() => _EditChoreScreenState();
}

class _EditChoreScreenState extends State<EditChoreScreen> {
  late TextEditingController _choreNameController;
  late String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _choreNameController = TextEditingController(text: widget.chore.name);
    _selectedStatus = widget.chore.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Chore'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _choreNameController,
              decoration: InputDecoration(labelText: 'Chore Name'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedStatus,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
              items: <String>['Pending', 'In Progress', 'Completed']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Update Chore'),
              onPressed: () {
                final updatedChore = Chore(
                  id: widget.chore.id, // Keep the same ID
                  name: _choreNameController.text,
                  status: _selectedStatus!,
                );
                widget.onUpdateChore(updatedChore);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
