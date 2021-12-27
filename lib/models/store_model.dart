class StoreModel {
  int id;
  String name;
  String image;
  String address;
  String phone;
  String owner;

  StoreModel({required this.id, required this.name, required this.image, required this.address, required this.owner, required this.phone});

  StoreModel fromJson(Map<String, dynamic> json) {
    return StoreModel(id: json['id'], name: json['name'], image: json['image'], address: json['address'], owner: json['owner'], phone: json['phone'] );
  }
}
