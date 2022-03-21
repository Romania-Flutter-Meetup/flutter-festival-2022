import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_festival_romania_meetup_2022/models/photo_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';

import '../helpers/network.dart';
import '../models/event_model.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool _isLoaded = false;
  List<PhotoModel> photos = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> initApp() async {
    await loadData();
    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> loadData() async {
    Response response = await Network.loadPhotos(event_id: args.id ?? '');

    if (response.statusCode == 200) {
      List<dynamic> photos = jsonDecode(response.body);
      print(response.body);
      setState(() {
        photos = photos.map((e) => PhotoModel.fromJson(e)).toList();
      });
    }
    //TODO: treat the error
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;
    if (!_isLoaded) {
      initApp();
    }
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
