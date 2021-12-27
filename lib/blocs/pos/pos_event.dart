abstract class PosEvent {
  
}
class PosInsert extends PosEvent{
  late int productId;
  late int qty;
  late int storeId;

  PosInsert({required this.productId, required this.qty, required this.storeId});
}

class PosLoadProduct extends PosEvent{
}

