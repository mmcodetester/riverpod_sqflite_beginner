import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:provider_app/models/daily_paln_submodule.dart';

import 'pdf_api.dart';

class PDFDocumentApi {
  static Future<File> generate(List<DailyPlanSubModule> module) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("font/pyidaungsu_regular.ttf");
    final ttf = pw.Font.ttf(font);
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        buildHeader(ttf),
        Divider(),
        buildTitle(),
        buildNoteTable(module, ttf),
        Divider(),
        buildTotal(module.length),
        Divider(),
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'all_report.pdf', pdf: pdf);
  }

  static pw.Widget buildHeader(Font ttf) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return pw.Column(children: [
      //SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
        pw.Text("Date - ${today}",
            style: pw.TextStyle(
                font: ttf, fontSize: 14, fontBold: pw.Font.courier()))
      ])
    ]);
  }

  static pw.Widget buildTitle() => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'PLANS',
            style: pw.TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
          pw.Text('Dail Plan Reports', style: pw.TextStyle(fontSize: 16)),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );
  static pw.Widget buildNoteTable(List<DailyPlanSubModule> module, Font ttf) {
    final headers = [
      'Name',
      'Date',
      'Complete',
      'Why Not',
    ];
    final data = module.map((item) {
      String why = '';
      if (item.whynot != null) {
        why = item.whynot!;
      }
      return [
        item.name,
        item.date,
        item.isComplete,
        why,
      ];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      cellStyle: pw.TextStyle(font: ttf),
      data: data,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: FontWeight.bold, font: ttf),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.center,
      },
    );
  }

  static pw.Widget buildTotal(int count) =>
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text("Total Plans"),
        pw.SizedBox(width: 0.1 * PdfPageFormat.inch),
        pw.Text(count.toString()),
        pw.SizedBox(width: 0.1 * PdfPageFormat.inch)
      ]);
}
