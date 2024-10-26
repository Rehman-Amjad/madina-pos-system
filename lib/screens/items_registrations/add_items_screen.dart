import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/widget/text_helper.dart';
import '../dashboard/components/header.dart';
import 'components/items_registration_form.dart';

class AddItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
        child: SingleChildScrollView(
      primary: false,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          const SizedBox(height: defaultDrawerHeadHeight + 20.0),
          TextHelper()
              .mNormalText(text: "Items", color: Colors.white, size: 18.0),
          const SizedBox(height: defaultDrawerHeadHeight - 10.0),
          TextHelper().mNormalText(
              text: "Add new Items", color: Colors.white70, size: 14.0),
          const SizedBox(height: defaultDrawerHeadHeight + 20.0),
          ItemsRegistrationForm(
            edit: provider.parameters?['edit'] ?? 'false',
            code: provider.parameters?[Constant.KEY_ITEM_CODE] ?? "no code",
            name: provider.parameters?[Constant.KEY_ITEM_NAME] ??
                'Enter Item Name',
            category: provider.parameters?[Constant.KEY_ITEM_CATEGORY] ??
                'Enter category',
            uom: provider.parameters?[Constant.KEY_ITEM_UOM] ?? 'Enter uom',
            stock:
                provider.parameters?[Constant.KEY_ITEM_STOCK] ?? 'Enter stock',
            quantity: provider.parameters?[Constant.KEY_ITEM_QUANTITY] ??
                'Enter quantity',
            purchasePrice:
                provider.parameters?[Constant.KEY_ITEM_PURCHASE_PRICE] ??
                    'Enter Purchase Price',
            salePrice: provider.parameters?[Constant.KEY_ITEM_SALE_PRICE] ??
                'Enter Sale Price',
            joinDate: provider.parameters?[Constant.KEY_VENDORMAN_JOIN_DATE] ??
                'select date',
            status:
                provider.parameters?[Constant.KEY_STATUS] ?? 'choose status',
          )
        ],
      ),
    ));
  }
}
