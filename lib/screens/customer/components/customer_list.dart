import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controller/MenuAppController.dart';
import '../../../model/res/widget/text_widget.dart';
import '../../../model/routes/routes_name.dart';
import '../../../responsive.dart';
import '../../dashboard/components/header.dart';
import '../../vendorman/provider/vendorman_firebase_provider.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder(
          stream: firestore.collection(Constant.COLLECTION_CUSTOMER)
              .orderBy(Constant.KEY_CUSTOMER_TIMESTAMP,descending: false)
              .snapshots(),
          builder: (context, snapshot){
            return (snapshot.connectionState == ConnectionState.waiting) ?
            const Center(
              child: CircularProgressIndicator(color: hoverColor,),
            ) : snapshot.data!.docs.isEmpty ?
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                color: secondaryColor,
              ),
              child: Center(child: Text("No customer Found",style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,fontWeight: FontWeight.bold
              ),)
                ,),
            ) :
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius)
              ),
              child: PaginatedDataTable(
                  header: TextWidget(text: "Total Customer: ${snapshot.data!.docs.length}",size: 20.0,color: Colors.white, isBold: false,),
                  headingRowColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return hoverColor; // Default color
                    },
                  ),
                  columnSpacing: 20.0,
                  arrowHeadColor: Colors.white,
                  rowsPerPage: snapshot.data!.docs.length >10 ? 10 : snapshot.data!.docs.length,
                  columns: const [
                    DataColumn(label: TextWidget(text: "Code", color: Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Name", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Phone", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Address", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Joining Date", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Status", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Action", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                  ],
                  source: DataTableSourceImpl(
                      customer: snapshot.data!.docs,
                      length: snapshot.data!.docs.length,
                      context: context
                  )
              ),
            );
          },
        ),
      ],
    );
  }
}

class DataTableSourceImpl extends DataTableSource {
  final customer;
  final length;
  final context;

  DataTableSourceImpl({required this.customer,required this.length,required this.context});

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return bgColor; // Default color
        },
      ),
      cells: [
        DataCell(
          TextWidget(text: customer[index][Constant.KEY_CUSTOMER_CODE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
            Row(
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  margin: EdgeInsets.only(left: 2.0,top: 5.0,bottom: 10.0),
                  decoration: BoxDecoration(
                      color: hoverColor,
                      borderRadius: BorderRadius.circular(3.0)
                  ),
                  child: const Center(child: Icon(Icons.shopping_basket)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 5.0,bottom: 5.0,top: 5.0),
                  child: TextWidget(text: customer[index][Constant.KEY_CUSTOMER_NAME].toString(), color: Colors.white,
                    size: 14.0, isBold: false,),),
              ],
            )
        ),
        DataCell(
          TextWidget(text: customer[index][Constant.KEY_CUSTOMER_PHONE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
          TextWidget(text: customer[index][Constant.KEY_CUSTOMER_ADDRESS].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
          TextWidget(text: customer[index][Constant.KEY_CUSTOMER_JOIN_DATE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
          TextWidget(text: customer[index][Constant.KEY_STATUS].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap:(){
                      Provider.of<MenuAppController>(context,listen: false)
                          .changeScreenWithParams(Routes.ADD_CUSTOMER, parameters: {
                        'edit':'true',
                        Constant.KEY_CUSTOMER_CODE.toString():customer[index][Constant.KEY_CUSTOMER_CODE].toString(),
                        Constant.KEY_CUSTOMER_NAME.toString():customer[index][Constant.KEY_CUSTOMER_NAME].toString(),
                        Constant.KEY_CUSTOMER_PHONE.toString():customer[index][Constant.KEY_CUSTOMER_PHONE].toString(),
                        Constant.KEY_CUSTOMER_ADDRESS.toString():customer[index][Constant.KEY_CUSTOMER_ADDRESS].toString(),
                        Constant.KEY_CUSTOMER_JOIN_DATE.toString():customer[index][Constant.KEY_CUSTOMER_JOIN_DATE].toString(),
                        Constant.KEY_STATUS.toString():customer[index][Constant.KEY_STATUS].toString(),
                      });
                    },
                    child: Icon(Icons.edit,color: hoverColor,size: Responsive.isMobile(context) ? 24.0 : 30.0,)),
                const SizedBox(width: 5.0,),
                GestureDetector(
                    onTap: (){
                      Provider.of<VendorDataProvider>(context, listen: false)
                          .deleteVendor(id: customer[index][Constant.KEY_CUSTOMER_CODE].toString(),
                          collection: Constant.COLLECTION_CUSTOMER);
                    },
                    child: Icon(Icons.delete,color: Colors.red,size: Responsive.isMobile(context) ? 24.0 : 30.0,)),
              ],)
        ),
      ],
    );
  }

  @override
  int get rowCount => length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}