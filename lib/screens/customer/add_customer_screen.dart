import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/widget/text_helper.dart';
import '../dashboard/components/header.dart';
import 'components/customer_form.dart';

class AddCustomerScreen extends StatelessWidget {
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
              .mNormalText(text: "Customer", color: Colors.white, size: 18.0),
          const SizedBox(height: defaultDrawerHeadHeight - 10),
          TextHelper().mNormalText(
              text: "Add new Customer", color: Colors.white70, size: 14.0),
          const SizedBox(height: defaultDrawerHeadHeight + 20.0),
          CustomerForm(
            edit: provider.parameters?['edit'] ?? 'false',
            code: provider.parameters?[Constant.KEY_CUSTOMER_CODE] ?? "no code",
            name: provider.parameters?[Constant.KEY_CUSTOMER_NAME] ??
                'Enter Customer Name',
            phone: provider.parameters?[Constant.KEY_CUSTOMER_PHONE] ??
                'Enter Phone Number',
            address: provider.parameters?[Constant.KEY_CUSTOMER_ADDRESS] ??
                'Enter Customer Address',
            joinDate: provider.parameters?[Constant.KEY_CUSTOMER_JOIN_DATE] ??
                'select Join date',
            status:
                provider.parameters?[Constant.KEY_STATUS] ?? 'choose status',
            // personName: provider.parameters?[Constant.KEY_PERSON_NAME] ??
            //     'Enter Person Name',
          )
        ],
      ),
    ));
  }
}
