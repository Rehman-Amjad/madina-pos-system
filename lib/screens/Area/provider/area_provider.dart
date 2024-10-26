import 'package:flutter/cupertino.dart';

import '../../../constants.dart';

class AreaProvider with ChangeNotifier {
  // category firebase collection
  Future<void> uploadArea(
      {required count, required name, required description}) async {
    DateTime time = DateTime.now();
    try {
      await firestore
          .collection(Constant.COLLECTION_AREA)
          .doc(count.toString())
          .set({
        Constant.KEY_AREA_ID: count.toString(),
        Constant.KEY_AREA_NAME: name.toString().toUpperCase(),
        Constant.KEY_AREA_DESC: description.toString().toUpperCase(),
        "timeStamp": time.millisecondsSinceEpoch.toString(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> updateArea(
      {required code, required name, required description}) async {
    try {
      await firestore
          .collection(Constant.COLLECTION_AREA)
          .doc(code.toString())
          .update({
        Constant.KEY_AREA_NAME: name.toString().toUpperCase(),
        Constant.KEY_AREA_DESC: description.toString().toUpperCase(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> deleteArea({required id}) async {
    try {
      await firestore
          .collection(Constant.COLLECTION_AREA)
          .doc(id.toString())
          .delete();
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }
}
