import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dummydata/ShgMember_DummyData.dart';
import '../models/ShgMemberModel.dart';

class Memberlistriverpod extends StateNotifier<List<ShgMemberModel>>{
  Memberlistriverpod():super(mockShgMembersList);

  void addMember(ShgMemberModel member){
    state=[...state,member];
  }

}
var MemberlistProvider=StateNotifierProvider<Memberlistriverpod,List<ShgMemberModel>>((ref)=>Memberlistriverpod());