import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/cash_dropdown.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../screens/sales/component/sales_form.dart';

class CustomerDropDown extends StatefulWidget {
  const CustomerDropDown({Key? key}) : super(key: key);

  @override
  _CustomerDropDownState createState() => _CustomerDropDownState();
}

class _CustomerDropDownState extends State<CustomerDropDown> {
  late TextEditingController _customerController;

  @override
  void initState() {
    super.initState();
    _customerController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ItemsDataProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Customer',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: dataProvider.customer
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ))
                  .toList(),
              value: dataProvider.selectedCustomer,
              onChanged: (value) {
                setState(() {
                  dataProvider.selectedCustomer = value;
                  SaleAllController.saleCustomer = value;
                  SaleMultiController.saleCustomer1 = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 57.0,
                width: 900.0,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200.0,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40.0,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: _customerController,
                searchInnerWidgetHeight: 50.0,
                searchInnerWidget: Container(
                  height: 57.0,
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 4.0,
                    right: 8.0,
                    left: 8.0,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: _customerController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8.0,
                      ),
                      hintText: 'Search for Customer Name...',
                      hintStyle: const TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  _customerController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customerController.dispose();
    super.dispose();
  }
}
