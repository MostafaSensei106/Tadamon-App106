import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/helpers/extensions/date_format_extension.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';

class PdfExportServices {
  Future<void> saveDocument(
       List<ScannedLogsProductModel> dataList) async {
    if (dataList.isEmpty) {
      AppToast.showErrorToast('No data to export');
      return;
    }
    final fileName = 'Tadamon_Logs_${DateTime.now().formatted}';
    final pdf = pw.Document();
    final headers = dataList.first.toMap().keys.toList();
    final data = dataList.map((item) => item.toMap().values.toList()).toList();
    final  Uint8List imageBytes = (await rootBundle.load(SenseiConst.tadamonAppImage)).buffer.asUint8List(); 
    final pw.ImageProvider image  = pw.MemoryImage(imageBytes);

     pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // إضافة الصورة في الأعلى
          pw.Center(
            child: pw.Image(image, width: 150, height: 150),
          ),
          pw.SizedBox(height: 20),
          
          // عنوان التقرير بتنسيق جذاب
          pw.Center(
            child: pw.Text(
              " تقرير البيانات",
              style: pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold, ),
            ),
          ),
          pw.SizedBox(height: 20),
          
          // جدول البيانات
          // ignore: deprecated_member_use
      pw.Table.fromTextArray(
            headers: headers,
            data: data.map((row) => row.map((cell) => cell.toString()).toList()).toList(),
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14, ),
            headerDecoration: const pw.BoxDecoration(),
            cellAlignment: pw.Alignment.center,
            cellStyle: const pw.TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
  );

      dynamic selectedDir = await getExternalStorageDirectory() ;
      if (selectedDir != null) {
        final file = File('${selectedDir.path}/$fileName.pdf');
        await file.writeAsBytes(await pdf.save());
        OpenFile.open(file.path);
        AppToast.showSuccessToast('تم الحفظ بنجاح');
      }
      else {
        AppToast.showErrorToast('لم يتم اختيار مجلد');
      }
    }
   
  }

