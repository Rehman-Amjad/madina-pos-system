import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controller/MenuAppController.dart';
import '../../../controller/cash_dropdown.dart';
import '../../../model/res/widget/custom_textfield.dart';
import '../../../model/res/widget/text_helper.dart';
import '../../../model/res/widget/text_widget.dart';
import '../../../model/res/widget/vendor_dropdown.dart';
import '../../../provider/count_value_provider.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';
import '../provider/formbuilder_firebase_provider.dart';

class PurchaseForm extends StatelessWidget {
  final int index;
  final TextEditingController _remarksController = TextEditingController();

  PurchaseForm({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final menuAppController = Provider.of<MenuAppController>(context, listen: false);
    final formBuilderProvider = Provider.of<FormBuilderProvider>(context, listen: false);
    final countValueProvider = Provider.of<CountValueProvider>(context);
    countValueProvider.fetchCountValue(); // Only call this once.

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInvoiceAndDateSection(context, size, formBuilderProvider, countValueProvider),
          const SizedBox(height: 35.0),
          _buildVendorDropdown(context, size),
          const SizedBox(height: 35.0),
          _buildRemarksAndPaymentSection(context, size),
          const SizedBox(height: 35.0),
          _buildItemList(context, formBuilderProvider),
          const SizedBox(height: 10.0),
          _buildActionButtons(context, formBuilderProvider, countValueProvider),
        ],
      ),
    );
  }

  Widget _buildInvoiceAndDateSection(BuildContext context, Size size, FormBuilderProvider formBuilderProvider, CountValueProvider countValueProvider) {
    return SizedBox(
      width: Responsive.isMobile(context) ? size.width : size.width / 1.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildInvoiceNumber(context, countValueProvider),
          const SizedBox(width: 80.0),
          _buildDatePicker(context, formBuilderProvider),
        ],
      ),
    );
  }

  Widget _buildInvoiceNumber(BuildContext context, CountValueProvider countValueProvider) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHelper().mNormalText(text: "Invoice Number:", color: Colors.white, size: 14.0),
          const SizedBox(height: 15.0),
          _buildDisplayField(countValueProvider.countValue.toString()),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, FormBuilderProvider formBuilderProvider) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHelper().mNormalText(text: "Date", color: Colors.white, size: 14.0),
          const SizedBox(height: 15.0),
          GestureDetector(
            onTap: () => formBuilderProvider.datePicker(context),
            child: _buildDisplayField(formBuilderProvider.joiningDate),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayField(String text) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: TextWidget(
            text: text,
            color: hoverColor,
            size: 14.0,
            isBold: false,
          ),
        ),
      ),
    );
  }

  Widget _buildVendorDropdown(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextHelper().mNormalText(text: "Vendor Name:", color: Colors.white, size: 14.0),
        const SizedBox(height: 15.0),
        Container(
          height: 60.0,
          width: Responsive.isMobile(context) ? size.width : size.width / 0.9,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Consumer<ItemsDataProvider>(
            builder: (context, value, child) {
              if (value.vendor.isEmpty) {
                value.fetchVendorName();
                return _buildNoItemsFound();
              } else {
                return const VendorDropdown();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoItemsFound() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: secondaryColor,
      ),
      child: const Center(
        child: Text(
          "No Items Found",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildRemarksAndPaymentSection(BuildContext context, Size size) {
    return SizedBox(
      width: Responsive.isMobile(context) ? size.width : size.width / 1.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildRemarksField(size,context),
          const SizedBox(width: 80.0),
          _buildPaymentTermDropdown(),
        ],
      ),
    );
  }

  Widget _buildRemarksField(Size size,BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHelper().mNormalText(text: "Remarks", color: Colors.white, size: 14.0),
          const SizedBox(height: 15.0),
          SizedBox(
            width: Responsive.isMobile(context) ? size.width : size.width / 3.9,
            child: CustomizeTextField(
              controller: _remarksController,
              hintText: '',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTermDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHelper().mNormalText(text: "Payment Term:", color: Colors.white, size: 14.0),
          const SizedBox(height: 15.0),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const CashDropDown(),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList(BuildContext context, FormBuilderProvider formBuilderProvider) {
    return Consumer<FormBuilderProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: value.items.length,
          itemBuilder: (context, index) {
            return _buildItemRow(context, value, index);
          },
        );
      },
    );
  }

  Widget _buildItemRow(BuildContext context, FormBuilderProvider value, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Text('Serial no: '),
              ),
              Text((index + 1).toString(), style: const TextStyle(color: hoverColor)),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        value.items[index],
        const SizedBox(height: 10.0),
        if (index == value.items.length - 1) _buildDeleteButton(context, index),
        const SizedBox(height: 12.0),
        const Divider(),
        const SizedBox(height: 18.0),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context, int index) {
    return SizedBox(
      height: 32.0,
      width: 32.0,
      child: TextButton(
        onPressed: () {
          Provider.of<FormBuilderProvider>(context, listen: false).deleteItem(index);
        },
        child: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, FormBuilderProvider formBuilderProvider, CountValueProvider countValueProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildSubmitButton(context, formBuilderProvider, countValueProvider),
        const SizedBox(width: 15.0),
        _buildAddItemButton(context, formBuilderProvider),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, FormBuilderProvider formBuilderProvider, CountValueProvider countValueProvider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hoverColor,
          textStyle: const TextStyle(
              color: Colors.black
          )
      ),
      onPressed: () async {
        String remarks = _remarksController.text.toString();
        await formBuilderProvider.saveDataToFirestore(
        purchaseCode:   countValueProvider.countValue.toString(),
        remarks: remarks,
          time: DateTime.now().toString(),
          vendor: AllController.vendor.toString(),
          paymentVia: AllController.cash.toString(),
          date: formBuilderProvider.joiningDate.toString(),
        );
      },
      child: const Text('Submit',style:TextStyle(color: Colors.black),),
    );
  }

  Widget _buildAddItemButton(BuildContext context, FormBuilderProvider formBuilderProvider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hoverColor,
        textStyle: const TextStyle(
          color: Colors.black
        )
      ),
      onPressed: () {
        formBuilderProvider.addItem();
      },
      child: const Text('Add Item',style: TextStyle(color: Colors.black),),
    );
  }
}
class MultiController {
  static double totalPurchase = 0.0;
  static double totalP = 0.0;
  static dynamic totalSale = TextEditingController();
  static dynamic cash1 = TextEditingController();
  static dynamic vendor1 = TextEditingController();
}
