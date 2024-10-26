import 'package:flutter/cupertino.dart';

import '../../../constants.dart';

class SalesManDataProvider with ChangeNotifier {
  Future<void> uploadPersonData(
      {required collection,
      required code,
      required name,
      required phone,
      required address,
      required joinDate,
      required status}) async {
    DateTime time = DateTime.now();
    try {
      await firestore.collection(collection).doc(code.toString()).set({
        Constant.KEY_SALESMAN_CODE: code.toString(),
        Constant.KEY_SALESMAN_NAME: name.toString().toUpperCase(),
        Constant.KEY_SALESMAN_PHONE: phone.toString(),
        Constant.KEY_SALESMAN_ADDRESS: address.toString().toUpperCase(),
        Constant.KEY_SALESMAN_JOIN_DATE: joinDate.toString(),
        Constant.KEY_SALESMAN_TIMESTAMP: time.millisecondsSinceEpoch.toString(),
        Constant.KEY_STATUS: status.toString().toUpperCase(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> updateSalesManData(
      {required collection,
      required count,
      required name,
      required phone,
      required address,
      required joinDate,
      required status}) async {
    try {
      await firestore.collection(collection).doc(count.toString()).update({
        Constant.KEY_SALESMAN_NAME: name.toString().toUpperCase(),
        Constant.KEY_SALESMAN_PHONE: phone.toString(),
        Constant.KEY_SALESMAN_ADDRESS: address.toString().toUpperCase(),
        Constant.KEY_SALESMAN_JOIN_DATE: joinDate.toString(),
        Constant.KEY_STATUS: status.toString().toUpperCase(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> deletePerson({required collection, required id}) async {
    try {
      await firestore.collection(collection).doc(id.toString()).delete();
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }
}
