import 'package:flutter/cupertino.dart';

import '../../../constants.dart';

class VendorDataProvider with ChangeNotifier {
  Future<void> uploadVendorData(
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
        Constant.KEY_VENDORMAN_CODE: count.toString(),
        Constant.KEY_VENDORMAN_NAME: name.toString().toUpperCase(),
        Constant.KEY_VENDORMAN_PHONE: phone.toString(),
        Constant.KEY_VENDORMAN_ADDRESS: address.toString().toUpperCase(),
        Constant.KEY_VENDORMAN_JOIN_DATE: joinDate.toString(),
        Constant.KEY_VENDORMAN_TIMESTAMP:
            time.millisecondsSinceEpoch.toString(),
        Constant.KEY_STATUS: status.toString().toUpperCase(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> updateVendorData(
      {required collection,
      required code,
      required name,
      required phone,
      required address,
      required joinDate,
      required status}) async {
    try {
      await firestore.collection(collection).doc(code.toString()).update({
        Constant.KEY_VENDORMAN_NAME: name.toString().toUpperCase(),
        Constant.KEY_VENDORMAN_PHONE: phone.toString(),
        Constant.KEY_VENDORMAN_ADDRESS: address.toString().toUpperCase(),
        Constant.KEY_VENDORMAN_JOIN_DATE: joinDate.toString(),
        Constant.KEY_STATUS: status.toString().toUpperCase(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> deleteVendor({required collection, required id}) async {
    try {
      await firestore.collection(collection).doc(id.toString()).delete();
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }
}
