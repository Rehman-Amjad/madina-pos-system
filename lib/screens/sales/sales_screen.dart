import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/widget/text_helper.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import 'Provider/sale_list.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

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
                  text: "Sales List",
                  color: Colors.white,
                  size: Responsive.isMobile(context) ? 14.0 : 18.0,
                ),
                // CustomNeumorphicButton(
                //   press: () {
                //     provider.parameters?.clear();
                //     provider.changeScreen(Routes.ADD_SALES);
                //   },
                //   width: Responsive.isMobile(context) ? 150.0 : 200.0,
                //   height: 50.0,
                //   label: "Add New",
                //   isIcon: false,
                // ),
              ],
            ),
            SizedBox(height: defaultDrawerHeadHeight + 20.0),
            SaleList(),
          ],
        ),
      ),
    );
  }
}
