import 'package:flutter/material.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/tadamon.dart';

void main() {
  runApp(TadamonApp(
    AppRouter(),
  ));
  NetworkController().initNetworkController();
}
