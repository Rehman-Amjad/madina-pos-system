import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../../../../provider/items_data_fetch_provider.dart';
import '../../../../responsive.dart';
import '../sale_build_text_field.dart';

class SaleBuildTextFieldWeb extends StatefulWidget {
  final int index;
  final SaleFormControllers saleFormControllers;
  const SaleBuildTextFieldWeb(
      {super.key, required this.saleFormControllers, required this.index});

  @override
  State<SaleBuildTextFieldWeb> createState() => _SaleBuildTextFieldWebState();
}

class _SaleBuildTextFieldWebState extends State<SaleBuildTextFieldWeb> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text('Item Code: '),
            ),
            Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                return Text(
                  value.selectedItemNameId.toString(),
                  style: TextStyle(color: hoverColor),
                );
              },
            ),
            // Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(right: 2),
            //   child: Text('Stock: '),
            // ),
            // Consumer<ItemsDataProvider>(
            //   builder: (context, value, child) {
            //     return Text(
            //       value.selectedItemStock.toString(),
            //       style: TextStyle(color: hoverColor),
            //     );
            //   },
            // ),
            // Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(right: 2),
            //   child: Text('Total Stock: '),
            // ),
            // Expanded(
            //   child: TextFormField(
            //     cursorColor: hoverColor,
            //     controller: widget.saleFormControllers.plusStockController,
            //     decoration: InputDecoration(
            //       hintText:
            //           widget.saleFormControllers.stockController.text.isNotEmpty
            //               ? widget.saleFormControllers.plusStockController.text
            //               : '0',
            //       hintStyle: TextStyle(fontSize: 12, color: hoverColor),
            //       border: InputBorder.none,
            //     ),
            //   ),
            // ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text('Uom: '),
            ),
            Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                return Text(
                  value.selectedUom.toString(),
                  style: TextStyle(color: hoverColor),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                'Company: ',
              ),
            ),
            Text(
              'Vendor',
              style: TextStyle(color: hoverColor),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Items Name',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    Container(
                      height: 55.0,
                      width: Responsive.isMobile(context)
                          ? size.width
                          : size.width / 2.9,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: hoverColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Consumer<ItemsDataProvider>(
                        builder: (context, values, child) {
                          if (values.itemName.isEmpty) {
                            values.fetchAllItemElements();
                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: secondaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "No Items Found",
                                  style: TextStyle(
                                      fontSize: Responsive.isMobile(context)
                                          ? 12
                                          : 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Item Name',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: provider.itemName
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: provider.selectedItemName,
                                      onChanged: (value) {
                                        setState(() {
                                          provider.selectedItemName = value;
                                          int itemIndex =
                                              provider.itemName.indexOf(value!);
                                          provider.selectedItemNameId =
                                              provider.itemsID[itemIndex];
                                          provider.selectedItemSalePrice =
                                              provider.itemSalePrice[itemIndex];
                                          // provider.selectedItemPurchasePrice =
                                          //     provider
                                          //         .itemPurchasePrice[itemIndex];
                                          // provider.selectedItemStock =
                                          //     provider.itemStock[itemIndex];
                                          // provider.selectedItemStock =
                                          //     provider.itemStock[itemIndex];
                                          provider.selectedUom =
                                              provider.uom[itemIndex];
                                          widget.saleFormControllers
                                              .itemNameController.text = value!;
                                          widget.saleFormControllers
                                              .itemNameController.text = value;
                                          widget.saleFormControllers
                                                  .itemCodeController.text =
                                              provider.itemsID[itemIndex];
                                          widget
                                              .saleFormControllers
                                              .uomController
                                              .text = provider.uom[itemIndex];
                                          // widget.saleFormControllers
                                          //         .stockController.text =
                                          //     provider.itemStock[itemIndex];
                                          widget.saleFormControllers
                                                  .saleRateController.text =
                                              provider.itemSalePrice[itemIndex];
                                          // widget.saleFormControllers
                                          //         .priceRateController.text =
                                          //     provider
                                          //         .itemPurchasePrice[itemIndex];
                                          updateAmount();
                                          updateTotal();
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        height: 57.0,
                                        width: 400.0,
                                      ),
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                        maxHeight: 200.0,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40.0,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: widget
                                            .saleFormControllers.itemController,
                                        searchInnerWidgetHeight: 50.0,
                                        searchInnerWidget: Container(
                                          height: 57.0,
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 4.0,
                                            right: 8.0,
                                            left: 8.0,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: widget
                                                .saleFormControllers
                                                .itemController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 8.0,
                                              ),
                                              hintText:
                                                  'Search for Item Name...',
                                              hintStyle: const TextStyle(
                                                  fontSize: 12.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          widget.saleFormControllers
                                              .itemController
                                              .clear();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Quantity',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: widget.saleFormControllers.quantityController,
                      decoration: InputDecoration(
                        hintText: widget.saleFormControllers.quantityController
                                .text.isEmpty
                            ? widget.saleFormControllers.quantityController
                                .text = '1'
                            : widget
                                .saleFormControllers.quantityController.text,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        setState(() {
                          updateQuantityForIndex(widget.index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 8),
            //     child: Column(
            //       children: [
            //         Text(
            //           'P.Price',
            //           style: TextStyle(fontSize: 16.0, color: hoverColor),
            //         ),
            //         SizedBox(height: 12.0),
            //         TextFormField(
            //           cursorColor: hoverColor,
            //           controller:
            //               widget.saleFormControllers.priceRateController,
            //           decoration: InputDecoration(
            //             hintText: provider.selectedItemPurchasePrice != null
            //                 ? widget.saleFormControllers.priceRateController
            //                     .text = provider.selectedItemPurchasePrice!
            //                 : "0",
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: hoverColor),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: hoverColor),
            //             ),
            //           ),
            //           textAlign: TextAlign.start,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'S.Rate',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: widget.saleFormControllers.saleRateController,
                      decoration: InputDecoration(
                        hintText: provider.selectedItemSalePrice != null
                            ? widget.saleFormControllers.saleRateController
                                .text = provider.selectedItemSalePrice!
                            : "0",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: widget.saleFormControllers.discountController,
                      decoration: InputDecoration(
                        hintText: widget.saleFormControllers
                                .totalAmountController.text.isEmpty
                            ? widget.saleFormControllers.discountController
                                .text = '0'
                            : widget
                                .saleFormControllers.discountController.text,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      onChanged: (value) {
                        updateTotal();
                      },
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: widget.saleFormControllers.totalController,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller:
                          widget.saleFormControllers.totalAmountController,
                      decoration: InputDecoration(
                        hintText: 'T.Amount',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        double.tryParse(widget.saleFormControllers.quantityController.text) ??
            0;
    widget.saleFormControllers.quantityController.text = quantity.toString();
  }

  void updateAmount() {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    double saleRate =
        double.tryParse(provider.selectedItemSalePrice ?? '0') ?? 0;
    double quantity =
        double.tryParse(widget.saleFormControllers.quantityController.text) ??
            0;
    double amount = saleRate * quantity;
    widget.saleFormControllers.totalController.text = amount.toString();
  }

  void updateTotalAmount() {
    double discount =
        double.tryParse(widget.saleFormControllers.discountController.text) ??
            0;
    double amount =
        double.tryParse(widget.saleFormControllers.totalController.text) ?? 0;
    double totalAmount = amount - (amount * (discount / 100));
    widget.saleFormControllers.totalAmountController.text =
        totalAmount.toString();
  }

  // void updatePlusStock() {
  //   final provider = Provider.of<ItemsDataProvider>(context, listen: false);
  //   double stock = double.tryParse(provider.selectedItemStock.toString()) ?? 0;
  //   double quantity =
  //       double.tryParse(widget.saleFormControllers.quantityController.text) ??
  //           0;
  //   double stockAddition = stock - quantity;
  //   widget.saleFormControllers.plusStockController.text =
  //       stockAddition.toString();
  // }

  void updateQuantityForIndex(index) {
    double quantity =
        double.tryParse(widget.saleFormControllers.quantityController.text) ??
            0;
    if (index == widget.index) {
      widget.saleFormControllers.quantityController.text = quantity.toString();
      updateAmount();
      updateTotalAmount();
      // updatePlusStock();
    }
  }
}
