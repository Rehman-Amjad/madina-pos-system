import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as piw;
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../model/res/components/header.dart';
import '../../provider/count_value_provider.dart';
import 'components/dashboard_details.dart';

class DashboardScreen extends StatelessWidget {
  final colorList = [
    hoverColor,
    Color(0xFFDA4040),
  ];

  @override
  Widget build(BuildContext context) {
    final provider1 = Provider.of<CountValueProvider>(context, listen: false);
    dynamic code = provider1.countValue;
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
    return const SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          DashboardDetails(
                            title: 'Customer',
                            icons: Icons.person,
                            text: Constant.COLLECTION_CUSTOMER,
                          ),
                          SizedBox(width: 8.0),
                          DashboardDetails(
                            title: 'Supply Man',
                            icons: Icons.shopping_cart_sharp,
                            text: Constant.COLLECTION_SUPPLYMAN,
                          ),
                          SizedBox(width: 8.0),
                          DashboardDetails(
                            title: 'Sales Man',
                            icons: Icons.point_of_sale_sharp,
                            text: Constant.COLLECTION_SALESMAN,
                          ),
                          SizedBox(width: 8.0),
                          DashboardDetails(
                              title: 'Vendor',
                              icons: Icons.person_add_alt,
                              text: Constant.COLLECTION_VENDORMAN)
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        children: [
                          DashboardDetails(
                            title: 'Category',
                            icons: Icons.person,
                            text: Constant.COLLECTION_CATEGORY,
                          ),
                          SizedBox(width: 8.0),
                          DashboardDetails(
                            title: 'Items',
                            icons: Icons.shopping_cart_sharp,
                            text: Constant.COLLECTION_ITEMS,
                          ),
                          SizedBox(width: 8.0),
                          DashboardDetails(
                            title: 'Purchase Invoice',
                            icons: Icons.point_of_sale_sharp,
                            text: Constant.COLLECTION_PURCHASE,
                          ),
                          SizedBox(width: 8.0),
                          DashboardDetails(
                            title: 'Sales Invoice',
                            icons: Icons.person_add_alt,
                            text: Constant.COLLECTION_SALES,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(height: 75.0),
            // Row(
            //   children: [
            //     Container(
            //       height: 220.0,
            //       width: 150.0,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: hoverColor),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Column(
            //         children: [
            //           SizedBox(height: 15.0),
            //           Center(
            //             child: Padding(
            //               padding: EdgeInsets.all(8.0),
            //               child: Text(
            //                 'Total Purchase',
            //                 style: TextStyle(fontSize: 16),
            //               ),
            //             ),
            //           ),
            //           SizedBox(height: 28.0),
            //           StreamBuilder(
            //             stream: FirebaseFirestore.instance
            //                 .collection('purchase')
            //                 .doc(provider1.countValue.toString())
            //                 .snapshots(),
            //             builder: (context,
            //                 AsyncSnapshot<DocumentSnapshot> snapshot) {
            //               if (snapshot.connectionState ==
            //                   ConnectionState.waiting) {
            //                 return Center(
            //                   child:
            //                       CircularProgressIndicator(color: hoverColor),
            //                 );
            //               } else if (snapshot.hasError) {
            //                 return Text('Error: ${snapshot.error}');
            //               } else {
            //                 var purchaseData = snapshot.data!.data();
            //                 if (purchaseData != null &&
            //                     purchaseData is Map<String, dynamic> &&
            //                     purchaseData.containsKey('totalPurchase')) {
            //                   int totalPurchase =
            //                       purchaseData['totalPurchase'] ?? 0;
            //                   return Container(
            //                     child: Center(
            //                       child: Text(
            //                         totalPurchase.toString(),
            //                         style: TextStyle(
            //                           fontSize: 24.0,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 } else {
            //                   return Container(
            //                     padding: EdgeInsets.all(10),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(10),
            //                       color: secondaryColor,
            //                     ),
            //                     child: Center(
            //                       child: Text(
            //                         "Total Purchase not available",
            //                         style: TextStyle(
            //                           fontSize: Responsive.isMobile(context)
            //                               ? 12
            //                               : 18,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 }
            //               }
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(width: 22.0),
            //     Container(
            //       height: 220.0,
            //       width: 150.0,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: hoverColor),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Column(
            //         children: [
            //           SizedBox(height: 15.0),
            //           Center(
            //             child: Padding(
            //               padding: EdgeInsets.all(8.0),
            //               child: Text(
            //                 'Total Sales',
            //                 style: TextStyle(fontSize: 16),
            //               ),
            //             ),
            //           ),
            //           SizedBox(height: 28.0),
            //           Center(
            //             child: Padding(
            //               padding: EdgeInsets.all(8.0),
            //               child: Text(
            //                 '540',
            //                 style: TextStyle(
            //                   fontSize: 24.0,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Spacer(),
            //     piw.PieChart(
            //       legendOptions: piw.LegendOptions(
            //           legendPosition: piw.LegendPosition.left),
            //       chartRadius: MediaQuery.of(context).size.width / 8.2,
            //       dataMap: {
            //         'Purchase Invoice': 43,
            //         'Sales Invoice': 34,
            //       },
            //       animationDuration: Duration(milliseconds: 1200),
            //       chartType: piw.ChartType.ring,
            //       colorList: colorList,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
