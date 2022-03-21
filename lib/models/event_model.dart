class EventModel {
  String? id;
  String? name;
  String? description;
  String? status;
  String? localDate;
  String? localTime;
  bool? isOnlineEvent;

  EventModel(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.localDate,
      this.localTime,
      this.isOnlineEvent});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    status = json['status'] ?? '';
    localDate = json['local_date'] ?? '';
    localTime = json['local_time'] ?? '';
    isOnlineEvent = json['is_online_event'] != null
        ? json['is_online_event'] as bool
        : false;
  }
}
