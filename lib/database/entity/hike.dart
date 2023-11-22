class Hike {
  int? id;
  String? name;
  String? location;
  String? date;
  int? length;
  bool? parking;
  String? desc;
  String? guide;
  String? difficulty;
  double? price;

  Hike({
    this.id,
    this.name,
    this.location,
    this.date,
    this.length,
    this.parking,
    this.desc,
    this.guide,
    this.difficulty,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'date': date,
      'length': length,
      'parking': parking,
      'desc': desc,
      'guide': guide,
      'difficulty': difficulty,
      'price': price,
    };
  }
}
