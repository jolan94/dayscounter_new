import 'package:dayscounter/screens/add_event_screen.dart';
import 'package:dayscounter/utils/event_data.dart';
import 'package:dayscounter/widgets/event_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: events.isEmpty
          ? const Center(
              child: Text(
                'No events added \n Click + to add events',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(event: event);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              events;
            });
          }
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: ((context) => AddEventScreen())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
