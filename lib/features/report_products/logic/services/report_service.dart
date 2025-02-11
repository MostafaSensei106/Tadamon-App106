import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';

class ReportService {
  static late SharedPreferences pref;

  /// Initializes the [SharedPreferences] instance to use for storing local
  /// reports. This function should be called before any other functions in
  /// this class are called.
  static Future<void> initializePreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  /// Submits a product report with the given details asynchronously.
  ///
  /// If the network is connected, the report is sent to the backend using
  /// [FireStoreServices.sendReportToBackEnd]. If the report is sent successfully,
  /// a success toast is shown with the message 'لقد تلقينا بلاغك'. If an error
  /// occurs during submission, an error toast is shown with the error message.
  ///
  /// If the network is not connected, the report is saved locally using
  /// [_saveReportLocally] and a toast is shown with the message 'لا يوجد انترنت.
  /// سيتم إرسال البلاغ تلقائيًا لاحقًا.'. The report will be sent automatically
  /// when the network becomes available.
   Future<void> sendProductReport(
      Map<String, dynamic> productReport) async {
    if (await NetworkController().checkConnection()) {
      try {
        await FireStoreServices().sendReportToBackEnd(productReport);
        AppToast.showSuccessToast('لقد تلقينا بلاغك');
      } catch (e) {
        AppToast.showErrorToast('حث خطاء');
      }
    } else {
      AppToast.showToast('لا يوجد انترنت. سيتم إرسال البلاغ تلقائيًا لاحقًا.');
      await _saveReportLocally(productReport);
    }
  }

  /// Saves a product report locally so that it can be resent later when the
  /// network becomes available.
  ///
  /// The report is saved as a JSON encoded string in a list of strings in the
  /// local [SharedPreferences] instance. The list is stored under the key
  /// 'localReports'. If the list does not exist, it is created.
  ///
  /// The saved report will be resent automatically when the network becomes
  /// available by calling [resendPendingReports] in the [NetworkController]
  /// when the network becomes available.
  Future<void> _saveReportLocally(Map<String, dynamic> productReport) async {
    List<String> localReports = pref.getStringList('localReports') ?? [];
    localReports.add(jsonEncode(productReport));
    await pref.setStringList('localReports', localReports);
  }


  /// Retrieves a list of locally stored product reports.
  ///
  /// The reports are retrieved from the local [SharedPreferences] instance,
  /// where they are stored as JSON encoded strings in a list under the key
  /// 'localReports'. If no reports are found, an empty list is returned.
  ///
  /// Returns a [Future] that resolves to a list of maps representing the
  /// decoded product reports.

   static Future<List<Map<String, dynamic>>> _getLocalReports() async {
    List<String> localReports = pref.getStringList('localReports') ?? [];
    return localReports.map((report) => jsonDecode(report) as Map<String, dynamic>).toList();
  }

  /// Resends all locally stored product reports if the network is connected.
  ///
  /// This function retrieves pending product reports from the local storage
  /// and attempts to send them to the backend using 
  /// [FireStoreServices.sendReportToBackEnd]. If a report is sent successfully,
  /// it is removed from the local storage using [_clearLocalReports], and a
  /// toast is shown with the message 'تم إرسال بلاغ معلق'. If an error occurs
  /// while sending a report, an error toast is shown with the error message.
  ///
  /// This function is typically used to automatically resend reports when
  /// the network becomes available.

 static Future <void> resendPendingReports() async {
    final localReports = await _getLocalReports();
      for (final report in localReports) {
        try{
        await FireStoreServices().sendReportToBackEnd(report);
        await _clearLocalReports(report);
        AppToast.showToast('تم إرسال بلاغ معلق');
        }catch(e){
          AppToast.showErrorToast(e.toString());
        }
      }
  }



  /// Removes a locally stored product report from the local storage.
  ///
  /// The report to be removed is identified by its JSON encoded string
  /// representation, which is passed as the [report] parameter.
  ///
  /// If the report is found in the local storage, it is removed and the
  /// storage is updated. If the report is not found, no action is taken.
  ///
  /// This function is used by [resendPendingReports] to remove reports from
  /// the local storage after they have been sent to the backend.
   static Future<void> _clearLocalReports(Map<String, dynamic> report) async {
    List<String> localReports = pref.getStringList('localReports') ?? [];
    localReports.remove(jsonEncode(report));
    await pref.setStringList('localReports', localReports);
  }

}
