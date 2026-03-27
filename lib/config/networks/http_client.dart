import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mime/mime.dart';

class HttpClient {
  //Post method
  static Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(
      Uri.parse(url),
      headers: headers ?? {"Content-Type": "application/json"},
      body: body != null ? jsonEncode(body) : null, //
    );
  }

  //  GET METHOD
  static Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return await http.get(
      Uri.parse(url),
      headers: headers ?? {"Content-Type": "application/json"},
    );
  }

  //put method

  static Future<http.Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.put(
      Uri.parse(url),
      headers: headers ?? {"Content-Type": "application/json"},
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // 🔥 MULTIPART (IMAGE UPLOAD)
  // In your HttpClient.multipart method:

  static Future<http.Response> multipart(
    String url, {
    required File file,
    required String fieldName,
    required Map<String, String> headers,
  }) async {
    final request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(headers);

    // Auto-detect MIME type
    final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
    final mimeTypeParts = mimeType.split('/');

    request.files.add(
      await http.MultipartFile.fromPath(
        fieldName,
        file.path,
        contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
      ),
    );

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }



 static Future<http.Response> docmultipartMultiple(
  String url, {
  required Map<String, File?> files,
  required Map<String, String> headers,
}) async {
  final request = http.MultipartRequest("POST", Uri.parse(url));

  request.headers.addAll(headers);

  for (var entry in files.entries) {
    if (entry.value != null) {
      final file = entry.value!;

      final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
      final mimeTypeParts = mimeType.split('/');

      debugPrint("📤 Uploading FIELD: ${entry.key}");
      debugPrint("📄 File Path: ${file.path}");
      debugPrint("🧠 MIME: $mimeType");

      request.files.add(
        await http.MultipartFile.fromPath(
          entry.key,
          file.path,
          contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
        ),
      );
    }
  }

  final streamedResponse = await request.send();

  final response = await http.Response.fromStream(streamedResponse);

  debugPrint("📥 STATUS CODE: ${response.statusCode}");
  debugPrint("📥 RESPONSE BODY: ${response.body}");

  return response;
}

//   static Future<http.Response> multipartDoc(
//   String url, {
//   Map<String, File>? files, // Changed to a Map for multiple files
//   required Map<String, String> headers,
// }) async {
//   final request = http.MultipartRequest("POST", Uri.parse(url));
//   request.headers.addAll(headers);

//   if (files != null) {
//     for (var entry in files.entries) {
//       final file = entry.value;
//       final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
//       final mimeTypeParts = mimeType.split('/');

//       request.files.add(
//         await http.MultipartFile.fromPath(
//           entry.key, // The field name (e.g., "aadharFront")
//           file.path,
//           contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
//         ),
//       );
//     }
//   }

//   final streamedResponse = await request.send();
//   return await http.Response.fromStream(streamedResponse);
// }
}
