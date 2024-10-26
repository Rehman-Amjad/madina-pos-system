import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/MenuAppController.dart';
import '../../model/res/components/side_menu.dart';
import '../../model/routes/routes_name.dart';
import '../../responsive.dart';
import '../Area/add_area_screen.dart';
import '../Area/area_screen.dart';
import '../Stock/low_stock_screen.dart';
import '../category/add_category_screen.dart';
import '../category/category_screen.dart';
import '../customer/add_customer_screen.dart';
import '../customer/customer_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../items_registrations/add_items_screen.dart';
import '../items_registrations/items_screen.dart';
import '../purchase/add_purchase_screen.dart';
import '../purchase/purchase_screen.dart';
import '../saleman/add_salesman_screen.dart';
import '../saleman/saleman_screen.dart';
import '../sales/add_sales_screen.dart';
import '../sales/sales_screen.dart';
import '../supplyman/add_supplyman_screen.dart';
import '../supplyman/supplyman_screen.dart';
import '../uom/add_uom_screen.dart';
import '../uom/uom_screen.dart';
import '../vendorman/add_vendorman_screen.dart';
import '../vendorman/vendorman_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuAppController = Provider.of<MenuAppController>(context);
    Widget screen;
    switch (menuAppController.selectedIndex) {
      case Routes.DASHBOARD_ROUTE:
        screen = DashboardScreen();
        break;
      case Routes.CATEGORY_ROUTE:
        screen = CategoryScreen();
        break;
      case Routes.ADD_CATEGORY_ROUTE:
        screen = AddCategoryScreen();
        break;
      case Routes.SALESMAN:
        screen = SalesManScreen();
        break;
      case Routes.ADD_SALESMAN:
        screen = AddSaleManScreen();
        break;
      case Routes.SUPPLYMAN:
        screen = SupplyManScreen();
        break;
      case Routes.ADD_SUPPLYMAN:
        screen = AddSupplyManScreen();
        break;
      case Routes.VENDOR:
        screen = VendorManScreen();
        break;
      case Routes.ADD_VENDOR:
        screen = AddVendorManScreen();
        break;
      case Routes.CUSTOMER:
        screen = CustomerScreen();
        break;
      case Routes.ADD_CUSTOMER:
        screen = AddCustomerScreen();
        break;
      case Routes.UOM:
        screen = UOMScreen();
        break;
      case Routes.ADD_UOM:
        screen = AddUOMScreen();
        break;

      case Routes.ITEMS_REGISTRATION:
        screen = ItemsScreen();
        break;
      //
      case Routes.ADD_ITEMS_REGISTRATION:
        screen = AddItemsScreen();
        break;
      //
      case Routes.PURCHASE:
        screen = PurchaseScreen();

      case Routes.ADD_PURCHASE:
        screen = AddPurchaseScreen();
      //
      case Routes.SALES:
        screen = SalesScreen();

      case Routes.ADD_SALES:
        screen = AddSalesScreen();

      case Routes.AREA_SCREEN:
        screen = AreaScreen();

      case Routes.ADD_AREA:
        screen = AddAreaScreen();
        break;

    case Routes.LOW_STOCK:
      screen = LowStockScreen();

      default:
        screen =  DashboardScreen();
        break;
    }
    return Scaffold(
      extendBody: true,
      key: context.read<MenuAppController>().scaffoldKey,
      drawer:  PreferredSize(
          preferredSize: Size.infinite,
          child: SideMenu()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 8,
              child: screen,
            ),
          ],
        ),
      ),
    );
  }
}
