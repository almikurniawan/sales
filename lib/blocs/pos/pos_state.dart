abstract class PosState {
  
}
class PosProductUninitialized extends PosState {
  
}
class PosProductLoaded extends PosState{
  PosProductLoaded({
    required this.data
  });
  List<Map<String, dynamic>> data = [];
}

class PosSuccessInsert extends PosState{
  Map<String, dynamic> data;
  PosSuccessInsert({required this.data});
}