import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

/// Thin Hive wrapper used as a key-value cache.
/// Stores raw JSON strings so no TypeAdapters / code-gen needed.
class HiveCacheService {
  static const String _boxName = 'home_cache';
  static const String _categoriesKey = 'categories';

  final Box _box;

  HiveCacheService(this._box);

  // ── open ──────────────────────────────────────────────────────────────────
  static Future<HiveCacheService> init() async {
    final box = await Hive.openBox(_boxName);
    return HiveCacheService(box);
  }

  // ── categories ────────────────────────────────────────────────────────────
  Future<void> saveCategories(List<Map<String, dynamic>> categories) async {
    await _box.put(_categoriesKey, jsonEncode(categories));
  }

  List<Map<String, dynamic>>? getCategories() {
    final raw = _box.get(_categoriesKey);
    if (raw == null) return null;
    final decoded = jsonDecode(raw as String) as List;
    return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  // ── meals ─────────────────────────────────────────────────────────────────
  Future<void> saveMeals(
      String category, List<Map<String, dynamic>> meals) async {
    await _box.put('meals_$category', jsonEncode(meals));
  }

  List<Map<String, dynamic>>? getMeals(String category) {
    final raw = _box.get('meals_$category');
    if (raw == null) return null;
    final decoded = jsonDecode(raw as String) as List;
    return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  // ── clear ─────────────────────────────────────────────────────────────────
  Future<void> clear() async => _box.clear();
}
