import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tadamon/features/app_toast/app_toast.dart';

class NetworkController {
  final Connectivity _connectivity = Connectivity();

  /// Listen to the network connectivity changes and update the connection status
  /// accordingly. It shows a toast message to the user about the connection type
  /// (e.g. wifi, mobile, ethernet, vpn).
  void initNetworkController() {
    _connectivity.onConnectivityChanged.listen((results) {
      for (var result in results) {
        _updateConnectionStatus(result);
      }
    });
  }

  /// Checks if the device has an internet connection.
  ///
  /// If the device is not connected to the internet, it shows an error toast
  /// message to the user with the message 'لا يوجد اتصال بالانترنت'. This
  /// method returns a boolean value indicating whether the device is connected
  /// or not. If the device is connected to the internet, the method returns
  /// [true], otherwise it returns [false].
  Future<bool> checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      AppToast.showErrorToast('لا يوجد اتصال بالانترنت');
      return false;
    }
    return true;
  }

  /// Updates the connection status based on the given [ConnectivityResult]. It
  /// shows a toast message to the user about the connection type (e.g. wifi,
  /// mobile, ethernet, vpn). If the device is not connected to the internet, it
  /// shows an error toast message to the user with the message 'لا يوجد اتصال
  /// بالانترنت'.
  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        AppToast.showToast('الجهاز متصل بالواي فاي');
        break;
      case ConnectivityResult.mobile:
        AppToast.showToast('الجهاز متصل بالشبكة المحمولة');
        break;
      case ConnectivityResult.ethernet:
        AppToast.showToast('الجهاز متصل بالشبكة السلكية');
        break;

      case ConnectivityResult.vpn:
        AppToast.showToast('الجهاز متصل بالشبكة الافتراضية');
        break;

      case ConnectivityResult.none:
        AppToast.showErrorToast('لا يوجد اتصال بالانترنت');
        break;
      default:
        AppToast.showErrorToast('حدث خطأ ما');
        break;
    }
  }
}
