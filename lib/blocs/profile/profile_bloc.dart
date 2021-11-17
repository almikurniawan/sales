import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/profile/profile_event.dart';
import 'package:sales/blocs/profile/profile_state.dart';
import 'package:sales/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(ProfileUninitialized());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // TODO: implement mapEventToState

    // if (state is ProfileUninitialized) {
    //   Map<String, dynamic> jsonProfile =
    //       await ProfileRepository().loadProfile();
    //   // yield ProfileLoaded;
    // } else {
      if (event is ProfileLoad) {
        Map<String, dynamic> jsonProfile =
            await ProfileRepository().loadProfile();
            
        yield ProfileLoading();
        yield ProfileLoaded(salesId: jsonProfile['sales_id'], salesName: jsonProfile['sales_name'], salesEmail: jsonProfile['sales_email'], salesPhone: jsonProfile['sales_phone'], salesCode: jsonProfile['sales_code'], salesImage: jsonProfile['sales_image']);
      }else{
        yield ProfileLoading();
      }
    // }
  }
}
