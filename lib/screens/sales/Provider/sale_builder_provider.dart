import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../Purchase/components/purchase_form.dart';
import '../component/sale_build_text_field.dart';

class SaleBuilderProvider with ChangeNotifier {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static CollectionReference ref =
      FirebaseFirestore.instance.collection('sale');

  String saleJoiningDate = 'Select Joining Date';

  List<SaleBuildTextField> _saleItems = [];
  List<SaleBuildTextField> get saleItems => _saleItems;

  List<SaleFormControllers> _saleControllers = [];
  List<SaleFormControllers> get saleControllers => _saleControllers;

  void saleAddItem(BuildContext context) {
    _saleItems.add(SaleBuildTextField(index: _saleItems.length));
    _saleControllers.add(SaleFormControllers());
    notifyListeners();
  }

  void saleDeleteItem(int index, BuildContext context) {
    _saleItems.removeAt(index);
    notifyListeners();
  }

  Future<void> saleSaveDataToFireStore(
    BuildContext context, {
    required purchaseCode,
    purchaseDate,
    time,
    // vendor,
    customer,
    salesMan,
    supplyMan,
    vendorID,
    remarks,
    paymentVia,
    date,
  }) async {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      String month = DateFormat('MMMM').format(DateTime.now());
      await fireStore.collection('sale').doc(purchaseCode).set({
        'saleCode': purchaseCode,
        'date': date,
        's.date&time': time,
        Constant.KEY_SALES_TIMESTAMP: id,
        // 'vendor': vendor,
        'customer': customer,
        'supplyMan': supplyMan,
        'salesMan': salesMan,
        'remarks': remarks.toString().toUpperCase(),
        'paymentVia': paymentVia,
        'invoiceType': 'sale',
        'month': month,
      }).whenComplete(() {
        print("Sales Running");
        saleSaveItems(context, purchaseCode);
      });
      print('Data saved to Firestore successfully');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> saleSaveItems(BuildContext context, String purchaseCode) async {
    try {
      for (int i = 0; i < _saleItems.length; i++) {
        SaleFormControllers saleControllers = _saleControllers[i];
        String selectedItemName = saleControllers.itemNameController.text;
        String selectedItemCode = saleControllers.itemCodeController.text;
        String selectedUom = saleControllers.uomController.text;
        String selectedStock = saleControllers.stockController.text;
        String totalAmount = saleControllers.totalAmountController.text;
        String quantity = saleControllers.quantityController.text;
        String priceRate = saleControllers.priceRateController.text;
        String saleRate = saleControllers.saleRateController.text;
        String discount = saleControllers.discountController.text;
        String total = saleControllers.totalController.text;
        String plusStock = saleControllers.stockController.text +
            "-" +
            saleControllers.quantityController.text;
        String id = DateTime.now().millisecondsSinceEpoch.toString();

        await fireStore
            .collection('sale')
            .doc(purchaseCode)
            .collection("saleItems")
            .doc(id)
            .set({
          'itemName': selectedItemName,
          'itemCode': selectedItemCode,
          'totalAmount': totalAmount,
          'quantity': quantity,
          'priceRate': priceRate,
          'saleRate': saleRate,
          'discount': discount,
          'total': total,
          'uom': selectedUom,
          'stock': selectedStock,
          'plusStock': plusStock,
          Constant.KEY_ITEM_TIMESTAMP: id,
        }).whenComplete(() {
          fireStore.collection('sale').doc(purchaseCode).update({
            'totalSale': MultiController.totalSale,
          });
          saleSaveStock();
        });
      }
      _saleItems.clear();
      _saleControllers.clear();
      print('Data saved to Firestore successfully');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> saleSaveStock() async {
    try {
      for (int i = 0; i < _saleItems.length; i++) {
        SaleFormControllers saleControllers = _saleControllers[i];
        String itemCode = saleControllers.itemCodeController.text;
        double stock =
            double.tryParse(saleControllers.stockController.text) ?? 0;
        double quantity =
            double.tryParse(saleControllers.quantityController.text) ?? 0;
        double additionalStock = stock - quantity;

        await fireStore
            .collection(Constant.COLLECTION_ITEMS)
            .doc(itemCode.toString())
            .update({
          'stock': additionalStock.toString(),
          Constant.KEY_PURCHASE_TIMESTAMP:
              DateTime.now().millisecondsSinceEpoch.toString(),
        }).whenComplete(() {
          print('Stock Saved');
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  saleDatePicker(BuildContext context) async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));
    saleJoiningDate = DateFormat('dd-MM-yyyy').format(picDate!);
    notifyListeners();
  }

  Future<void> deleteSale(BuildContext context, String saleCode) async {
    try {
      await firestore.collection('sale').doc(saleCode).delete();

      print('Data deleted from Firestore successfully');
    } catch (error) {
      print('Error deleting data from Firestore: $error');
    }
  }

  Future<void> saleSavingDataToFireStore(
    BuildContext context, {
    required purchaseCode,
    purchaseDate,
    time,
    // vendor,
    customer,
    salesMan,
    supplyMan,
    vendorID,
    remarks,
    paymentVia,
    date,
  }) async {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      String month = DateFormat('MMMM').format(DateTime.now());
      await fireStore.collection('sale').doc(purchaseCode).set({
        'saleCode': purchaseCode,
        'date': date,
        's.date&time': time,
        Constant.KEY_SALES_TIMESTAMP: id,
        // 'vendor': vendor,
        'customer': customer,
        'supplyMan': supplyMan,
        'salesMan': salesMan,
        'remarks': remarks.toString().toUpperCase(),
        'paymentVia': paymentVia,
        'invoiceType': 'sale',
        'month': month,
      }).whenComplete(() {
        print("Sales Running");
        saleSavingItems(context, purchaseCode);
      });
      print('Data saved to Firestore successfully');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> saleSavingItems(
      BuildContext context, String purchaseCode) async {
    try {
      for (int i = 0; i < _saleItems.length; i++) {
        SaleFormControllers saleControllers = _saleControllers[i];
        String selectedItemName = saleControllers.itemNameController.text;
        String selectedItemCode = saleControllers.itemCodeController.text;
        String selectedUom = saleControllers.uomController.text;
        String selectedStock = saleControllers.stockController.text;
        String totalAmount = saleControllers.totalAmountController.text;
        String quantity = saleControllers.quantityController.text;
        String priceRate = saleControllers.priceRateController.text;
        String saleRate = saleControllers.saleRateController.text;
        String discount = saleControllers.discountController.text;
        String total = saleControllers.totalController.text;
        String plusStock = saleControllers.stockController.text +
            "-" +
            saleControllers.quantityController.text;
        String id = DateTime.now().millisecondsSinceEpoch.toString();

        await fireStore
            .collection('sale')
            .doc(purchaseCode)
            .collection("saleItems")
            .doc(id)
            .set({
          'itemName': selectedItemName,
          'itemCode': selectedItemCode,
          'totalAmount': totalAmount,
          'quantity': quantity,
          'priceRate': priceRate,
          'saleRate': saleRate,
          'discount': discount,
          'total': total,
          'uom': selectedUom,
          'stock': selectedStock,
          'plusStock': plusStock,
          Constant.KEY_ITEM_TIMESTAMP: id,
        });
        //     .whenComplete(() {
        //   fireStore.collection('sale').doc(purchaseCode).update({
        //     'totalSale': MultiController.totalSale,
        //   });
        //   saleSaveStock();
        // });
      }
      print('Data saved to Firestore successfully');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }
}

// Delete Function

// Future<void> deleteDataFromFireStore(int index) async {
//   try {
//     final QuerySnapshot querySnapshot =
//         await fireStore.collection('purchase').get();
//     final List<DocumentSnapshot> docs = querySnapshot.docs;
//     if (index >= 0 && index < docs.length) {
//       await ref.doc(docs[index].id.toString()).delete();
//       print('Document deleted successfully');
//     } else {
//       print('Invalid index');
//     }
//   } catch (error) {
//     print('Error deleting document: $error');
//   }
//   _items.removeAt(index);
//   notifyListeners();
// }

// int _counter = 0;
//
// String generateUniqueId() {
//   _counter++;
//   return 'buildTextField_$_counter';
// }

// void clearItems() {
//   _items.clear();
//   _controllers.clear();
//   notifyListeners();
// }
