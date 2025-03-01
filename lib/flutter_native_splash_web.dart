import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'remove_splash_from_web.dart';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

/// A web implementation of the FlutterNativeSplash plugin.
class FlutterNativeSplashWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_native_splash',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = FlutterNativeSplashWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'show':
        try {
          showSplashWeb();
        } catch (e) {
          throw Exception(
            'Did you forget to run "dart run flutter_native_splash:create"? \n Could not run the JS command showSplashWeb()',
          );
        }
        return;
      case 'remove':
        try {
          if (kDebugMode) {
            hideSplashWeb();
          } else {
            removeSplashFromWeb();
          }
        } catch (e) {
          throw Exception(
            'Did you forget to run "dart run flutter_native_splash:create"? \n Could not run the JS command ${kDebugMode ? 'hideSplashWeb' : 'removeSplashFromWeb'}()${kDebugMode ? '\n\nOriginal error:\n$e' : ''}',
          );
        }
        return;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: "flutter_native_splash for web doesn't implement '${call.method}'",
        );
    }
  }
}
