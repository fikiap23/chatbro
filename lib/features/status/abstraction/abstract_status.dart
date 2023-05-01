import 'dart:io';
import 'package:chatbro/models/status_model.dart';
import 'package:flutter/material.dart';

abstract class StatusController {
  Future<List<Status>> getStatus(BuildContext context);
  void addStatusText(String text, BuildContext context);
  void addStatusPhotoWithCaption(
      File file, BuildContext context, String caption);
  void addStatusVideoWithCaption(
      File file, BuildContext context, String caption);
  void deleteStatus();
}
