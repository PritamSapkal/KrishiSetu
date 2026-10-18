import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ProductModel.dart';
import '../dummydata/Shg_ProduceDummyList.dart';

class ProduceListRiverpod extends StateNotifier<List<ProductModel>>{
  ProduceListRiverpod():super(shgProductList);

  void addProduct(ProductModel product){
    state=[...state,product];
  }
}

var ProduceListProvider=StateNotifierProvider<ProduceListRiverpod,List<ProductModel>>((ref)=>ProduceListRiverpod());
