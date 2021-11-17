import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/store/store_event.dart';
import 'package:sales/blocs/store/store_state.dart';
import 'package:sales/models/store_model.dart';
import 'package:sales/repositories/store_repository.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc(StoreState initialState) : super(StoreUninitialized());
  
  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async*{
    // TODO: implement mapEventToState
    if(event is StoreLoad){
      List<StoreModel> items = await StoreRepository().loadStore();
      yield StoreLoaded(items: items);
    }else if(event is StoreInsert){
      await StoreRepository().insert(event);
      List<StoreModel> items = await StoreRepository().loadStore();
      yield StoreLoaded(items: items);
    }else if(event is StoreUpdate){
      await StoreRepository().update(event);
      List<StoreModel> items = await StoreRepository().loadStore();
      yield StoreLoaded(items: items);
    }
    else{
      yield StoreUninitialized();
    }
  }
}