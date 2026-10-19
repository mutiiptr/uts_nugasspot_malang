import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/cafe.dart';

class CafeService {
  static final CafeService _instance = CafeService._internal();
  factory CafeService() => _instance;
  CafeService._internal();

  List<Cafe>? _cachedCafes;

  Future<List<Cafe>> getAllCafes() async {
    if (_cachedCafes != null) {
      return _cachedCafes!;
    }

    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/cafes.json');
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      _cachedCafes = jsonList
          .map((item) => Cafe.fromJson(item as Map<String, dynamic>))
          .toList();
      return _cachedCafes!;
    } catch (e) {
      // Fallback jika terjadi kendala load file
      return [];
    }
  }

  Future<List<String>> getCategories() async {
    final cafes = await getAllCafes();
    final Set<String> categories = {'Semua'};
    for (final cafe in cafes) {
      categories.add(cafe.category);
      categories.addAll(cafe.categories);
    }
    return categories.toList();
  }

  Future<List<Cafe>> getPopularCafes({int limit = 6}) async {
    final cafes = await getAllCafes();
    final popular = cafes.where((c) => c.rating >= 4.8).toList();
    popular.sort((a, b) => b.rating.compareTo(a.rating));
    return popular.take(limit).toList();
  }

  Future<List<Cafe>> getCafesByCategory(String category) async {
    final cafes = await getAllCafes();
    if (category == 'Semua') {
      return cafes;
    }
    return cafes
        .where((c) =>
            c.category == category || c.categories.contains(category))
        .toList();
  }

  Future<List<Cafe>> searchCafes(String query, {String? category}) async {
    final cafes = await getAllCafes();
    final cleanQuery = query.trim().toLowerCase();

    return cafes.where((c) {
      final matchesQuery = cleanQuery.isEmpty ||
          c.name.toLowerCase().contains(cleanQuery) ||
          c.address.toLowerCase().contains(cleanQuery) ||
          c.subdistrict.toLowerCase().contains(cleanQuery) ||
          c.tagline.toLowerCase().contains(cleanQuery);

      final matchesCategory = category == null ||
          category == 'Semua' ||
          c.category == category ||
          c.categories.contains(category);

      return matchesQuery && matchesCategory;
    }).toList();
  }

  void toggleFavorite(String cafeId) {
    if (_cachedCafes == null) return;
    final index = _cachedCafes!.indexWhere((c) => c.id == cafeId);
    if (index != -1) {
      final current = _cachedCafes![index];
      _cachedCafes![index] =
          current.copyWith(isFavorite: !current.isFavorite);
    }
  }
}
