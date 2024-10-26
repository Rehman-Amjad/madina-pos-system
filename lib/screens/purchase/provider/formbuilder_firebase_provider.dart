import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../components/build_text_field.dart';
import '../components/purchase_form.dart';

class FormBuilderProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _purchaseRef =
  FirebaseFirestore.instance.collection('purchase');

  String joiningDate = 'Select Joining Date';
  final List<BuildTextField> _items = [];
  final List<FormControllers> _controllers = [];

  List<BuildTextField> get items => _items;
  List<FormControllers> get controllers => _controllers;

  void addItem() {
    _items.add(BuildTextField(index: _items.length));
    _controllers.add(FormControllers());
    notifyListeners();
  }

  void deleteItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      _controllers.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> saveDataToFirestore({
    required String purchaseCode,
    required String time,
    required String vendor,
    required String remarks,
    required String paymentVia,
    required String date,
  }) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String month = DateFormat('MMMM').format(DateTime.now());

    try {
      await _purchaseRef.doc(purchaseCode).set({
        'purchaseCode': purchaseCode,
        'date': date,
        'p.date&time': time,
        Constant.KEY_PURCHASE_TIMESTAMP: id,
        'vendor': vendor,
        'remarks': remarks.toUpperCase(),
        'paymentVia': paymentVia,
        'invoiceType': 'PURCHASE',
        'month': month,
      });
      await saveItems(purchaseCode);
      print('Data saved to Firestore successfully');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> saveItems(String purchaseCode) async {
    try {
      for (int i = 0; i < _items.length; i++) {
        final controllers = _controllers[i];
        String id = DateTime.now().millisecondsSinceEpoch.toString();

        final itemData = {
          'itemName': controllers.itemNameController.text,
          'itemCode': controllers.itemCodeController.text,
          'totalAmount': controllers.totalAmountController.text,
          'quantity': controllers.quantityController.text,
          'priceRate': controllers.priceRateController.text,
          'saleRate': controllers.saleRateController.text,
          'discount': controllers.discountController.text,
          'total': controllers.totalController.text,
          'uom': controllers.uomController.text,
          'stock': controllers.stockController.text,
          'plusStock': '${controllers.stockController.text}+${controllers.quantityController.text}',
          Constant.KEY_ITEM_TIMESTAMP: id,
        };

        await _purchaseRef
            .doc(purchaseCode)
            .collection("items")
            .doc(id)
            .set(itemData)
            .whenComplete(() {
          _purchaseRef.doc(purchaseCode).update({
            'totalPurchase': MultiController.totalPurchase,
          });
          saveStock();
        });
      }
      _items.clear();
      _controllers.clear();
      print('Items saved to Firestore successfully');
    } catch (error) {
      print('Error saving items to Firestore: $error');
    }
  }

  Future<void> saveStock() async {
    try {
      for (var controllers in _controllers) {
        double stock = double.tryParse(controllers.stockController.text) ?? 0;
        double quantity = double.tryParse(controllers.quantityController.text) ?? 0;
        double additionalStock = stock + quantity;

        await _firestore
            .collection(Constant.COLLECTION_ITEMS)
            .doc(controllers.itemCodeController.text)
            .update({
          'stock': additionalStock.toString(),
          Constant.KEY_PURCHASE_TIMESTAMP: DateTime.now().millisecondsSinceEpoch.toString(),
        });
        print('Stock updated');
      }
    } catch (e) {
      print('Error updating stock: $e');
    }
    notifyListeners();
  }

  Future<void> deletePurchase(String purchaseCode) async {
    try {
      await _purchaseRef.doc(purchaseCode).delete();
      print('Data deleted from Firestore successfully');
    } catch (error) {
      print('Error deleting data from Firestore: $error');
    }
  }

  Future<void> datePicker(BuildContext context) async {
    final picDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    );
    if (picDate != null) {
      joiningDate = DateFormat('dd-MM-yyyy').format(picDate);
      notifyListeners();
    }
  }
}
