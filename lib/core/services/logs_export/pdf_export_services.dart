import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PdfExportServices {
  Future<void> saveDocument(String name) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Text(
            'Hello World',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/$name.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}
