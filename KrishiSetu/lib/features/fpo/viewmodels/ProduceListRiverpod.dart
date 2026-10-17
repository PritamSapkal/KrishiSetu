import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ProductModel.dart';
import '../dummydata/ProductListingDummyData.dart';

class Producelistriverpod extends StateNotifier<List<ProductModel>>{
  Producelistriverpod():super(mockProductList);

  void addproduct(ProductModel product){
    state=[...state,product];
  }

  List<ProductModel> getproduct(){
    return state;
  }
}

var ProduceListProvider=StateNotifierProvider<Producelistriverpod,List<ProductModel>>((ref) {
  return Producelistriverpod();
});