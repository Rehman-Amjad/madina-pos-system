import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madina_pos_system/screens/sales/Provider/sale_builder_provider.dart';
import 'package:madina_pos_system/screens/sales/Provider/sale_items_list.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../model/res/widget/text_widget.dart';
import '../../../responsive.dart';
import '../../Purchase/Provider/formbuilder_firebase_provider.dart';

class SaleList extends StatelessWidget {
  const SaleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder(
          stream: firestore
              .collection('sale')
              .orderBy(Constant.KEY_SALES_TIMESTAMP, descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: hoverColor,
                    ),
                  )
                : snapshot.data!.docs.isEmpty
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "No Sale Found",
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: PaginatedDataTable(
                            header: TextWidget(
                              text:
                                  "Total Sales: ${snapshot.data!.docs.length}",
                              size: 20,
                              color: Colors.white,
                              isBold: false,
                            ),
                            headingRowColor:
                                WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                return hoverColor; // Default color
                              },
                            ),
                            columnSpacing: 20.0,
                            arrowHeadColor: Colors.white,
                            rowsPerPage: snapshot.data!.docs.length > 10
                                ? 10
                                : snapshot.data!.docs.length,
                            columns: const [
                              DataColumn(
                                label: TextWidget(
                                  text: "Code",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Date",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              // DataColumn(
                              //   label: TextWidget(
                              //     text: "Vendor",
                              //     color: Colors.black,
                              //     size: 14,
                              //     isBold: true,
                              //   ),
                              // ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Customer",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Supply Man",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Sales Man",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Payment Via",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Remarks",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Invoice Type",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "View",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Action",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                            ],
                            source: DataTableSourceImpl(
                                items: snapshot.data!.docs,
                                length: snapshot.data!.docs.length,
                                context: context)),
                      );
          },
        ),
      ],
    );
  }
}

class DataTableSourceImpl extends DataTableSource {
  final items;
  final length;
  final context;
  bool _isSecurityCodeValidated = false;

  DataTableSourceImpl(
      {required this.items, required this.length, required this.context});

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          return bgColor; // Default color
        },
      ),
      cells: [
        DataCell(
          TextWidget(
            text: items[index]['saleCode'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: items[index]['date'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        // DataCell(
        //   TextWidget(
        //     text: items[index]['vendor'].toString(),
        //     color: Colors.white,
        //     size: 14.0,
        //     isBold: false,
        //   ),
        // ),
        DataCell(
          TextWidget(
            text: items[index]['customer'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: items[index]['supplyMan'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: items[index]['salesMan'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: items[index]['paymentVia'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: items[index]['remarks'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: items[index]['invoiceType'].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesItemList(
                            purchaseCode: items[index]['saleCode'],
                          )));
            },
            child: TextWidget(
              text: 'View',
              color: Colors.white,
              size: 14.0,
              isBold: false,
            ),
          ),
        ),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GestureDetector(
            //     onTap: () {
            //       Provider.of<MenuAppController>(context, listen: false)
            //           .changeScreenWithParams(Routes.ADD_PURCHASE, parameters: {
            //         'edit': 'true',
            //         "purchaseCode": items[index]["purchaseCode"].toString(),
            //         "date": items[index]["date"].toString(),
            //         "vendor": items[index]["vendor"].toString(),
            //         "remarks": items[index]["remarks"].toString(),
            //         "paymentVia": items[index]["paymentVia"].toString(),
            //         "invoiceType": items[index]["invoiceType"].toString(),
            //       });
            //     },
            //     child: Icon(
            //       Icons.edit,
            //       color: hoverColor,
            //       size: Responsive.isMobile(context) ? 24.0 : 30.0,
            //     )),
            // const SizedBox(
            //   width: 5.0,
            // ),
            GestureDetector(
                onTap: () {
                  if (_isSecurityCodeValidated) {
                    _deleteSale(context, items[index]['saleCode']);
                  } else {
                    _showDeleteDialog(context, items[index]['saleCode']);
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: Responsive.isMobile(context) ? 24.0 : 30.0,
                )),
          ],
        )),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, String saleCode) {
    final _securityCodeController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Security Code'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Please enter your security code to delete this sale.'),
                TextFormField(
                  cursorColor: hoverColor,
                  controller: _securityCodeController,
                  decoration: InputDecoration(
                    labelText: 'Security Code',
                    // labelStyle: TextStyle(color: hoverColor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter security code';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: hoverColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  bool isValid =
                      await _validateSecurityCode(_securityCodeController.text);
                  if (isValid) {
                    _isSecurityCodeValidated = true;
                    Navigator.of(context).pop();
                    _deleteSale(context, saleCode);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: hoverColor,
                      content: Text(
                        'Invalid security code',
                        style: TextStyle(color: Colors.white),
                      ),
                    ));
                  }
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(color: hoverColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _validateSecurityCode(String code) async {
    print("Validating security code: $code");
    return code == '123456';
  }

  void _deleteSale(BuildContext context, String saleCode) {
    Provider.of<SaleBuilderProvider>(context, listen: false)
        .deleteSale(context, saleCode);
  }

  @override
  int get rowCount => length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
