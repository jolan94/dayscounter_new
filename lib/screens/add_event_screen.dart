import 'package:dayscounter/models/event.dart';
import 'package:dayscounter/screens/home_screen.dart';
import 'package:dayscounter/utils/event_data.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Initially selected date
  final TextEditingController notesController = TextEditingController();

  Color selectedColor = Colors.blue; // Initially selected color
  IconData selectedIcon = Icons.event; // Initially selected icon

  final List<Color> colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

  final List<IconData> iconOptions = [
    Icons.event,
    Icons.shopping_cart,
    Icons.work,
    Icons.school,
    Icons.favorite,
    Icons.music_note,
    Icons.restaurant,
    Icons.beach_access,
    Icons.sports,
    Icons.star,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Event Name'),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: selectedDate.toString().split(' ')[0],
                  ),
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
              ),
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: 20.0),
            const Text('Select a color:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: colorOptions
                  .map(
                    (color) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: color == selectedColor
                                ? Colors.black
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20.0),
            const Text('Select an icon:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: iconOptions
                  .map(
                    (icon) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                      child: Icon(
                        icon,
                        size: 30.0,
                        color:
                            icon == selectedIcon ? Colors.black : Colors.grey,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final notes = notesController.text;

                final newEvent = Event(
                  name: name,
                  date: selectedDate,
                  notes: notes,
                  color: selectedColor,
                  icon: selectedIcon,
                );

                // Handle adding the event to the list or database
                events.add(newEvent);

                // Navigate back to the home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
