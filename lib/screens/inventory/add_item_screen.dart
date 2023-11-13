// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/resources/widgets/custom_text_field.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final TextEditingController itemId = TextEditingController();
  final TextEditingController itemName = TextEditingController();
  final TextEditingController itemSale = TextEditingController();
  final TextEditingController itemBuying = TextEditingController();
  final TextEditingController itemNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MicroCubit(),
      child: BlocConsumer<MicroCubit, MicroStates>(
        listener: (BuildContext context, MicroStates state) {},
        builder: (BuildContext context, MicroStates state) {
          var cubit = MicroCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'رقم المنتج (Barcode)',
                              style: Styles.textStyle14,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'قراءه',
                                    style: Styles.textStyle14,
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    height: '',
                                    controller: itemId,
                                    keyboardType: TextInputType.number,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'النص مطلوب';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'اسم المنتج',
                              style: Styles.textStyle14,
                            ),
                            CustomTextField(
                              height: '',
                              controller: itemName,
                              keyboardType: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'النص مطلوب';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: cubit.isChecked,
                                  onChanged: (bool? value) {
                                    cubit.isCheckedSaleAndBuying();
                                  },
                                ),
                                Text(
                                  'اضافة الاسعار',
                                  style: Styles.textStyle14,
                                ),
                              ],
                            ),
                            if (cubit.isChecked)
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'سعر البيع',
                                          style: Styles.textStyle14,
                                        ),
                                        CustomTextField(
                                          height: '',
                                          hintText: '0.0',
                                          controller: itemSale,
                                          keyboardType: TextInputType.number,
                                          validate: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Text is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "التكلفه",
                                          style: Styles.textStyle14,
                                        ),
                                        CustomTextField(
                                          height: '',
                                          controller: itemBuying,
                                          keyboardType: TextInputType.number,
                                          validate: (value) {
                                            // يمكنك إضافة المزيد من التحقق هنا إذا لزم الأمر
                                            if (value!.isEmpty) {
                                              return 'Text is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            Text(
                              'الكميه',
                              style: Styles.textStyle14,
                            ),
                            CustomTextField(
                              height: '',
                              hintText: '0',
                              controller: itemNumber,
                              keyboardType: TextInputType.number,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'النص مطلوب';
                                }
                                return null;
                              },
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // القيام بالإجراءات المطلوبة هنا
                                    print('11111111111111111111111');
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'حفظ',
                                    style: Styles.textStyle14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
