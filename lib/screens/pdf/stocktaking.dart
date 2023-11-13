// stocktaking
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

import 'file_handle_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfStocktaking {
  final List<List<dynamic>> data;

  PdfStocktaking({required this.data});
  static Future<File> generate(List<List<dynamic>> data) async {
    final pdf = pw.Document();
    var font = Font.ttf(await rootBundle.load("assets/font/HacenTunisia.ttf"));
    // final iconImage =
    //     (await rootBundle.load('assets/icon.png')).buffer.asUint8List();

    final tableHeaders = [
      'اسم المنتج',
      'كمية المخزون',
      'الكمية المباعة',
      'أجمالي الكمية ',
    ];

    final tableData = [
      [
        'Coffee',
        '7',
        '\$ 5',
        '1 %',
      ],
      [
        'Blue Berries',
        '5',
        '\$ 10',
        '2 %',
      ],
      [
        'Water',
        '1',
        '\$ 3',
        '1.5 %',
      ],
      [
        'Apple',
        '6',
        '\$ 8',
        '2 %',
      ],
      [
        'Lunch',
        '3',
        '\$ 90',
        '12 %',
      ],
      [
        'Drinks',
        '2',
        '\$ 15',
        '0.5 %',
      ],
      [
        'Lemon',
        '4',
        '\$ 7',
        '0.5 %',
      ],
    ];

    pdf.addPage(
      pw.MultiPage(
        theme: ThemeData.withFont(
            base: Font.ttf(
                await rootBundle.load("assets/font/HacenTunisia.ttf"))),
        textDirection: TextDirection.rtl,
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Row(
              children: [
                // pw.Image(
                //   pw.MemoryImage(iconImage),
                //   height: 72,
                //   width: 72,
                // ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                // pw.Column(
                //   mainAxisSize: pw.MainAxisSize.min,
                //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                //   children: [
                //     pw.Text(
                //       'INVOICE',
                //       style: pw.TextStyle(
                //         fontSize: 17.0,
                //         fontWeight: pw.FontWeight.bold,
                //       ),
                //     ),
                //     pw.Text(
                //       'Flutter Approach',
                //       style: const pw.TextStyle(
                //         fontSize: 15.0,
                //         color: PdfColors.grey700,
                //       ),
                //     ),
                //   ],
                // ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Date : ${DateTime.now().toString()}',
                    ),
                    pw.Text(
                      'Date : ${DateTime.now().toString()}',
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Center(
              child: Text(
                'جرد المخزون',
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.Table.fromTextArray(
              headers: tableHeaders,
              data: data,
              border: null,
              headerStyle:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                // 4: pw.Alignment.centerRight,
              },
            ),
            pw.Divider(),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'إجمالي الكمية',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, font: font),
                              ),
                            ),
                            pw.Text(
                              '\$ 464',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
