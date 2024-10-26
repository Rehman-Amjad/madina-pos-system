import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DynamicFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormProvider>(context, listen: false);
    final hoverColor = Colors.blue;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<FormProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Serial no: ${index + 1}'),
                            if (index == value.items.length - 1)
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => value.deleteItem(index),
                              ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        value.items[index],
                        SizedBox(height: 12.0),
                        Divider(),
                        SizedBox(height: 18.0),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    context: context,
                    label: 'Add',
                    color: hoverColor,
                    onPressed: () => value.addItem(context),
                  ),
                  _buildActionButton(
                    context: context,
                    label: 'Save & Preview',
                    color: hoverColor,
                    onPressed: () => value.saveAndPreview(context),
                  ),
                  _buildActionButton(
                    context: context,
                    label: 'Preview',
                    color: hoverColor,
                    onPressed: () => value.previewData(),
                  ),
                  _buildActionButton(
                    context: context,
                    label: 'Save',
                    color: hoverColor,
                    onPressed: () => value.saveData(context),
                  ),
                  _buildActionButton(
                    context: context,
                    label: 'Save & New',
                    color: hoverColor,
                    onPressed: () => value.saveAndNew(context),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 36.0,
        width: 90.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class FormProvider extends ChangeNotifier {
  List<Widget> items = [];
  List<FormControllers> controllers = [];

  void addItem(BuildContext context) {
    final formController = FormControllers();
    controllers.add(formController);
    items.add(_buildFormField(formController));
    notifyListeners();
  }

  void deleteItem(int index) {
    if (items.isNotEmpty) {
      items.removeAt(index);
      controllers.removeAt(index);
      notifyListeners();
    }
  }

  Widget _buildFormField(FormControllers controller) {
    return Column(
      children: [
        TextField(controller: controller.itemNameController, decoration: InputDecoration(labelText: 'Item Name')),
        TextField(controller: controller.itemCodeController, decoration: InputDecoration(labelText: 'Item Code')),
        TextField(controller: controller.uomController, decoration: InputDecoration(labelText: 'UOM')),
        TextField(controller: controller.stockController, decoration: InputDecoration(labelText: 'Stock')),
        TextField(controller: controller.quantityController, decoration: InputDecoration(labelText: 'Quantity')),
        TextField(controller: controller.priceRateController, decoration: InputDecoration(labelText: 'Price Rate')),
        TextField(controller: controller.saleRateController, decoration: InputDecoration(labelText: 'Sale Rate')),
        TextField(controller: controller.discountController, decoration: InputDecoration(labelText: 'Discount')),
        TextField(controller: controller.totalController, decoration: InputDecoration(labelText: 'Total')),
      ],
    );
  }

  void saveAndPreview(BuildContext context) {
    final rowsData = _buildRowsData();
    print('Saving & Previewing Data: $rowsData');
    // Navigate to preview screen or show preview
  }

  void previewData() {
    final rowsData = _buildRowsData();
    print('Previewing Data: $rowsData');
  }

  void saveData(BuildContext context) {
    final rowsData = _buildRowsData();
    print('Saving Data: $rowsData');
    // Save data logic
  }

  void saveAndNew(BuildContext context) {
    saveData(context);
    addItem(context);
  }

  List<Map<String, String>> _buildRowsData() {
    List<Map<String, String>> rowsData = [];
    for (int i = 0; i < items.length; i++) {
      FormControllers controller = controllers[i];
      rowsData.add({
        'SerialNumber': (i + 1).toString(),
        'ItemName': controller.itemNameController.text,
        'ItemCode': controller.itemCodeController.text,
        'Uom': controller.uomController.text,
        'Stock': controller.stockController.text,
        'Quantity': controller.quantityController.text,
        'PriceRate': controller.priceRateController.text,
        'SaleRate': controller.saleRateController.text,
        'Discount': controller.discountController.text,
        'Total': controller.totalController.text,
      });
    }
    return rowsData;
  }
}

class FormControllers {
  final itemNameController = TextEditingController();
  final itemCodeController = TextEditingController();
  final uomController = TextEditingController();
  final stockController = TextEditingController();
  final quantityController = TextEditingController();
  final priceRateController = TextEditingController();
  final saleRateController = TextEditingController();
  final discountController = TextEditingController();
  final totalController = TextEditingController();
}
