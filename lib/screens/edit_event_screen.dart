import 'package:dayscounter/models/event.dart';
import 'package:dayscounter/screens/home_screen.dart';
import 'package:dayscounter/utils/event_data.dart';
import 'package:flutter/material.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;

  const EditEventScreen({super.key, required this.event});

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
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
  void initState() {
    super.initState();
    // Initialize the text fields and selected color/icon with the current event details
    nameController.text = widget.event.name;
    dateController.text = widget.event.date.toString();
    notesController.text = widget.event.notes;
    selectedColor = widget.event.color;
    selectedIcon = widget.event.icon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Event Name'),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date'),
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
                final date = DateTime.parse(dateController.text);
                final notes = notesController.text;

                final newEvent = Event(
                  name: name,
                  date: date,
                  notes: notes,
                  color: selectedColor,
                  icon: selectedIcon,
                );
                // Handle adding the event to the list or database
                int indexOld = events
                    .indexWhere((element) => element.name == widget.event.name);
                events.removeAt(indexOld);
                events.add(newEvent);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
                // Handle updating the event details in the list or database
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
