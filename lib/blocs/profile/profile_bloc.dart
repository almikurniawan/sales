import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/profile/profile_event.dart';
import 'package:sales/blocs/profile/profile_state.dart';
import 'package:sales/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(ProfileUninitialized());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // TODO: implement mapEventToState

    if (event is ProfileLoad) {
      Map<String, dynamic> jsonProfile =
          await ProfileRepository().loadProfile();

      yield ProfileLoading();
      yield ProfileLoaded(
          salesId: jsonProfile['id'],
          salesName: jsonProfile['sales_name'],
          salesEmail: jsonProfile['sales_email'],
          salesPhone: jsonProfile['sales_phone'],
          salesCode: jsonProfile['sales_code'],
          salesImage: jsonProfile['sales_image'],
          salesAlamat: jsonProfile['sales_alamat']);
    } else if (event is ProfileUpdate) {
      yield ProfileLoading();
      Map<String, dynamic> jsonProfile =
          await ProfileRepository().updateProfile(event);
      Map<String, dynamic> jsonP =
          await ProfileRepository().loadProfile();
      yield ProfileLoaded(
          salesId: jsonP['id'],
          salesName: jsonP['sales_name'],
          salesEmail: jsonP['sales_email'],
          salesPhone: jsonP['sales_phone'],
          salesCode: jsonP['sales_code'],
          salesImage: jsonP['sales_image'],
          salesAlamat: jsonP['sales_alamat']);
    } else {
      yield ProfileLoading();
    }
  }
}
