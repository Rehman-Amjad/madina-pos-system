import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/widget/text_helper.dart';
import '../dashboard/components/header.dart';
import 'components/vendorman_form.dart';

class AddVendorManScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final provider =   Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: defaultDrawerHeadHeight + 20.0),
              TextHelper().mNormalText(text: "Vendor",color: Colors.white,size: 18.0),
              const SizedBox(height: defaultDrawerHeadHeight-10.0),
              TextHelper().mNormalText(text: "Add new Vendor",color: Colors.white70,size: 14.0),
              const SizedBox(height: defaultDrawerHeadHeight + 20.0),
              VendorManForm(
                edit: provider.parameters?['edit'] ?? 'false',
                code: provider.parameters?[Constant.KEY_VENDORMAN_CODE] ?? "no code",
                name: provider.parameters?[Constant.KEY_VENDORMAN_NAME] ?? 'Enter vendor Name',
                phone: provider.parameters?[Constant.KEY_VENDORMAN_PHONE] ?? 'Enter Phone Number',
                address: provider.parameters?[Constant.KEY_VENDORMAN_ADDRESS] ?? 'Enter vendor Address',
                joinDate: provider.parameters?[Constant.KEY_VENDORMAN_JOIN_DATE] ?? 'select Join date',
                status: provider.parameters?[Constant.KEY_STATUS] ?? 'choose status',
              )
            ],
          ),
        )
    );
  }
}
