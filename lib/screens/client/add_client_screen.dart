// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:storage/resources/styles.dart';
import 'package:storage/resources/widgets/custom_text_field.dart';
import 'package:storage/resources/widgets/doastWidget.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/cubit/states.dart';

class AddClientScreen extends StatelessWidget {
  AddClientScreen({super.key});
  final TextEditingController itemId = TextEditingController();
  final TextEditingController clientName = TextEditingController();
  final TextEditingController clientPhone = TextEditingController();
  final TextEditingController itemCost = TextEditingController();
  final TextEditingController clientNote = TextEditingController();
  final TextEditingController itemFill = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicroCubit, MicroStates>(
      listener: (BuildContext context, MicroStates state) {
        if (state is InsertDatabaseState) {
          showToast(text: 'تمت إضافة العميل بنجاح', state: ToastState.eRORR);
        }
      },
      builder: (BuildContext context, MicroStates state) {
        var cubit = MicroCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              title: Text(
                'معلومات العميل',
                style: Styles.textStyle25,
              ),
            ),
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
                          // Text(
                          //   'رقم العميل ',
                          //   style: Styles.textStyle14,
                          // ),
                          // CustomTextField(
                          //   height: '',
                          //   controller: itemId,
                          //   keyboardType: TextInputType.number,
                          //   validate: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'النص مطلوب';
                          //     }
                          //     for (var map in cubit.i) {
                          //       if (map.itemNumber == int.tryParse(value)) {
                          //         return 'المنتج موجود';
                          //       }
                          //     }
                          //     return null;
                          //   },
                          // ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'اسم العميل',
                                      style: Styles.textStyle14,
                                    ),
                                    CustomTextField(
                                      label: '',
                                      controller: clientName,
                                      keyboardType: TextInputType.text,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'إدخل اسم العميل ';
                                        }

                                        for (var map in cubit.i) {
                                          if (map.itemName == value) {
                                            return 'الاسم مستخدم مسبقاً ';
                                          }
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
                                      'رقم الهاتف',
                                      style: Styles.textStyle14,
                                    ),
                                    CustomTextField(
                                      label: '',
                                      controller: clientPhone,
                                      keyboardType: TextInputType.phone,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'أدخل رقم الهاتف';
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
                            "ملاحظات",
                            style: Styles.textStyle14,
                          ),
                          CustomTextField(
                            vertical: 130,
                            label: '',
                            hintText: '0',
                            controller: clientNote,
                            keyboardType: TextInputType.text,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('11111111111111111111111');
                                  cubit.insertClientDatabase(
                                      clientName: clientName.text,
                                      clientPhone: clientPhone.text,
                                      clientNOTE: clientNote.text,
                                      onHim: 0.0,
                                      forHim: 0.0);

                                  Navigator.of(context).pop();
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
    );
  }
}
