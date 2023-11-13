import 'package:flutter/material.dart';
import 'package:storage/input_text.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController itemName = TextEditingController();
    TextEditingController itemCount = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_shopping_cart))
        ],
      ),
      body: ListView(
        children: [
          InputText(
              hintText: 'اسم المنتج',
              labelText: '',
              validator: 'اسم المنتج',
              icon: Icons.apps_rounded,
              controller: itemName),
          InputText(
            hintText: 'الكمية',
            labelText: '',
            validator: 'الكمية',
            icon: Icons.numbers,
            controller: itemCount,
            type: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
