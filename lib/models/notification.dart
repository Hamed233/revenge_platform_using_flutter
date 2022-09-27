class NotificationModel {
  int? id;
  String? title;
  String? body;
  // String tag_notification;
  String date;
  String time;
  String? payload;
  int? is_open = 0;

  NotificationModel({
    required this.title,
    required this.body,
    // required this.tag_notification,
    required this.date,
    required this.time,
    required this.payload,
    this.is_open,
  });

  NotificationModel.withId({
    this.id,
    required this.title,
    required this.body,
    // required this.tag_notification,
    required this.date,
    required this.time,
    required this.payload,
    this.is_open,
  });

    Map<String, dynamic> toMap() {
      final map = Map<String, dynamic>();
      map['id'] = id;
      map['title'] = title;
      map['body'] = body;
      // map['tag_notification'] = tag_notification;
      map['date'] = date;
      map['time'] = time;
      map['payload'] = payload;
      map['is_open'] = is_open;
      return map;
    }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel.withId(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      // tag_notification: map['tag_notification'],
      date: map['date'],
      time: map['time'],
      payload: map['payload'],
      is_open: map['is_open'],
    );
  }

}