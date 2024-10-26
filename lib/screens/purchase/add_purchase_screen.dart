import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../model/res/components/header.dart';
import '../../model/res/widget/text_helper.dart';
import 'components/purchase_form.dart';

class AddPurchaseScreen extends StatelessWidget {
  const AddPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: defaultDrawerHeadHeight + 20.0),
              TextHelper().mNormalText(
                  text: 'Purchase', color: Colors.white, size: 18.0),
              SizedBox(height: defaultDrawerHeadHeight - 10),
              TextHelper().mNormalText(
                  text: "Add New Purchase", color: Colors.white70, size: 14.0),
              SizedBox(height: defaultDrawerHeadHeight + 20.0),
              PurchaseForm(),
            ],
          ),
        ),
      ),
    );
  }
}
