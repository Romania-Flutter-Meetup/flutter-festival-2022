import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/event_model.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Date: ${args.localDate} ${args.localTime}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Event is: ${args.isOnlineEvent == true ? "Online" : "Offline"}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Html(
              data: args.description,
            ),
          ],
        ),
      ),
    );
  }
}
