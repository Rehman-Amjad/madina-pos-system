import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/components/header.dart';
import '../../model/res/widget/text_helper.dart';
import '../../responsive.dart';
import 'components/purcahse_list.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

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
                  text: "Purchase List",
                  color: Colors.white,
                  size: Responsive.isMobile(context) ? 14.0 : 18.0,
                ),
                // CustomNeumorphicButton(
                //   press: () {
                //     provider.parameters?.clear();
                //     provider.changeScreen(Routes.ADD_PURCHASE);
                //   },
                //   width: Responsive.isMobile(context) ? 150.0 : 200.0,
                //   height: 50.0,
                //   label: "Add New",
                //   isIcon: false,
                // ),
              ],
            ),
            SizedBox(height: defaultDrawerHeadHeight + 20.0),
            PurchaseList(),
          ],
        ),
      ),
    );
  }
}
