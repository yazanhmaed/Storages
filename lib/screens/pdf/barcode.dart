// AvailableProducts

// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

import 'file_handle_api.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfBarcode {
  final List<List<dynamic>> data;

  PdfBarcode({required this.data});
  static Future<File> generate(List<List<dynamic>> data) async {
    final pdf = pw.Document();

    var font = Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));

    final tableHeaders = [
      'رقم المنتج',
      'اسم المنتج',
      'الكمية',
    ];

    final tableData = [
      [
        'Coffee',
        '7',
        '\$ 5',
      ],
      [
        'Blue Berries',
        '5',
        '\$ 10',
      ],
      [
        'Water',
        '1',
        '\$ 3',
      ],
      [
        'Apple',
        '6',
        '\$ 8',
      ],
      [
        'Lunch',
        '3',
        '\$ 90',
      ],
      [
        'Drinks',
        '2',
        '\$ 15',
      ],
      [
        'Lemon',
        '4',
        '\$ 7',
      ],
    ];

    pdf.addPage(pw.Page(
      build: (context) {
        return pw.GridView(
            crossAxisCount: 4,
            mainAxisSpacing: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 4,
            padding: const EdgeInsets.all(20),
            children: [
              for (var i = 0; i < data.length; i++)
                Container(
                  height: 5,
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(20),
                  child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: '${data[i][0]}',
                      textPadding: 5),
                ),
            ]);
      },
    ));

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
