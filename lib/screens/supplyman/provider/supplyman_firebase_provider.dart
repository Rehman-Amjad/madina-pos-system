import 'package:flutter/cupertino.dart';

import '../../../constants.dart';

class SupplyManDataProvider with ChangeNotifier {
  Future<void> uploadSupplyManData(
      {required collection,
      required count,
      required name,
      required phone,
      required address,
      required joinDate,
      required status}) async {
    DateTime time = DateTime.now();
    try {
      await firestore.collection(collection).doc(count.toString()).set({
        Constant.KEY_SUPPLYMAN_CODE: count.toString(),
        Constant.KEY_SUPPLYMAN_NAME: name.toString().toUpperCase(),
        Constant.KEY_SUPPLYMAN_PHONE: phone.toString(),
        Constant.KEY_SUPPLYMAN_ADDRESS: address.toString().toUpperCase(),
        Constant.KEY_SUPPLYMAN_JOIN_DATE: joinDate.toString(),
        Constant.KEY_SUPPLYMAN_TIMESTAMP:
            time.millisecondsSinceEpoch.toString(),
        Constant.KEY_STATUS: status.toString().toUpperCase(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> updateSupplyManData(
      {required collection,
      required code,
      required name,
      required phone,
      required address,
      required joinDate,
      required status}) async {
    try {
      await firestore.collection(collection).doc(code.toString()).update({
        Constant.KEY_SUPPLYMAN_NAME: name.toString().toUpperCase(),
        Constant.KEY_SUPPLYMAN_PHONE: phone.toString(),
        Constant.KEY_SUPPLYMAN_ADDRESS: address.toString().toUpperCase(),
        Constant.KEY_SUPPLYMAN_JOIN_DATE: joinDate.toString(),
        Constant.KEY_STATUS: status.toString().toUpperCase(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> deleteSupplyMan({required collection, required id}) async {
    try {
      await firestore.collection(collection).doc(id.toString()).delete();
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }
}
