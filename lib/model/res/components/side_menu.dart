import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../routes/routes_name.dart';
import '../widget/drawer_list_tile.dart';
import '../widget/text_helper.dart';

class SideMenu extends StatelessWidget {
   SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: drawerBackground,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              // child: Image.asset("assets/images/logo.png"),
              child: Center(
                  child: Text(
                    "Madina College P.O.S",
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),

            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper()
                  .mNormalText(text: "Main", color: Colors.blue, size: 14.0),
            ),
            const DrawerListTile(
              index: 22,
              screenIndex: Routes.DASHBOARD_ROUTE,
              title: "Dashboard",
              svgSrc: DASHBOARD_SVG,
            ),

            const Divider(
              thickness: 0.5,
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper().mNormalText(
                  text: "Registration Form", color: Colors.blue, size: 14.0),
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight - 5,
            ),
            const DrawerListTile(
              index: 0,
              screenIndex: Routes.ADD_CATEGORY_ROUTE,
              title: "ADD Category",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),
            const DrawerListTile(
              index: 1,
              screenIndex: Routes.CATEGORY_ROUTE,
              title: "Category History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),


            const DrawerListTile(
              index: 14,
              screenIndex: Routes.ADD_ITEMS_REGISTRATION,
              title: "ADD Items",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 13,
              screenIndex: Routes.ITEMS_REGISTRATION,
              title: "Items History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 11,
              screenIndex: Routes.ADD_UOM,
              title: "ADD UOM",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 12,
              screenIndex: Routes.UOM,
              title: "UOM History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            // const DrawerListTile(
            //   index: 5,
            //   screenIndex: Routes.ADD_SUPPLYMAN,
            //   title: "ADD Supply Man",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),
            //
            // const DrawerListTile(
            //   index: 6,
            //   screenIndex: Routes.SUPPLYMAN,
            //   title: "Supply Man History",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            const DrawerListTile(
              index: 3,
              screenIndex: Routes.ADD_SALESMAN,
              title: "ADD Sales Man",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 4,
              screenIndex: Routes.SALESMAN,
              title: "Sales Man History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 7,
              screenIndex: Routes.ADD_VENDOR,
              title: "ADD Vendor",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 8,
              screenIndex: Routes.VENDOR,
              title: "Vendor History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 9,
              screenIndex: Routes.ADD_CUSTOMER,
              title: "ADD Customer",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 10,
              screenIndex: Routes.CUSTOMER,
              title: "Customer History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            //Purchase LIST
            const Divider(
              thickness: 0.5,
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper().mNormalText(
                  text: "Purchase Forms", color: Colors.blue, size: 14.0),
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight - 5,
            ),

            const DrawerListTile(
              index: 15,
              screenIndex: Routes.ADD_PURCHASE,
              title: "ADD Purchase",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 16,
              screenIndex: Routes.PURCHASE,
              title: "Purchase History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            // const DrawerListTile(
            //   index: 9,
            //   screenIndex: 9,
            //   title: "P. History",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            // const DrawerListTile(
            //   index: 10,
            //   screenIndex: 10,
            //   title: "P. Returns",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            // DrawerListTile(
            //   index: 11,
            //   screenIndex: 11,
            //   title: "P. Returns History",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            //Sale LIST
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper().mNormalText(
                  text: "Sales Forms", color: Colors.blue, size: 14.0),
            ),
            SizedBox(
              height: defaultDrawerHeadHeight - 5,
            ),

            DrawerListTile(
              index: 17,
              screenIndex: Routes.ADD_SALES,
              title: "ADD Sales",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 18,
              screenIndex: Routes.SALES,
              title: "Sales History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            // DrawerListTile(
            //   index: 13,
            //   screenIndex: 13,
            //   title: "Sale History",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            // DrawerListTile(
            //   index: 14,
            //   screenIndex: 14,
            //   title: "Sale Returns",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),
            //
            // DrawerListTile(
            //   index: 15,
            //   screenIndex: 15,
            //   title: "Sale Returns History",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            //Reports LIST
            // Divider(
            //   thickness: 0.5,
            // ),
            SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: defaultPadding),
            //   child: TextHelper()
            //       .mNormalText(text: "Reports", color: Colors.blue, size: 14.0),
            // ),
            // SizedBox(
            //   height: defaultDrawerHeadHeight - 5,
            // ),
            DrawerListTile(
              index: 19,
              screenIndex: 19,
              title: "Stock",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            // DrawerListTile(
            //   index: 17,
            //   screenIndex: 17,
            //   title: "Opening Stock",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            // DrawerListTile(
            //   index: 18,
            //   screenIndex: 18,
            //   title: "Items List",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),

            // DrawerListTile(
            //   index: 19,
            //   screenIndex: Routes.LOW_STOCK,
            //   title: "Low Stock",
            //   svgSrc: "assets/icons/menu_dashboard.svg",
            // ),
          ],
        ),
      ),
      // child: ListView(
      //   children: [
      //     DrawerHeader(
      //      // child: Image.asset("assets/images/logo.png"),
      //       child: Center(child: Text("Waqas Hassan P.O.S")),
      //     ),
      //     DrawerListTile(
      //       title: "Dashboard",
      //       svgSrc: "assets/icons/menu_dashboard.svg",
      //       press: () {
      //         Provider.of<MenuAppController>(context, listen: false)
      //             .changeScreen(0);
      //         if(Responsive.isMobile(context)){
      //           Navigator.pop(context);
      //         }
      //       },
      //     ),
      //     DrawerListTile(
      //       title: "Transaction",
      //       svgSrc: "assets/icons/menu_tran.svg",
      //       press: () {
      //         Provider.of<MenuAppController>(context, listen: false)
      //             .changeScreen(1);
      //         if(Responsive.isMobile(context)){
      //           Navigator.pop(context);
      //         }
      //       },
      //     ),
      //     DrawerListTile(
      //       title: "Task",
      //       svgSrc: "assets/icons/menu_task.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Documents",
      //       svgSrc: "assets/icons/menu_doc.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Store",
      //       svgSrc: "assets/icons/menu_store.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Notification",
      //       svgSrc: "assets/icons/menu_notification.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Profile",
      //       svgSrc: "assets/icons/menu_profile.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Settings",
      //       svgSrc: "assets/icons/menu_setting.svg",
      //       press: () {},
      //     ),
      //   ],
      // ),
    );
  }
}
