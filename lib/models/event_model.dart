class EventModel {
  String? eventName;
  String? eventDescription;
  String? eventDate;
  String? eventStatus;

  EventModel(
      {this.eventName,
      this.eventDescription,
      this.eventDate,
      this.eventStatus});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    eventDate = json['event_date'];
    eventStatus = json['event_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['event_name'] = eventName;
    data['event_description'] = eventDescription;
    data['event_date'] = eventDate;
    data['event_status'] = eventStatus;
    return data;
  }
}
