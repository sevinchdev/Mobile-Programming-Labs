import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/classifier.dart';

enum Source {
  camera('Camera', Icons.photo_camera_outlined),
  gallery('Gallery', Icons.photo_library_outlined),
  download('Download', Icons.cloud_download_outlined);

  const Source(this.label, this.icon);
  final String label;
  final IconData icon;
}

class HistoryEntry {
  HistoryEntry(this.bytes, this.predictions, this.source) : time = DateTime.now();
  final Uint8List bytes;
  final List<Prediction> predictions; // already sorted
  final Source source;
  final DateTime time;
  Prediction get top => predictions.first;
}