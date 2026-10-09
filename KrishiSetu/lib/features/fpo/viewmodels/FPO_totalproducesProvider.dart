import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/produce_dummy_data.dart';

var totalProducesProvider=StateProvider<double>((ref){
  double total=0;
  for(int i=0;i<produceslist.length;i++){
    total=total+produceslist[i].volume;
  }
  return total;
});