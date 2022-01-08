import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/pos/pos_event.dart';
import 'package:sales/blocs/pos/pos_state.dart';
import 'package:sales/repositories/pos_repository.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc(PosState initialState) : super(initialState);
  
  @override
  Stream<PosState> mapEventToState(PosEvent event) async*{
    // TODO: implement mapEventToState
    print("event");
    print(event);
    if(event is PosLoadProduct){
      List<Map<String, dynamic>> result = await PosRepository().loadProduct();
      yield PosProductLoaded(data: result);
    }
    else if(event is PosInsert){
      Map<String, dynamic> result = await PosRepository().insertPos(event.productId, event.qty, event.storeId);
      yield PosSuccessInsert(data : result['data']);
      // List<Map<String, dynamic>> res = await PosRepository().loadProduct();
      // yield PosProductLoaded(data: res);
    }
    else{
      yield PosProductUninitialized();
    }
  }
}