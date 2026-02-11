import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';

class DeviceDetails {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        debugPrint('Anrodid  device ID: ${androidInfo.id}');
        return androidInfo.id; // Unique Android ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        debugPrint(
          'iosInfo.identifierForVendor ID: ${iosInfo.identifierForVendor}',
        );
        return iosInfo.identifierForVendor ?? ''; // Unique iOS ID
      }
      return 'unknown';
    } catch (e) {
      debugPrint('Error getting device ID: $e');
      return 'unknown';
    }
  }
}
