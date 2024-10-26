import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/components/header.dart';
import '../../model/res/widget/text_helper.dart';
import '../../responsive.dart';
import 'low_stock_list.dart';

class LowStockScreen extends StatelessWidget {
  const LowStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuAppController>(context, listen: false);
    return SingleChildScrollView(
      primary: false,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultDrawerHeadHeight + 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper().mNormalText(
                  text: "Low Stock List",
                  color: Colors.white,
                  size: Responsive.isMobile(context) ? 14.0 : 18.0,
                ),
              ],
            ),
            SizedBox(height: defaultDrawerHeadHeight + 20.0),
            LowStockList(),
          ],
        ),
      ),
    );
  }
}
