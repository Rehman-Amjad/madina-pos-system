import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/widget/text_helper.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import 'components/supplyman_list.dart';

class SupplyManScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper().mNormalText(
                    text: "Supply Man List",
                    color: Colors.white,
                    size: Responsive.isMobile(context) ? 14.0 : 18.0),
                // CustomNeumorphicButton(
                //   width: Responsive.isMobile(context) ? 150 :200,
                //   height: 50,
                //   isIcon: false,
                //   label: 'Add New',
                //   press: (){
                //     provider.parameters?.clear();
                //     provider.changeScreen(Routes.ADD_SUPPLYMAN);
                //   },),
                // ButtonWidget(text: "Add New", width: 120, height: 50,backgroundColor: hoverColor,icons: true,
                //     onClicked: (){
                //       Provider.of<MenuAppController>(context, listen: false)
                //           .changeScreen(Routes.ADD_CATEGORY_ROUTE);
                //     }
                // )
              ],
            ),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            const SupplyManList()
          ],
        ),
      ),
    );
  }
}
