class StoreModel {
  int id;
  String name;
  String image;

  StoreModel({required this.id, required this.name, required this.image});

  StoreModel fromJson(Map<String, dynamic> json) {
    return StoreModel(id: json['id'], name: json['name'], image: json['image']);
  }
}
