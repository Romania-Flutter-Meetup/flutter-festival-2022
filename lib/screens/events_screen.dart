import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_festival_romania_meetup_2022/helpers/network.dart';
import 'package:flutter_festival_romania_meetup_2022/models/event_model.dart';
import 'package:http/http.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool _isLoaded = false;
  List<String> items = [];
  List<EventModel> eventsObjects = [];

  final ScrollController _controller = ScrollController();
  String status = '';

  @override
  void initState() {
    super.initState();

    _controller.addListener(_scrollListener);
    items = List<String>.generate(50, (index) => 'Item $index');

    initApp();
  }

  Future<void> initApp() async {
    await loadData();
    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> loadData() async {
    Response response = await Network.loadEvents(status: 'upcoming,past');

    if (response.statusCode == 200) {
      List<dynamic> events = jsonDecode(response.body);

      setState(() {
        eventsObjects = events.map((e) => EventModel.fromJson(e)).toList();
      });
    }
    //TODO: treat the error
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        status = "You reached the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        status = "You reached the top";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GDG Events'),
      ),
      body: !_isLoaded
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : Column(
              children: [
                Container(
                  height: 50.0,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _moveUp,
                        child: Text("Up"),
                      ),
                      Text(status),
                      ElevatedButton(
                        onPressed: _moveDown,
                        child: Text("Down"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                      setState(() {
                        status = 'Scrolling started at - ' +
                            scrollNotification.metrics.pixels
                                .toStringAsFixed(2);
                      });
                    } else if (scrollNotification is ScrollUpdateNotification) {
                      setState(() {
                        status = 'Scrolling updated at - ' +
                            scrollNotification.metrics.pixels
                                .toStringAsFixed(2);
                      });
                    } else if (scrollNotification is ScrollEndNotification) {
                      setState(() {
                        status = 'Scrolling ended at - ' +
                            scrollNotification.metrics.pixels
                                .toStringAsFixed(2);
                      });
                    }

                    return true;
                  },
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: eventsObjects.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/event',
                              arguments: eventsObjects[index]);
                        },
                        title: Text(eventsObjects[index].name ?? ''),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${eventsObjects[index].localDate} ${eventsObjects[index].localTime}'),
                            Text(
                              'Is online: ${eventsObjects[index].isOnlineEvent == true ? "Online" : "Offline"}',
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )),
              ],
            ),
    );
  }

  _moveUp() {
    _controller.animateTo(_controller.offset - 50,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  _moveDown() {
    _controller.animateTo(_controller.offset + 50,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }
}
