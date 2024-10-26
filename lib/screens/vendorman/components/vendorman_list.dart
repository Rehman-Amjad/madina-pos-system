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
import '../provider/vendorman_firebase_provider.dart';

class VendorManList extends StatelessWidget {
  const VendorManList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder(
          stream: firestore.collection(Constant.COLLECTION_VENDORMAN)
              .orderBy(Constant.KEY_VENDORMAN_TIMESTAMP,descending: false)
              .snapshots(),
          builder: (context, snapshot){
            return (snapshot.connectionState == ConnectionState.waiting) ?
            const Center(
              child: CircularProgressIndicator(color: hoverColor,),
            ) : snapshot.data!.docs.isEmpty ?
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: secondaryColor,
              ),
              child: Center(child: Text("No Vendor Found",style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 12 : 18,fontWeight: FontWeight.bold
              ),)
                ,),
            ) :
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: PaginatedDataTable(
                  header: TextWidget(text: "Total Vendor: ${snapshot.data!.docs.length}",size: 20,color: Colors.white, isBold: false,),
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
                      size: 14, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Name", color:  Colors.black,
                      size: 14, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Phone", color:  Colors.black,
                      size: 14, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Address", color:  Colors.black,
                      size: 14, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Joining Date", color:  Colors.black,
                      size: 14, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Status", color:  Colors.black,
                      size: 14, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Action", color:  Colors.black,
                      size: 14, isBold: true,),),
                  ],
                  source: DataTableSourceImpl(
                      vendor: snapshot.data!.docs,
                      length: snapshot.data!.docs.length,
                      context: context
                  )),
            );
          },
        ),
      ],
    );
  }
}

class DataTableSourceImpl extends DataTableSource {
  final vendor;
  final length;
  final context;

  DataTableSourceImpl({required this.vendor,required this.length,required this.context});

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
          TextWidget(text: vendor[index][Constant.KEY_VENDORMAN_CODE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(left: 2.0,top: 5.0,bottom: 10.0),
                  decoration: BoxDecoration(
                      color: hoverColor,
                      borderRadius: BorderRadius.circular(3)
                  ),
                  child: const Center(child: Icon(Icons.shopping_basket)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 5.0,bottom: 5.0,top: 5.0),
                  child: TextWidget(text: vendor[index][Constant.KEY_VENDORMAN_NAME].toString(), color: Colors.white,
                    size: 14.0, isBold: false,),),
              ],
            )
        ),
        DataCell(
          TextWidget(text: vendor[index][Constant.KEY_VENDORMAN_PHONE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
          TextWidget(text: vendor[index][Constant.KEY_VENDORMAN_ADDRESS].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
          TextWidget(text: vendor[index][Constant.KEY_VENDORMAN_JOIN_DATE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        DataCell(
          TextWidget(text: vendor[index][Constant.KEY_STATUS].toString(), color: Colors.white,
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
                          .changeScreenWithParams(Routes.ADD_VENDOR, parameters: {
                        'edit':'true',
                        Constant.KEY_VENDORMAN_CODE.toString():vendor[index][Constant.KEY_VENDORMAN_CODE].toString(),
                        Constant.KEY_VENDORMAN_NAME.toString():vendor[index][Constant.KEY_VENDORMAN_NAME].toString(),
                        Constant.KEY_VENDORMAN_PHONE.toString():vendor[index][Constant.KEY_VENDORMAN_PHONE].toString(),
                        Constant.KEY_VENDORMAN_ADDRESS.toString():vendor[index][Constant.KEY_VENDORMAN_ADDRESS].toString(),
                        Constant.KEY_VENDORMAN_JOIN_DATE.toString():vendor[index][Constant.KEY_VENDORMAN_JOIN_DATE].toString(),
                        Constant.KEY_STATUS.toString():vendor[index][Constant.KEY_STATUS].toString(),
                      });
                    },
                    child: Icon(Icons.edit,color: hoverColor,size: Responsive.isMobile(context) ? 24.0 : 30.0,)),
                const SizedBox(width: 5.0,),
                GestureDetector(
                    onTap: (){
                      Provider.of<VendorDataProvider>(context, listen: false)
                          .deleteVendor(id: vendor[index][Constant.KEY_VENDORMAN_CODE].toString(),
                          collection: Constant.COLLECTION_VENDORMAN);
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