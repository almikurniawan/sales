abstract class ProfileState {
  
}

class ProfileUninitialized extends ProfileState{
  
}

class ProfileLoading extends ProfileState{
  
}

class ProfileLoaded extends ProfileState{
  int salesId;
  String salesName;
  String salesEmail;
  String salesPhone;
  String salesCode;
  String salesImage;

  ProfileLoaded(
      {required this.salesId,
      required this.salesName,
      required this.salesEmail,
      required this.salesPhone,
      required this.salesCode,
      required this.salesImage});

  ProfileLoaded.fromJson(Map<String, dynamic> json) {
    salesId = json['sales_id'];
    salesName = json['sales_name'];
    salesEmail = json['sales_email'];
    salesPhone = json['sales_phone'];
    salesCode = json['sales_code'];
    salesImage = json['sales_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_id'] = this.salesId;
    data['sales_name'] = this.salesName;
    data['sales_email'] = this.salesEmail;
    data['sales_phone'] = this.salesPhone;
    data['sales_code'] = this.salesCode;
    data['sales_image'] = this.salesImage;
    return data;
  }
}