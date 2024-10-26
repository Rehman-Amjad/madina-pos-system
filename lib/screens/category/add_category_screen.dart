import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/components/header.dart';
import '../../model/res/widget/text_helper.dart';
import 'components/category_form.dart';

class AddCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider =   Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            TextHelper().mNormalText(text: "Items Category",color: Colors.white,size: 18.0),
            const SizedBox(height: defaultDrawerHeadHeight-10),
            TextHelper().mNormalText(text: "Create new item Category",color: Colors.white70,size: 14.0),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            CategoryForm(
              edit: provider.parameters?['edit'] ?? 'false',
              code: provider.parameters?[Constant.KEY_CATEGORY_ID] ?? "no code",
              name: provider.parameters?[Constant.KEY_CATEGORY_NAME] ?? 'Enter Category Name',
              desc: provider.parameters?[Constant.KEY_CATEGORY_DESC] ?? 'Enter Description',
            )
          ],
        ),
      ),
      )
    );
  }
}
