import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:madina_pos_system/screens/sales/component/responsive_sale_build_text/sale_build_text_field_mobile.dart';
import 'package:madina_pos_system/screens/sales/component/responsive_sale_build_text/sale_build_text_field_web.dart';
import 'package:provider/provider.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';
import '../../Purchase/components/purchase_form.dart';
import '../Provider/sale_builder_provider.dart';

class SaleBuildTextField extends StatefulWidget {
  final int index;
  SaleBuildTextField({
    Key? key,
    required this.index,
  });

  @override
  State<SaleBuildTextField> createState() => _SaleBuildTextFieldState();
}

class _SaleBuildTextFieldState extends State<SaleBuildTextField> {
  late SaleFormControllers _saleFormControllers;

  MultiController multiController = MultiController();

  @override
  void initState() {
    super.initState();
    _saleFormControllers =
        Provider.of<SaleBuilderProvider>(context, listen: false)
            .saleControllers[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Responsive.isMobile(context)
            ? SaleBuildTextFieldMobile(
                saleFormControllers: _saleFormControllers, index: widget.index)
            :
            // for desktop
            SaleBuildTextFieldWeb(
                saleFormControllers: _saleFormControllers, index: widget.index),
        SizedBox(height: 16),
      ],
    );
  }

  void updateTotal() {
    updateQuantity();
    updateAmount();
    updateTotalAmount();
    // updatePlusStock();
  }

  void updateQuantity() {
    double quantity =
        double.tryParse(_saleFormControllers.quantityController.text) ?? 0;
    _saleFormControllers.quantityController.text = quantity.toString();
  }

  void updateAmount() {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    double saleRate =
        double.tryParse(provider.selectedItemSalePrice ?? '0') ?? 0;
    double quantity =
        double.tryParse(_saleFormControllers.quantityController.text) ?? 0;
    double amount = saleRate * quantity;
    _saleFormControllers.totalController.text = amount.toString();
  }

  void updateTotalAmount() {
    double discount =
        double.tryParse(_saleFormControllers.discountController.text) ?? 0;
    double amount =
        double.tryParse(_saleFormControllers.totalController.text) ?? 0;
    double totalAmount = amount - (amount * (discount / 100));
    _saleFormControllers.totalAmountController.text = totalAmount.toString();
  }

  // void updatePlusStock() {
  //   final provider = Provider.of<ItemsDataProvider>(context, listen: false);
  //   double stock = double.tryParse(provider.selectedItemStock.toString()) ?? 0;
  //   double quantity =
  //       double.tryParse(_saleFormControllers.quantityController.text) ?? 0;
  //   double stockAddition = stock - quantity;
  //   _saleFormControllers.plusStockController.text = stockAddition.toString();
  // }

  void updateQuantityForIndex(index) {
    double quantity =
        double.tryParse(_saleFormControllers.quantityController.text) ?? 0;
    if (index == widget.index) {
      _saleFormControllers.quantityController.text = quantity.toString();
      updateAmount();
      updateTotalAmount();
      // updatePlusStock();
    }
  }
}

class SaleFormControllers {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceRateController = TextEditingController();
  TextEditingController saleRateController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController plusStockController = TextEditingController();
}
