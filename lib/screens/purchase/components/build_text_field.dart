import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';
import '../provider/formbuilder_firebase_provider.dart';
import '../responsive_build_Text/build_text_filed_items_mobile.dart';
import '../responsive_build_Text/build_text_filed_items_web.dart';

class BuildTextField extends StatefulWidget {
  final int index;
  const BuildTextField({Key? key, required this.index}) : super(key: key);

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  late FormControllers _formControllers;
  late ItemsDataProvider _itemsDataProvider;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _formControllers = Provider
        .of<FormBuilderProvider>(context, listen: false)
        .controllers[widget.index];
    _itemsDataProvider = Provider.of<ItemsDataProvider>(context, listen: false);
    // _formControllers.quantityController.addListener(_updateAllFields);
    _focusNode = FocusNode();

    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //     // Reset the listeners for the specific field when focused
    //     _formControllers.quantityController.addListener(_updateAllFields);
    //   } else {
    //     // Remove listener when the field is not focused
    //     _formControllers.quantityController.removeListener(_updateAllFields);
    //   }
    // });
}

  @override
  void dispose() {
    _focusNode.dispose();
    _formControllers.quantityController.removeListener(_updateAllFields);
    super.dispose();
  }

  void _updateAllFields() {
    _updateQuantity();
    _updateAmount();
    _updateTotalAmount();
    _updatePlusStock();
  }

  void _updateQuantity() {
    double quantity = double.tryParse(_formControllers.quantityController.text) ?? 0.0;
    _formControllers.quantityController.text = quantity.toString();
  }

  void _updateAmount() {
    double priceRate = double.tryParse(_itemsDataProvider.selectedItemPurchasePrice ?? '0') ?? 0.0;
    double quantity = double.tryParse(_formControllers.quantityController.text) ?? 0.0;
    _formControllers.totalController.text = (priceRate * quantity).toString();
  }

  void _updateTotalAmount() {
    double discount = double.tryParse(_formControllers.discountController.text) ?? 0.0;
    double amount = double.tryParse(_formControllers.totalController.text) ?? 0.0;
    double totalAmount = amount * (1 - discount / 100);
    _formControllers.totalAmountController.text = totalAmount.toString();
  }

  void _updatePlusStock() {
    double stock = double.tryParse(_itemsDataProvider.selectedItemStock.toString()) ?? 0.0;
    double quantity = double.tryParse(_formControllers.quantityController.text) ?? 0.0;
    _formControllers.plusStockController.text = (stock + quantity).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Responsive.isMobile(context)
            ? BuildTextFieldItemsMobile(
            formControllers: _formControllers, index: widget.index,focusNode: _focusNode,)
            : BuildTextFieldItemsWeb(
            formControllers: _formControllers, index: widget.index,focusNode: _focusNode,),
        const SizedBox(height: 16),
      ],
    );
  }
}

class FormControllers {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController uomController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceRateController = TextEditingController();
  final TextEditingController saleRateController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController plusStockController = TextEditingController();
}
