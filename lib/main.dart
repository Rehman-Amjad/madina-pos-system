import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madina_pos_system/provider/count_value_provider.dart';
import 'package:madina_pos_system/provider/items_data_fetch_provider.dart';
import 'package:madina_pos_system/provider/text_color_provider.dart';
import 'package:madina_pos_system/screens/Area/provider/area_provider.dart';
import 'package:madina_pos_system/screens/customer/provider/customer_firebase_provider.dart';
import 'package:madina_pos_system/screens/dashboard/dashboard_screen.dart';
import 'package:madina_pos_system/screens/items_registrations/provider/register_firebase_provider.dart';
import 'package:madina_pos_system/screens/login/login_screen.dart';
import 'package:madina_pos_system/screens/purchase/components/dynamic_form.dart';
import 'package:madina_pos_system/screens/purchase/provider/formbuilder_firebase_provider.dart';
import 'package:madina_pos_system/screens/saleman/provider/salesman_firebase_provider.dart';
import 'package:madina_pos_system/screens/sales/Provider/sale_builder_provider.dart';
import 'package:madina_pos_system/screens/sideMenu/main_screen.dart';
import 'package:madina_pos_system/screens/supplyman/provider/supplyman_firebase_provider.dart';
import 'package:madina_pos_system/screens/uom/provider/uom_provider.dart';
import 'package:madina_pos_system/screens/vendorman/provider/vendorman_firebase_provider.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'controller/MenuAppController.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MenuAppController(),
      ),
      ChangeNotifierProvider(
        create: (context) => TextColorProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CountValueProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SalesManDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SupplyManDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => VendorDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CustomerDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UomProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ItemsDataProvider(),
      ),
      ChangeNotifierProvider(create: (_) => RegisterFirebaseProvider()),
      ChangeNotifierProvider(create: (_) => FormBuilderProvider()),
      ChangeNotifierProvider(create: (_) => SaleBuilderProvider()),
      ChangeNotifierProvider(create: (_) => AreaProvider()),
      ChangeNotifierProvider(create: (_) => FormProvider()),
    ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          home: AdminLoginScreen()
      ),
    );
  }
}

