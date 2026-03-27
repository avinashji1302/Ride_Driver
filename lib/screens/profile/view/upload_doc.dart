import 'dart:io';
import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/auth/login/view/login_screen.dart';
import 'package:app/screens/profile/view_model/upload_doc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'package:app/config/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadDocsScreen extends StatelessWidget {
  const UploadDocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Documents"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Consumer<UploadDocProvider>(
        builder: (context, provider, _) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  /// INFO BOX
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.lightyellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "All documents are optional. You can upload later.",
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// AADHAR
                  _docSection(
                    context,
                    "Aadhar Card",
                    provider.aadharFront,
                    provider.aadharBack,
                    "aadharFront",
                    "aadharBack",
                  ),

                  /// LICENSE
                  _docSection(
                    context,
                    "Driving License",
                    provider.licenseFront,
                    provider.licenseBack,
                    "licenseFront",
                    "licenseBack",
                  ),

                  /// RC
                  _docSection(
                    context,
                    "Vehicle RC",
                    provider.rcFront,
                    provider.rcBack,
                    "rcFront",
                    "rcBack",
                  ),

                  /// PAN
                  _singleDoc(context, "PAN Card", provider.pan, "pan"),

                  // /// INSURANCE
                  // _singleDoc(
                  //   context,
                  //   "Insurance",
                  //   provider.insurance,
                  //   "insurance",
                  // ),

                  const SizedBox(height: 30),

                  /// SUBMIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              final res = await provider.uploadAllDocs();

                              if (res.success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(res.message),
                                    backgroundColor: res.success
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                );

                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen()));
                              }else{
                                 ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(res.message),
                                    backgroundColor: res.success
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryYellow,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: provider.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Submit",
                              style: TextStyle(color: AppColor.black),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// SECTION (FRONT + BACK)
  Widget _docSection(
    BuildContext context,
    String title,
    XFile? front,
    XFile? back,
    String frontKey,
    String backKey,
  ) {
    final provider = context.read<UploadDocProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryYellow),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(child: _uploadBox(context, "Front", front, frontKey)),
              const SizedBox(width: 10),
              Expanded(child: _uploadBox(context, "Back", back, backKey)),
            ],
          ),
        ],
      ),
    );
  }

  /// SINGLE DOC
  Widget _singleDoc(
    BuildContext context,
    String title,
    XFile? file,
    String key,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _pick(context, key),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.primaryYellow),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _preview(file),
              const SizedBox(width: 12),
              Expanded(child: Text(title)),
              Icon(
                file != null ? Icons.check_circle : Icons.arrow_forward_ios,
                color: file != null ? Colors.green : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// UPLOAD BOX
  Widget _uploadBox(
    BuildContext context,
    String label,
    XFile? file,
    String key,
  ) {
    return GestureDetector(
      onTap: () => _pick(context, key),
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColor.lightyellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: file != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(file.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : const Center(child: Icon(Icons.upload)),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  /// PREVIEW
  Widget _preview(XFile? file) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: AppColor.lightyellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: file != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(File(file.path), fit: BoxFit.cover),
            )
          : const Icon(Icons.upload),
    );
  }

  /// PICKER
  void _pick(BuildContext context, String type) {
    final provider = context.read<UploadDocProvider>();

    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              provider.pickDoc(ImageSource.camera, type);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              provider.pickDoc(ImageSource.gallery, type);
            },
          ),
        ],
      ),
    );
  }
}
