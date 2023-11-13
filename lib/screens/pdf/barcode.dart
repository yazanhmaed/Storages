// AvailableProducts

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

    // final iconImage =
    //     (await rootBundle.load('assets/icon.png')).buffer.asUint8List();
    var font = Font.ttf(await rootBundle.load("assets/font/HacenTunisia.ttf"));

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
      build: (context) => pw.GridView(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 15,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '123456789',
              ),
            ),
            Container(
              height: 15,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '123456889',
              ),
            ),
            Container(
              height: 15,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '9876543210',
              ),
            ),
            Container(
              height: 15,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '123456789',
              ),
            ),
            Container(
              height: 15,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '123456889',
              ),
            ),
            Container(
              height: 15,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '9876543210',
              ),
            ),
            Container(
              height: 15,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '123456789',
              ),
            ),
            Container(
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '123456889',
              ),
            ),
            Container(
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: '9876543210',
              ),
            ),
          ]),
    )
        // pw.MultiPage(
        //   theme: ThemeData.withFont(
        //       base: Font.ttf(
        //           await rootBundle.load("assets/font/HacenTunisia.ttf"))),
        //   textDirection: TextDirection.rtl,
        //   // header: (context) {
        //   //   return pw.Text(
        //   //     'Flutter Approach',
        //   //     style: pw.TextStyle(
        //   //       fontWeight: pw.FontWeight.bold,
        //   //       fontSize: 15.0,
        //   //     ),
        //   //   );
        //   // },
        //   build: (context) {
        //     return [
        //       pw.GridView(
        //         crossAxisCount: 2,
        //         children: [
        //            Container(
        //           padding: const EdgeInsets.all(8),
        //           child:  Text('First', style: TextStyle(fontSize: 20)),

        //         ),
        //            Container(
        //           padding: const EdgeInsets.all(8),
        //           child:  Text('First', style: TextStyle(fontSize: 20)),

        //         ),
        //            Container(
        //           padding: const EdgeInsets.all(8),
        //           child:  Text('First', style: TextStyle(fontSize: 20)),

        //         ),
        //            Container(
        //           padding: const EdgeInsets.all(8),
        //           child:  Text('First', style: TextStyle(fontSize: 20)),

        //         ),
        //         ]
        //       )

        //     ];
        //   },
        // ),

        );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
