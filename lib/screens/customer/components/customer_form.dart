import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controller/MenuAppController.dart';
import '../../../controller/area_dropdown.dart';
import '../../../model/res/widget/button_widget.dart';
import '../../../model/res/widget/custom_textfield.dart';
import '../../../model/res/widget/text_helper.dart';
import '../../../model/res/widget/text_widget.dart';
import '../../../model/routes/routes_name.dart';
import '../../../provider/count_value_provider.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';
import '../provider/customer_firebase_provider.dart';

class CustomerForm extends StatefulWidget {
  final String code, name, phone, address, joinDate, status;
  final String edit;
  String joiningDate = "select Joining date";
  CustomerForm({
    required this.edit,
    required this.code,
    required this.name,
    required this.phone,
    required this.address,
    this.joinDate = "select Join date",
    required this.status,
  }) {
    joiningDate = joinDate;
  }

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  _CustomerFormState() {
    //  widget.edit=='true' ? selectedStatus = widget.status : selectedStatus = statusList[0];
    selectedStatus = statusList[0];
  }

  var nameController = TextEditingController();
  var personNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  String selectedStatus = "";
  var statusList = ['Running', 'Close'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<CountValueProvider>(context, listen: false)
    //     .fetchCountValue();
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final countProvider =
        Provider.of<CountValueProvider>(context, listen: false);
    final dataProvider =
        Provider.of<CustomerDataProvider>(context, listen: false);
    return Container(
        width: size.width,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextHelper().mNormalText(
                    text: "Customer Code: ", color: Colors.white, size: 14.0),
                Consumer<CountValueProvider>(
                  builder: (context, countValue, child) {
                    return TextHelper().mNormalText(
                        text: widget.edit == 'true'
                            ? widget.code
                            : countValue.countValue.toString(),
                        color: hoverColor,
                        size: 16.0);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            TextHelper().mNormalText(
                text: "Customer Name: ", color: Colors.white, size: 14.0),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 1.9,
              child: CustomizeTextField(
                controller: nameController,
                hintText: widget.edit == 'true'
                    ? nameController.text = widget.name
                    : widget.name,
              ),
            ),

            SizedBox(
              height: 15.0,
            ),
            TextHelper().mNormalText(
                text: "Person Name: ", color: Colors.white, size: 14.0),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 1.9,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
              child: Consumer<ItemsDataProvider>(
                builder: (context, value, child) {
                  if (value.area.isEmpty) {
                    value.fetchArea();
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          "No Area Found",
                          style: TextStyle(
                              fontSize: Responsive.isMobile(context) ? 12 : 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    return AreaDropdown();
                  }
                },
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Customer Phone", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 1.9,
                child: CustomizeTextField(
                  controller: phoneController,
                  hintText: widget.edit == 'true'
                      ? phoneController.text = widget.phone
                      : widget.phone,
                )),

            SizedBox(
              height: 20.0,
            ),

            TextHelper().mNormalText(
                text: "Customer Address", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 1.9,
              child: CustomizeTextField(
                controller: addressController,
                hintText: widget.edit == 'true'
                    ? addressController.text = widget.address
                    : widget.address,
              ),
            ),

            // CustomDropDown(
            //   enabled: true,
            //   items: ['close','Running'],
            //   onChanged: (value) {
            //     print(value);
            // },),
            const SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Joining Date", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => _showDatePicker(),
              child: Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 2.9,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                  child: Center(
                    child: TextWidget(
                      text: widget.joiningDate,
                      color: Colors.white,
                      size: 14.0,
                      isBold: false,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Select Status", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 2.9,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
                child: DropdownButtonFormField(
                  value: selectedStatus,
                  items: statusList
                      .map((e) => DropdownMenuItem(
                            child: TextWidget(
                              text: e,
                              color: Colors.white,
                              size: 12.0,
                              isBold: false,
                            ),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value as String;
                    });
                    // selectedGroup = value as String;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: hoverColor,
                  ),
                  dropdownColor: bgColor,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),

            SizedBox(
              height: 20.0,
            ),

            Row(
              children: [
                widget.edit == 'true'
                    ? ButtonWidget(
                        text: "Update",
                        onClicked: () {
                          if (nameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            dataProvider.updateCustomerData(
                                collection: Constant.COLLECTION_CUSTOMER,
                                code: widget.code,
                                name: nameController.text.toString(),
                                phone: phoneController.text.toString(),
                                address: addressController.text.toString(),
                                joinDate: widget.joiningDate.toString(),
                                status: selectedStatus);
                            Get.snackbar("Customer Updated...", "",
                                backgroundColor: hoverColor,
                                colorText: Colors.white);
                          } else {
                            Get.snackbar(
                                "Alert!!!", "Please filled missing fields",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        icons: false,
                        width: 100.0,
                        height: 50.0,
                      )
                    : ButtonWidget(
                        text: "Save",
                        onClicked: () {
                          if (nameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            countProvider.fetchCountValue();
                            int newCountValue = countProvider.countValue;
                            dataProvider.uploadCustomerData(
                                collection: Constant.COLLECTION_CUSTOMER,
                                count: newCountValue,
                                name: nameController.text.toString(),
                                phone: phoneController.text.toString(),
                                address: addressController.text.toString(),
                                joinDate: widget.joiningDate.toString(),
                                status: selectedStatus);

                            countProvider.updateCountValue(
                                count: newCountValue + 1);
                            countProvider.fetchCountValue();
                            nameController.text = "";
                            phoneController.text = "";
                            addressController.text = "";
                            Get.snackbar("New Customer Added", "",
                                backgroundColor: hoverColor,
                                colorText: Colors.white);
                          } else {
                            Get.snackbar(
                                "Alert!!!", "Please filled missing fields",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        icons: false,
                        width: 100.0,
                        height: 50.0,
                      ),
                const SizedBox(
                  width: 20.0,
                ),
                ButtonWidget(
                  text: "Cancel",
                  onClicked: () {
                    Provider.of<MenuAppController>(context, listen: false)
                        .changeScreen(Routes.CUSTOMER);
                  },
                  icons: false,
                  width: 100.0,
                  height: 50.0,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ],
        ));
  }

  void _showDatePicker() async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));

    setState(() {
      widget.joiningDate = DateFormat('dd-MM-yyyy').format(picDate!);
    });
  }
}
