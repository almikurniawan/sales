abstract class ProfileEvent {
}

class ProfileLoad extends ProfileEvent {
  
}

class ProfileUpdate extends ProfileEvent {
  int id;
  String nama;

  ProfileUpdate({required this.id, required this.nama});
}