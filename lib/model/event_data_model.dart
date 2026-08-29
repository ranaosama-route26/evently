class EventDataModel {
  String? eventID;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  bool isFavorite;
  String categoryImage;
  String categoryId;

  EventDataModel({
    this.eventID,
    this.isFavorite = false,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.categoryImage,
    required this.categoryId,
  });

  factory EventDataModel.fromFirestore(Map<String, dynamic> json) {
    return EventDataModel(
      eventID: json["eventId"],
      eventTitle: json["eventTitle"],
      eventDescription: json["eventDescription"],
      eventDate: DateTime.fromMillisecondsSinceEpoch(json["eventDate"]),
      categoryId: json["categoryId"],
      categoryImage: json["categoryImage"],
      isFavorite: json["isFavorite"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "eventId": eventID,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventDate": eventDate.millisecondsSinceEpoch,
      "isFavorite": isFavorite,
      "categoryImage": categoryImage,
      "categoryId": categoryId,
    };
  }
}
