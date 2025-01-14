import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/barcode_scanner/data/repo/fire_store_services.dart';

class ReportService {
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

