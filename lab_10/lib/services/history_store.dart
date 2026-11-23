import 'package:flutter/foundation.dart';
import '../models/history_entry.dart';

class HistoryStore extends ChangeNotifier {
  final _items = <HistoryEntry>[];
  List<HistoryEntry> get items => List.unmodifiable(_items);
  HistoryEntry? get latest => _items.isEmpty ? null : _items.first;

  void add(HistoryEntry e) {
    _items.insert(0, e); // newest first
    notifyListeners();
  }
}