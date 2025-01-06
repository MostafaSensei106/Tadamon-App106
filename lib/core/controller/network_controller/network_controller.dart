import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkController {
  final Connectivity _connectivity = Connectivity();

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void initNetworkController() {
    _connectivity.onConnectivityChanged.listen((results) {
      for (var result in results) {
        _updateConnectionStatus(result);
      }
    });
  }

  Future<bool> checkConnection() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      showToast('لا يوجد اتصال بالانترنت');
      return false;
    }
    return true;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        showToast('الجهاز متصل بالواي فاي');
        break;
      case ConnectivityResult.mobile:
        showToast('الجهاز متصل بالشبكة المحمولة');
        break;
      case ConnectivityResult.ethernet:
        showToast('الجهاز متصل بالشبكة السلكية');
        break;

      case ConnectivityResult.vpn:
        showToast('الجهاز متصل بالشبكة الافتراضية');
        break;

      case ConnectivityResult.none:
        showToast('لا يوجد اتصال بالانترنت');
        break;
      default:
        showToast('حدث خطأ ما');
        break;
    }
  }
}
