import 'package:flutter/material.dart';
import '../models/cafe.dart';
import '../services/cafe_service.dart';
import '../theme/app_theme.dart';
import '../widgets/cafe_card.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final CafeService _cafeService = CafeService();
  List<Cafe> _savedCafes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final all = await _cafeService.getAllCafes();
    if (mounted) {
      setState(() {
        _savedCafes = all.where((c) => c.isFavorite).toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Kafe Favorit Tersimpan'),
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            )
          : _savedCafes.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_border_rounded,
                          size: 64,
                          color: AppTheme.accent.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Belum Ada Kafe Tersimpan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Buka halaman detail kafe dan tekan tombol "Simpan Kafe" untuk menambahkannya ke sini.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.5,
                            color:
                                AppTheme.textSecondary.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _savedCafes.length,
                  itemBuilder: (context, index) {
                    return CafeCard(
                      cafe: _savedCafes[index],
                      isHorizontal: false,
                    );
                  },
                ),
    );
  }
}
