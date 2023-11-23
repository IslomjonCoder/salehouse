import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TDeviceUtils {
  // write api doc
  /// Hides the keyboard.
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// Sets the status bar color.
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  /// Checks if the device is in landscape mode.
  static bool isLandscapeOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Checks if the device is in portrait mode.
  static bool isPortraitOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Sets the full screen mode.
  static setFullScreen(bool isFullScreen) {
    SystemChrome.setEnabledSystemUIMode(
      isFullScreen ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
      // overlays: isFullScreen ? [] : [SystemUiOverlay.top],
    );
  }

  /// Gets the status bar height.
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Gets the bottom navigation bar height.
  static double getBottomNavigationBarHeight(BuildContext context) {
    return kBottomNavigationBarHeight;
  }

  /// Gets the app bar height.
  static double getAppBarHeight(BuildContext context) {
    return kToolbarHeight;
  }

  /// Gets the keyboard height.
  static getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Checks if the device is a physical device.
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// Vibrates the device.
  static void vibrate(Duration duration) {

    HapticFeedback.vibrate();
    Future.delayed(duration, HapticFeedback.vibrate);
  }

  /// Hides the status bar.
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  /// Shows the status bar.
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  /// Checks if the device has internet connection.
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Checks if the device is Android.
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  /// Checks if the device is iOS.
  static bool isIOS() {
    return Platform.isIOS;
  }
}
