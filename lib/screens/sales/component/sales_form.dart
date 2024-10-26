import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:madina_pos_system/screens/sales/component/sale_build_text_field.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controller/cash_dropdown.dart';
import '../../../model/res/components/customer_dropdown.dart';
import '../../../model/res/components/salesman_dropdown.dart';
import '../../../model/res/components/supplyman_dropdown.dart';
import '../../../model/res/widget/custom_textfield.dart';
import '../../../model/res/widget/text_helper.dart';
import '../../../model/res/widget/text_widget.dart';
import '../../../provider/count_value_provider.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';
import '../Provider/sale_builder_provider.dart';

class SalesForm extends StatefulWidget {
  int index;
  SalesForm({super.key, this.index = 0});

  @override
  State<SalesForm> createState() => _SalesFormState();
}

class _SalesFormState extends State<SalesForm> {
  TextEditingController _remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _remarksController.addListener(_onRemarksChanged);
  }

  @override
  void dispose() {
    _remarksController.removeListener(_onRemarksChanged);
    _remarksController.dispose();
    super.dispose();
  }

  void _onRemarksChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SaleFormControllers saleControllers = SaleFormControllers();
    final saleProvider =
        Provider.of<SaleBuilderProvider>(context, listen: false);
    final saleProvider1 =
        Provider.of<CountValueProvider>(context, listen: false);
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
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
          Container(
            width: Responsive.isMobile(context) ? size.width : size.width / 1.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Invoice Number:",
                          color: Colors.white,
                          size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 60.0,
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 2.9,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                          child: Consumer<CountValueProvider>(
                            builder: (context, value, child) {
                              return TextHelper().mNormalText(
                                  text: value.countValue.toString(),
                                  color: hoverColor,
                                  size: 16.0);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 80.0,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Date", color: Colors.white, size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Consumer<SaleBuilderProvider>(
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              value.saleDatePicker(context);
                            },
                            child: Container(
                              width: Responsive.isMobile(context)
                                  ? size.width
                                  : size.width / 2.9,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 20.0,
                                      bottom: 20.0),
                                  child: TextWidget(
                                    text: value.saleJoiningDate,
                                    color: hoverColor,
                                    size: 14.0,
                                    isBold: false,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 35.0,
          // ),
          // TextHelper().mNormalText(
          //     text: "Vendor Name:", color: Colors.white, size: 14.0),
          // const SizedBox(
          //   height: 15.0,
          // ),
          // Container(
          //   height: 60.0,
          //   width: Responsive.isMobile(context) ? size.width : size.width / 0.9,
          //   decoration: BoxDecoration(
          //       border: Border.all(width: 1, color: Colors.white),
          //       borderRadius: BorderRadius.circular(5)),
          //   child: Consumer<ItemsDataProvider>(
          //     builder: (context, value, child) {
          //       if (value.vendor.isEmpty) {
          //         value.fetchVendorName();
          //         return Container(
          //           padding: EdgeInsets.all(10),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: secondaryColor,
          //           ),
          //           child: Center(
          //             child: Text(
          //               "No Vendor Found",
          //               style: TextStyle(
          //                   fontSize: Responsive.isMobile(context) ? 12 : 18,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         );
          //       } else {
          //         return VendorDropdown();
          //       }
          //     },
          //   ),
          // ),
          // SizedBox(
          //   height: 35.0,
          // ),
          SizedBox(
            height: 35.0,
          ),
          TextHelper().mNormalText(
              text: "Sales Man Name:", color: Colors.white, size: 14.0),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            height: 60.0,
            width: Responsive.isMobile(context) ? size.width : size.width / 0.9,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(5)),
            child: Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                if (value.salesMan.isEmpty) {
                  value.fetchSalesManName();
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "No Sales Man Found",
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 12 : 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return SalesManDropdown();
                }
              },
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          TextHelper().mNormalText(
              text: "Supply Man Name:", color: Colors.white, size: 14.0),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            height: 60.0,
            width: Responsive.isMobile(context) ? size.width : size.width / 0.9,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(5)),
            child: Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                if (value.supplyMan.isEmpty) {
                  value.fetchSupplyManName();
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "No Supply Man Found",
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 12 : 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return SupplyManDropdown();
                }
              },
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          TextHelper().mNormalText(
              text: "Customer Name:", color: Colors.white, size: 14.0),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            height: 60.0,
            width: Responsive.isMobile(context) ? size.width : size.width / 0.9,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(5)),
            child: Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                if (value.customer.isEmpty) {
                  value.fetchCustomerName();
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "No Customer Found",
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 12 : 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return CustomerDropDown();
                }
              },
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            width: Responsive.isMobile(context) ? size.width : size.width / 1.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Remarks", color: Colors.white, size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 3.9,
                        child: CustomizeTextField(
                          controller: _remarksController,
                          hintText: '',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 80.0,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Payment Term:",
                          color: Colors.white,
                          size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 60.0,
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 3.9,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        child: CashDropDown(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0, left: 5.0),
            child: Divider(
              color: hoverColor,
              thickness: 0.4,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0, left: 5.0, bottom: 8.0),
            child: Divider(
              color: hoverColor,
              thickness: 2.5,
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Consumer<SaleBuilderProvider>(
            builder: (context, value, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.saleItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Text('Serial no: '),
                              ),
                              Text(
                                (index + 1).toString(),
                                style: TextStyle(color: hoverColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      value.saleItems[index],
                      SizedBox(height: 10.0),
                      if (index == value.saleItems.length - 1)
                        Center(
                          child: Container(
                            height: 32.0,
                            width: 32.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              color: hoverColor,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              onPressed: () {
                                Provider.of<SaleBuilderProvider>(context,
                                        listen: false)
                                    .saleDeleteItem(index, context);
                                print('indexToDelete: $index');
                              },
                            ),
                          ),
                        ),
                      SizedBox(height: 12.0),
                      Divider(),
                      SizedBox(height: 18.0),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Container(
                height: 36.0,
                width: 36.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hoverColor,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18.0,
                  ),
                  onPressed: () {
                    Provider.of<SaleBuilderProvider>(context, listen: false)
                        .saleAddItem(context);
                  },
                ),
              ),
              SizedBox(width: 8.0),
              TextButton(
                onPressed: () {
                  // preview data:
                  List<Map<String, String>> saleRowsData = [];
                  for (int i = 0; i < saleProvider.saleItems.length; i++) {
                    SaleFormControllers saleControllers =
                        saleProvider.saleControllers[i];

                    String selectedItemName =
                        saleControllers.itemNameController.text;
                    String selectedItemCode =
                        saleControllers.itemCodeController.text;
                    String selectedUom = saleControllers.uomController.text;
                    String selectedStock = saleControllers.stockController.text;
                    String totalAmount =
                        saleControllers.totalAmountController.text;
                    String quantity = saleControllers.quantityController.text;
                    String priceRate = saleControllers.priceRateController.text;
                    String saleRate = saleControllers.saleRateController.text;
                    String discount = saleControllers.discountController.text;
                    String total = saleControllers.totalController.text;
                    String plusStock = saleControllers.stockController.text +
                        "+" +
                        saleControllers.quantityController.text;

                    saleRowsData.add({
                      'SerialNumber': (i + 1).toString(),
                      'ItemName': selectedItemName,
                      'ItemCode': selectedItemCode,
                      'ItemPriceRate': priceRate,
                      'ItemSalePrice': saleRate,
                      'Amount': total,
                      'TotalAmount': totalAmount,
                      'Discount': discount,
                      'Quantity': quantity,
                      'Uom': selectedUom,
                      'Stock': selectedStock,
                      'PlusStock': plusStock,
                    });
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SalePdf(
                  //       cash: SaleMultiController.saleCash1.toString(),
                  //       joinDate: saleProvider.saleJoiningDate,
                  //       remarks: _remarksController.text.toString(),
                  //       // vendor: SaleMultiController.saleVendor1.toString(),
                  //       rowsData: saleRowsData,
                  //       invoiceNumber: saleProvider1.countValue.toString(),
                  //       customer: SaleMultiController.saleCustomer1.toString(),
                  //       salesMan: SaleMultiController.saleSalesMan1.toString(),
                  //       supplyMan:
                  //           SaleMultiController.saleSupplyMan1.toString(),
                  //     ),
                  //   ),
                  // );
                  // save
                  saleProvider.saleSaveDataToFireStore(
                    context,
                    purchaseCode: saleProvider1.countValue.toString(),
                    paymentVia: SaleAllController.saleCash,
                    remarks: _remarksController.text.toString(),
                    // vendor: SaleAllController.saleVendor,
                    customer: SaleAllController.saleCustomer.toString(),
                    salesMan: SaleAllController.saleSalesMan.toString(),
                    supplyMan: SaleAllController.saleSupplyMan.toString(),
                    date: saleProvider.saleJoiningDate,
                    time: DateTime.now(),
                  );
                  saleProvider1.fetchCountValue();
                  int newCountValue = saleProvider1.countValue;
                  saleProvider1.updateCountValue(count: newCountValue + 1);
                },
                child: Container(
                  height: 36.0,
                  width: 128.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: hoverColor,
                  ),
                  child: Center(
                    child: Text(
                      'Save & Preview',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  List<Map<String, String>> saleRowsData = [];
                  for (int i = 0; i < saleProvider.saleItems.length; i++) {
                    SaleFormControllers saleControllers =
                        saleProvider.saleControllers[i];

                    String selectedItemName =
                        saleControllers.itemNameController.text;
                    String selectedItemCode =
                        saleControllers.itemCodeController.text;
                    String selectedUom = saleControllers.uomController.text;
                    // String selectedStock =
                    //     saleControllers.stockController.text;
                    String totalAmount =
                        saleControllers.totalAmountController.text;
                    String quantity = saleControllers.quantityController.text;
                    // String priceRate =
                    //     saleControllers.priceRateController.text;
                    String saleRate = saleControllers.saleRateController.text;
                    String discount = saleControllers.discountController.text;
                    String total = saleControllers.totalController.text;
                    // String plusStock =
                    //     saleControllers.stockController.text +
                    //         "+" +
                    //         saleControllers.quantityController.text;

                    saleRowsData.add({
                      'SerialNumber': (i + 1).toString(),
                      'ItemName': selectedItemName,
                      'ItemCode': selectedItemCode,
                      // 'ItemPriceRate': priceRate,
                      'ItemSalePrice': saleRate,
                      'Amount': total,
                      'TotalAmount': totalAmount,
                      'Discount': discount,
                      'Quantity': quantity,
                      'Uom': selectedUom,
                      // 'Stock': selectedStock,
                      // 'PlusStock': plusStock,
                    });
                  }

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SalePdf(
                  //       cash: SaleMultiController.saleCash1.toString(),
                  //       joinDate: saleProvider.saleJoiningDate,
                  //       remarks: _remarksController.text,
                  //       // vendor: SaleMultiController.saleVendor1.toString(),
                  //       rowsData: saleRowsData,
                  //       invoiceNumber: saleProvider1.countValue.toString(),
                  //       customer: SaleMultiController.saleCustomer1.toString(),
                  //       salesMan: SaleMultiController.saleSalesMan1.toString(),
                  //       supplyMan:
                  //           SaleMultiController.saleSupplyMan1.toString(),
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  height: 36.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: hoverColor,
                  ),
                  child: Center(
                    child: Text(
                      'Preview',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // saving
                  saleProvider.saleSavingDataToFireStore(
                    context,
                    purchaseCode: saleProvider1.countValue.toString(),
                    paymentVia: SaleAllController.saleCash,
                    remarks: _remarksController.text.toString(),
                    // vendor: SaleAllController.saleVendor,
                    customer: SaleAllController.saleCustomer.toString(),
                    salesMan: SaleAllController.saleSalesMan.toString(),
                    supplyMan: SaleAllController.saleSupplyMan.toString(),
                    date: saleProvider.saleJoiningDate,
                    time: DateTime.now(),
                  );
                  saleProvider1.fetchCountValue();
                  int newCountValue = saleProvider1.countValue;
                  saleProvider1.updateCountValue(count: newCountValue + 1);
                },
                child: Container(
                  height: 36.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: hoverColor,
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // save
                  saleProvider.saleSaveDataToFireStore(
                    context,
                    purchaseCode: saleProvider1.countValue.toString(),
                    paymentVia: SaleAllController.saleCash,
                    remarks: _remarksController.text.toString(),
                    // vendor: SaleAllController.saleVendor,
                    customer: SaleAllController.saleCustomer.toString(),
                    salesMan: SaleAllController.saleSalesMan.toString(),
                    supplyMan: SaleAllController.saleSupplyMan.toString(),
                    date: saleProvider.saleJoiningDate,
                    time: DateTime.now(),
                  );
                  saleProvider1.fetchCountValue();
                  int newCountValue = saleProvider1.countValue;
                  saleProvider1.updateCountValue(count: newCountValue + 1);
                },
                child: Container(
                  height: 36.0,
                  width: 128.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: hoverColor,
                  ),
                  child: Center(
                    child: Text(
                      'Save & New',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SaleMultiController {
  static dynamic saleCash1 = TextEditingController();
  static dynamic saleVendor1 = TextEditingController();
  static dynamic saleCustomer1 = TextEditingController();
  static dynamic saleSalesMan1 = TextEditingController();
  static dynamic saleSupplyMan1 = TextEditingController();
}
