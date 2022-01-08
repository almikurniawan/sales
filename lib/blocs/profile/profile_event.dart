abstract class ProfileEvent {
}

class ProfileLoad extends ProfileEvent {
  
}

class ProfileUpdate extends ProfileEvent {
  String name;
  String email;
  String telp;
  String address;

  ProfileUpdate({required this.name, required this.email, required this.telp, required this.address});
}