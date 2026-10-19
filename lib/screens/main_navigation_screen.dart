import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'saved_page.dart';
import 'profile_page.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    CategoryPage(),
    SavedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'MP',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              accountName: const Text(
                'Mutiara Putri',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              accountEmail: const Text(
                'NIM: 240605110113 • TI Kelas A',
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded, color: AppTheme.primary),
              title: const Text('Beranda NugasSpot'),
              selected: _currentIndex == 0,
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view_rounded, color: AppTheme.primary),
              title: const Text('Katalog Kafe Lengkap'),
              selected: _currentIndex == 1,
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_rounded, color: AppTheme.primary),
              title: const Text('Kafe Favorit Tersimpan'),
              selected: _currentIndex == 2,
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_rounded, color: AppTheme.primary),
              title: const Text('Profil Pengembang'),
              selected: _currentIndex == 3,
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 3);
              },
            ),
            const Divider(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'KATEGORI POPULER',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: AppTheme.textSecondary.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.all_inclusive_rounded, size: 20, color: AppTheme.accent),
              title: const Text('Kafe 24 Jam Nonstop'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryPage(initialCategory: '24 Jam Nonstop'),
                  ),
                );
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.headphones_rounded, size: 20, color: AppTheme.accent),
              title: const Text('Focus & Quiet (Hening)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryPage(initialCategory: 'Focus & Quiet'),
                  ),
                );
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.savings_rounded, size: 20, color: AppTheme.accent),
              title: const Text('Budget Mahasiswa / Pelajar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryPage(initialCategory: 'Budget Mahasiswa'),
                  ),
                );
              },
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                'NugasSpot Malang v1.0.0\nPraktikum Pemrograman Mobile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.textSecondary.withValues(alpha: 0.6),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view_rounded),
              label: 'Katalog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_rounded),
              activeIcon: Icon(Icons.bookmark_rounded),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
