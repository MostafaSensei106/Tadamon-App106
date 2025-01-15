import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/features/app_toast/app_toast.dart';
import 'package:tadamon/features/barcode_scanner/data/repo/fire_store_services.dart';

class ReportService {
/// Sends a product report to the backend if there is an internet connection.
/// 
/// The function takes a [productReport] map containing details of the product report.
/// It checks the network connection before attempting to send the report.
/// If the report is successfully sent, a success toast message is shown.
/// If there is an error during the sending process, an error toast message is displayed.
/// If there is no internet connection, a toast message informs the user that the report
/// will be sent automatically once the connection is restored.

  Future<void> sendProductReport(Map<String, dynamic> productReport) async {
    if (await NetworkController().checkConnection() == true) {
      try {
      await FireStoreServices().sendReportToBackEnd(productReport);
      AppToast.showSuccessToast('لقد تلقينا بلاغك');
        }catch(e){
          AppToast.showErrorToast('حث خطاء');
        }
    }else{
      AppToast.showToast('لا يوجد انترنت ولكن عند توافر سوف يتم ارسال بلاغك تلقائيا');
    }
  }

}

