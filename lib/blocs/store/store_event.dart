abstract class StoreEvent {}

class StoreLoad extends StoreEvent {}

class StoreInsert extends StoreEvent {
  String name;
  String owner;
  String phone;
  String address;
  String latitude;
  String longitude;
  StoreInsert(
      {required this.address,
      required this.phone,
      required this.owner,
      required this.name,
      required this.latitude,
      required this.longitude});
}

class StoreUpdate extends StoreEvent {
  int id;
  String name;
  String owner;
  String phone;
  String address;
  String latitude;
  String longitude;

  StoreUpdate(
      {required this.id,
      required this.address,
      required this.phone,
      required this.owner,
      required this.name,
      required this.latitude,
      required this.longitude});
}
