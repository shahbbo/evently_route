class EventModel {
  static const String collectionName = 'Events';
  String? id;
  String? category;
  String? image;
  String? title;
  String? description;
  String? date;
  String? time;
  double? lat;
  double? long;
  bool? isFavorite;

  EventModel({
    this.id = '',
    this.category,
    this.image,
    this.title,
    this.description,
    this.date,
    this.time,
    this.lat,
    this.long,
    this.isFavorite,
  });

  EventModel.fromJson(dynamic json) {
    id = json['id'];
    category = json['category'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    lat = json['lat'];
    long = json['long'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() => {
        'id': id ?? '',
        'category': category,
        'image': image,
        'title': title,
        'description': description,
        'date': date,
        'time': time,
        'lat': lat,
        'long': long,
        'isFavorite': isFavorite,
      };
}
