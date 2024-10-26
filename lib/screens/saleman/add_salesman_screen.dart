import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/widget/text_helper.dart';
import '../dashboard/components/header.dart';
import 'components/saleman_form.dart';

class AddSaleManScreen extends StatelessWidget {
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
          Header(),
          SizedBox(height: defaultDrawerHeadHeight + 20.0),
          TextHelper()
              .mNormalText(text: "Sales Man", color: Colors.white, size: 18.0),
          SizedBox(height: defaultDrawerHeadHeight - 10.0),
          TextHelper().mNormalText(
              text: "Add new Sale Man", color: Colors.white70, size: 14.0),
          SizedBox(height: defaultDrawerHeadHeight + 20.0),
          SalesManForm(
            edit: provider.parameters?['edit'] ?? 'false',
            code: provider.parameters?[Constant.KEY_SALESMAN_CODE] ?? "no code",
            name: provider.parameters?[Constant.KEY_SALESMAN_NAME] ??
                'Enter Sales Man Name',
            phone: provider.parameters?[Constant.KEY_SALESMAN_PHONE] ??
                'Enter Phone Number',
            address: provider.parameters?[Constant.KEY_SALESMAN_ADDRESS] ??
                'Enter Sales Man Address',
            joinDate: provider.parameters?[Constant.KEY_SALESMAN_JOIN_DATE] ??
                'select Join date',
            status:
                provider.parameters?[Constant.KEY_STATUS] ?? 'choose status',
          )
        ],
      ),
    ));
  }
}
