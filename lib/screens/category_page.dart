import 'package:flutter/material.dart';
import '../models/cafe.dart';
import '../services/cafe_service.dart';
import '../theme/app_theme.dart';
import '../widgets/cafe_card.dart';

class CategoryPage extends StatefulWidget {
  final String initialCategory;

  const CategoryPage({
    super.key,
    this.initialCategory = 'Semua',
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CafeService _cafeService = CafeService();
  final TextEditingController _searchController = TextEditingController();

  late String _selectedCategory;
  List<String> _categories = ['Semua'];
  List<Cafe> _cafes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final categories = await _cafeService.getCategories();
    final cafes = await _cafeService.searchCafes(
      _searchController.text,
      category: _selectedCategory,
    );

    setState(() {
      _categories = categories;
      _cafes = cafes;
      _isLoading = false;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterCafes();
  }

  void _onSearchChanged(String query) {
    _filterCafes();
  }

  Future<void> _filterCafes() async {
    final filtered = await _cafeService.searchCafes(
      _searchController.text,
      category: _selectedCategory,
    );
    setState(() {
      _cafes = filtered;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Katalog Kafe Nugas'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. Search Bar Box
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari nama kafe, area (Suhat/Klojen)...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary.withValues(alpha: 0.7),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppTheme.primary,
                  size: 22,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          _filterCafes();
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.background,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Horizontal Filter Chips (ListView.builder or SingleChildScrollView)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(cat),
                      labelStyle: TextStyle(
                        fontSize: 12.5,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : AppTheme.textPrimary,
                      ),
                      backgroundColor: AppTheme.background,
                      selectedColor: AppTheme.primary,
                      showCheckmark: false,
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.primary
                            : Colors.black.withValues(alpha: 0.08),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (val) {
                        if (val) _onCategorySelected(cat);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // 3. Counter & Quick Info Row
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kategori: $_selectedCategory',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                Text(
                  '${_cafes.length} tempat ditemukan',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // 4. Main List of Cafes
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppTheme.primary),
                  )
                : _cafes.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.coffee_maker_outlined,
                                size: 64,
                                color: AppTheme.accent.withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Kafe Tidak Ditemukan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Coba cari dengan kata kunci lain atau pilih kategori "Semua".',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: AppTheme.textSecondary
                                      .withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _onCategorySelected('Semua');
                                },
                                child: const Text('Reset Filter'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: _cafes.length,
                        itemBuilder: (context, index) {
                          return CafeCard(
                            cafe: _cafes[index],
                            isHorizontal: false,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
