import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/profile/profile_event.dart';
import 'package:sales/blocs/profile/profile_state.dart';
import 'package:sales/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(ProfileUninitialized());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // TODO: implement mapEventToState

    if (state is ProfileUninitialized) {
      Map<String, dynamic> jsonProfile =
          await ProfileRepository().loadProfile();
      yield ProfileLoaded.fromJson(jsonProfile);
    } else {
      if (event is ProfileLoad) {
        Map<String, dynamic> jsonProfile =
            await ProfileRepository().loadProfile();
        yield ProfileLoaded.fromJson(jsonProfile);
      }else{
        yield ProfileLoading();
      }
    }
  }
}
