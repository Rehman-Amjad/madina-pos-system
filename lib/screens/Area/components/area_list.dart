import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controller/MenuAppController.dart';
import '../../../model/res/widget/text_widget.dart';
import '../../../model/routes/routes_name.dart';
import '../../../responsive.dart';
import '../../dashboard/components/header.dart';
import '../provider/area_provider.dart';

class AreaList extends StatelessWidget {
  const AreaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder(
          stream: firestore
              .collection(Constant.COLLECTION_AREA)
              .orderBy('timeStamp', descending: false)
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
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "No Area Found",
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 12.0 : 18.0,
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
                              text: "Total Area: ${snapshot.data!.docs.length}",
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
                                  size: 14.0,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Name",
                                  color: Colors.black,
                                  size: 14.0,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Description",
                                  color: Colors.black,
                                  size: 14.0,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Created By",
                                  color: Colors.black,
                                  size: 14.0,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Action",
                                  color: Colors.black,
                                  size: 14.0,
                                  isBold: true,
                                ),
                              ),
                            ],
                            source: DataTableSourceImpl(
                                area: snapshot.data!.docs,
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
  final area;
  final length;
  final context;

  DataTableSourceImpl(
      {required this.area, required this.length, required this.context});

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
            text: area[index][Constant.KEY_AREA_ID].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(Row(
          children: [
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: 2, top: 5, bottom: 10),
              decoration: BoxDecoration(
                  color: hoverColor, borderRadius: BorderRadius.circular(3)),
              child: const Center(child: Icon(Icons.category)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 5.0, bottom: 5.0, top: 5.0),
              child: TextWidget(
                text: area[index][Constant.KEY_AREA_NAME].toString(),
                color: Colors.white,
                size: 14.0,
                isBold: false,
              ),
            ),
          ],
        )),
        DataCell(
          TextWidget(
            text: area[index][Constant.KEY_AREA_DESC].toString(),
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        const DataCell(
          TextWidget(
            text: "ADMIN",
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(Row(
          children: [
            GestureDetector(
                onTap: () {
                  Provider.of<MenuAppController>(context, listen: false)
                      .changeScreenWithParams(Routes.ADD_AREA, parameters: {
                    'edit': 'true',
                    Constant.KEY_AREA_ID.toString():
                        area[index][Constant.KEY_AREA_ID].toString(),
                    Constant.KEY_AREA_NAME.toString():
                        area[index][Constant.KEY_AREA_NAME].toString(),
                    Constant.KEY_AREA_DESC.toString():
                        area[index][Constant.KEY_AREA_DESC].toString(),
                  });
                },
                child: Icon(
                  Icons.edit,
                  color: hoverColor,
                  size: Responsive.isMobile(context) ? 24 : 30,
                )),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () {
                  Provider.of<AreaProvider>(context, listen: false).deleteArea(
                      id: area[index][Constant.KEY_AREA_ID].toString());
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: Responsive.isMobile(context) ? 24 : 30,
                )),
          ],
        )),
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