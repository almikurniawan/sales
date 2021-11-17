import 'package:sales/blocs/store/store_event.dart';
import 'package:sales/models/store_model.dart';

abstract class StoreState {
  
}

class StoreUninitialized extends StoreState{
  
}

class StoreLoaded extends StoreState {
  List<StoreModel> items = [];
  StoreLoaded({required this.items});
}
