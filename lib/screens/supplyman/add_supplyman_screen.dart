import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/widget/text_helper.dart';
import '../dashboard/components/header.dart';
import 'components/supplyman_form.dart';

class AddSupplyManScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final provider =   Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: defaultDrawerHeadHeight + 20),
              TextHelper().mNormalText(text: "Supply Man",color: Colors.white,size: 18.0),
              const SizedBox(height: defaultDrawerHeadHeight-10),
              TextHelper().mNormalText(text: "Add new Supply Man",color: Colors.white70,size: 14.0),
              const SizedBox(height: defaultDrawerHeadHeight + 20),
              SupplyManForm(
                edit: provider.parameters?['edit'] ?? 'false',
                code: provider.parameters?[Constant.KEY_SUPPLYMAN_CODE] ?? "no code",
                name: provider.parameters?[Constant.KEY_SUPPLYMAN_NAME] ?? 'Enter Supply Man Name',
                phone: provider.parameters?[Constant.KEY_SUPPLYMAN_PHONE] ?? 'Enter Phone Number',
                address: provider.parameters?[Constant.KEY_SUPPLYMAN_ADDRESS] ?? 'Enter Supply Man Address',
                joinDate: provider.parameters?[Constant.KEY_SUPPLYMAN_JOIN_DATE] ?? 'select Join date',
                status: provider.parameters?[Constant.KEY_STATUS] ?? 'choose status',
              )
            ],
          ),
        )
    );
  }
}
