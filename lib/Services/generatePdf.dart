import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfGenerator {
  Future generatePdf() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Transfer')
          .orderBy('date')
          .get();

      // Create a PDF document
      final pdf = pw.Document();
      var font = await rootBundle.load("assets/fonts/OpenSans.ttf");
      final ttf = Font.ttf(font);

      // Define page size and margins
      final pageFormat = PdfPageFormat.a4;
      final pageMargin = 40.0;

      // Calculate number of pages
      final int totalPages = (querySnapshot.docs.length / 50).ceil();

      // Generate PDF pages
      for (int page = 0; page < totalPages; page++) {
        // Create a new page
        pdf.addPage(pw.Page(
            pageFormat: pageFormat,
            margin: pw.EdgeInsets.all(pageMargin),
            build: (pw.Context context) {
              // Create a table for this page
              final List<List<pw.Widget>> pageData = [];

              // Add header row to the table
              pageData.add([
                pw.Text("Date", style: pw.TextStyle(font: ttf)),
                pw.Text("Machine Name", style: pw.TextStyle(font: ttf)),
                pw.Text("Machine Model", style: pw.TextStyle(font: ttf)),
                pw.Text("Machine Serial", style: pw.TextStyle(font: ttf)),
                pw.Text("Shifted From", style: pw.TextStyle(font: ttf)),
                pw.Text("Shifted To", style: pw.TextStyle(font: ttf)),
                pw.Text("Remarks", style: pw.TextStyle(font: ttf)),
              ]);

              final int startIndex = page * 50;
              final int endIndex = startIndex + 50 < querySnapshot.docs.length
                  ? startIndex + 50
                  : querySnapshot.docs.length;

              for (int i = startIndex; i < endIndex; i++) {
                final doc = querySnapshot.docs[i];
                // Add row data to the page's table
                pageData.add([
                  pw.Text(doc['date'], style: pw.TextStyle(font: ttf)),
                  pw.Text(doc['machineName'], style: pw.TextStyle(font: ttf)),
                  pw.Text(doc['machineModel'], style: pw.TextStyle(font: ttf)),
                  pw.Text(doc['machineSerial'], style: pw.TextStyle(font: ttf)),
                  pw.Text(doc['outFloor'] == null ? "null" : doc["outFloor"],
                      style: pw.TextStyle(font: ttf)),
                  pw.Text(doc['allocatedFloor'],
                      style: pw.TextStyle(font: ttf)),
                  pw.Text(doc['note'] == null ? "null" : doc["note"],
                      style: pw.TextStyle(font: ttf)),
                ]);
              }

              // Create a table widget for the page
              return pw.Table.fromTextArray(context: context, data: pageData);
            }));
      }

      // Return the PDF as bytes
      // Get the directory for saving files
      // final directory = await getExternalStorageDirectory();
      // if (directory == null) {
      //   print("Error: Failed to get the external storage directory.");
      //   return null;
      // }
      // final filePath = '${directory.path}/example.pdf';
      // final file = File(filePath);
      // await file.writeAsBytes(await pdf.save());
      // return filePath;
      final pdfBytes = await pdf.save();

      // Open the PDF document
      // Get the temporary directory path
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;

      // Write the PDF bytes to a temporary file
      final tempFile = File('$tempPath/example.pdf');
      await tempFile.writeAsBytes(pdfBytes);

      // Open the PDF document
      OpenFile.open(tempFile.path);
      print("PDF Generated");
    } catch (err) {
      print(err.toString());
    }
  }
}
