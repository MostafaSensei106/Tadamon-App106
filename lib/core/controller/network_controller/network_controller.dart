import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';

class NetworkController {
  final Connectivity _connectivity = Connectivity();

  void initNetworkController() {
    _connectivity.onConnectivityChanged.listen((results) {
      for (var result in results) {
        _updateConnectionStatus(result);
      }
    });
  }

  Future<bool> checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      AppToast.showErrorToast('لا يوجد اتصال بالانترنت');
      return false;
    }
    return true;
  }

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
