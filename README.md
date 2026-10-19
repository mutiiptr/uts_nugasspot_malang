# ☕ NugasSpot Malang

Aplikasi direktori dan kurasi spot nugas, *co-working space*, dan kafe *WFC (Work From Cafe)* di Kota Malang yang dikembangkan menggunakan **Flutter** dan **Dart**. Proyek ini dirancang untuk memenuhi **Ujian Tengah Semester (UTS) Praktikum Pemrograman Mobile (Semester Ganjil 2025/2026)**.

Aplikasi mengolah data terstruktur lokal dalam format JSON (`assets/data/cafes.json`) yang siap diintegrasikan (*API-ready*) dengan REST API di tahap pengembangan lanjutan, lengkap dengan implementasi layout responsif, navigasi multihalaman, widget interaktif, dan Material 3.

---

## 📱 Ringkasan Halaman Aplikasi

Aplikasi memiliki **4 antarmuka utama** yang saling terhubung:

1. **Halaman Beranda (`home_page.dart`)**:
   - Header sapaan personal mahasiswa & identitas aplikasi.
   - Quick search bar yang langsung terhubung ke katalog.
   - Banner hero interaktif *"Deadline Edition ⚡ (Kafe 24 Jam & Wi-Fi Kencang)"*.
   - Horizontal icon grid 5 kategori kebutuhan nugas.
   - Carousel horizontal *Editor's Pick / Rekomendasi Terpopuler*.
   - Daftar vertikal kafe yang beroperasi 24 jam nonstop di Malang.
2. **Halaman Katalog Kategori (`category_page.dart`)**:
   - Fitur pencarian teks langsung (nama kafe, jalan, kecamatan Lowokwaru/Klojen).
   - Horizontal *Filter Chips* interaktif (*Semua, Focus & Quiet, 24 Jam Nonstop, Kalcer & Aesthetic, Outdoor & Refreshing, Budget Mahasiswa*).
   - Indikator counter jumlah data yang ditemukan.
   - Daftar kartu kafe vertikal menggunakan `ListView.builder` responsif.
   - *Empty state* informatif saat pencarian tidak ditemukan.
3. **Halaman Detail Kafe (`detail_page.dart`)**:
   - `SliverAppBar` dengan hero image dinamis, tombol kembali, dan tombol bookmark favorit.
   - Ringkasan statistik (Rating bintang, kecepatan Wi-Fi dalam Mbps, dan estimasi harga).
   - Deskripsi mendalam suasana kafe dan keunggulan nugas.
   - Indikator tingkat kebisingan (*Noise Level*).
   - Badges fasilitas penunjang nugas (*Wi-Fi fiber, Stopkontak tiap meja, AC, Musholla, dll*).
   - Daftar menu rekomendasi mahasiswa.
   - Alamat lengkap, jam operasional, serta *Sticky Bottom Action Bar* ("Buka di Maps" & "Simpan Kafe").
4. **Halaman Favorit & Profil Pengembang (`saved_page.dart` & `profile_page.dart`)**:
   - Manajemen kafe yang disimpan/dibookmark.
   - Kartu identitas akademik mahasiswa pengembang lengkap (Nama, NIM, Kelas, Dosen Pengampu).

---

## 🔄 Alur Pengolahan Data (*Data Workflow*)

Data kafe dimuat dari file JSON lokal secara asinkron menggunakan `rootBundle`, di-*decode*, kemudian dimapping ke dalam *Data Model Dart* (`Cafe`) yang memiliki fungsi `fromJson()` dan `toJson()`.

```text
┌─────────────────────────────────┐
│     assets/data/cafes.json      │
│  (14 Data Nyata Kafe di Malang) │
└────────────────┬────────────────┘
                 │
                 │ rootBundle.loadString()
                 ▼
┌─────────────────────────────────┐
│          jsonDecode()           │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│         Dart Model Class        │
│          Cafe.fromJson()        │
└────────────────┬────────────────┘
                 │
                 │ List<Cafe>
                 ▼
┌─────────────────────────────────┐
│          CafeService            │
│   (Filter, Search, Categories)  │
└────────────────┬────────────────┘
                 │
        ┌────────┴────────┐
        ▼                 ▼
┌──────────────┐   ┌──────────────┐
│  HomePage    │   │ CategoryPage │
│ (Horizontal  │   │   (Search &  │
│  & Vertical) │   │ FilterChips) │
└───────┬──────┘   └──────┬───────┘
        │                 │
        └────────┬────────┘
                 │ Navigator.push(Detail(cafe))
                 ▼
┌─────────────────────────────────┐
│       DetailPage (GUI)          │
└─────────────────────────────────┘
```

---

## 🛠️ Teknologi & Dependencies yang Digunakan

| Komponen | Versi / Package | Kegunaan |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.47+ | SDK pengembangan aplikasi multiplatform |
| **Bahasa** | Dart 3.13+ | Bahasa pemrograman utama |
| **Desain Sistem** | Material 3 | Desain modern, color palette warm espresso & ivory |
| **Aset Ikon** | `cupertino_icons` & Material Icons | Ikon fasilitas, navigasi, dan rating |
| **Data Engine** | `dart:convert` & `rootBundle` | Parsing file JSON lokal menjadi objek Dart |
| **Navigasi** | `Navigator.push`, `BottomNavigationBar`, `Drawer` | Sistem perpindahan layar terpadu |

---

## 📂 Struktur Direktori Proyek

Proyek ini disusun secara modular mengikuti prinsip *Separation of Concerns* (SoC):

```text
nugasspot_malang/
├── assets/
│   └── data/
│       └── cafes.json             # Dataset 14 kafe kurasi di Malang
│
├── lib/
│   ├── main.dart                  # Entry point aplikasi & konfigurasi Theme
│   │
│   ├── models/
│   │   └── cafe.dart              # Model class Dart (fromJson, toJson, copyWith)
│   │
│   ├── services/
│   │   └── cafe_service.dart      # Pengolah data JSON, filtering & search engine
│   │
│   ├── theme/
│   │   └── app_theme.dart         # Skema warna, tipografi, dan styling Material 3
│   │
│   ├── screens/
│   │   ├── main_navigation_screen.dart # Host BottomNavigationBar & Navigation Drawer
│   │   ├── home_page.dart         # Layar Beranda utama
│   │   ├── category_page.dart     # Layar Katalog & filter kategori
│   │   ├── detail_page.dart       # Layar Detail lengkap informasi kafe
│   │   ├── saved_page.dart        # Layar daftar kafe favorit
│   │   └── profile_page.dart      # Layar profil identitas mahasiswa
│   │
│   └── widgets/
│       ├── cafe_card.dart         # Widget kartu kafe (Horizontal & Vertical)
│       └── facility_badge.dart    # Widget chip fasilitas dinamis dengan ikon
│
├── test/
│   └── widget_test.dart           # Unit test model serialization & widget smoke test
│
├── pubspec.yaml                   # Manifest dependensi & deklarasi folder assets
└── README.md                      # Dokumentasi komprehensif proyek
```

---

## 📋 Daftar Kafe Nyata di Malang yang Dikurasi

1. **Robusto Coffee** (Jl. Raya Tlogomas No. 2, Dinoyo) — *Focus & Quiet, Wi-Fi 65 Mbps, AC terpisah*
2. **CW Coffee & Eatery** (Jl. Raya Tlogomas No. 34) — *Buka 24 Jam Nonstop, Free Refill, Colokan banyak*
3. **ARAH Coffee Gunungan** (Jl. Merapi No. 15, Klojen) — *Buka 24 Jam, Minimalist Aesthetic*
4. **Warkop Brewok Prime** (Jl. Selorejo No. 83, Lowokwaru) — *Buka 24 Jam, 2 Lantai, Budget Mahasiswa*
5. **Kalm Coffee Daily** (Kawasan Samaan, Klojen) — *Buka 24 Jam, Vintage Photobooth Posestation*
6. **Beryl Coffee & Work Space** (Jl. Tawangmangu No. 21) — *Pure Workspace, Kursi ergonomis, Sunyi*
7. **Nowhere Coffee & Eatery** (Jl. Veteran No. 7 / Depan Matos) — *Nuansa Kolam Ikan, Musik Lo-Fi*
8. **Memorandum Coffee House** (Jl. Menur No. 18, Klojen) — *Kopian Kalcer Hits, Specialty Coffee*
9. **Dialoogi Space & Coffee** (Jl. Soekarno Hatta No. D-505) — *Meja komunal panjang, Koridor Suhat*
10. **Nakoa Cafe** (Jl. MT Haryono No. 116) — *Es kopi susu gula aren, Area semi-outdoor luas*
11. **Lafayette Coffee & Eatery** (Jl. Semeru No. 2 / Ijen) — *Gedung heritage, Rooftop view pegunungan*
12. **Gartenhaus Co-Working** (Jl. Kenanga Indah No. 1) — *Rumah kaca tropis, Rimbun, Pet-friendly*
13. **Toko Kopi Jaya** (Jl. Soekarno Hatta No. 24) — *Kopitiam modern, Roti srikaya butter, Hemat*
14. **Kopi Studio 24** (Jl. Sunan Kalijaga No. 24, Dinoyo) — *Buka 24 Jam, Dekat UIN/UB, Markas skripsi*

---

## 🚀 Langkah Menjalankan Aplikasi

Pastikan Flutter SDK sudah terpasang di perangkat Anda.

1. **Clone repositori**:
   ```bash
   git clone https://github.com/<username>/nugasspot_malang.git
   cd nugasspot_malang
   ```

2. **Unduh dependensi**:
   ```bash
   flutter pub get
   ```

3. **Verifikasi kode**:
   ```bash
   flutter analyze lib/ test/
   flutter test
   ```

4. **Jalankan aplikasi**:
   - Di perangkat Android / Emulator:
     ```bash
     flutter run
     ```
   - Di Desktop Windows:
     ```bash
     flutter run -d windows
     ```
   - Di Google Chrome (Web):
     ```bash
     flutter run -d chrome
     ```

---

## 👩‍💻 Identitas Mahasiswa

- **Nama**: Mutiara Putri
- **NIM**: 240605110113
- **Program Studi**: S1 Teknik Informatika
- **Mata Kuliah**: Praktikum Pemrograman Mobile (Kelas A)
- **Dosen Pengampu**: SUPRIYONO, M.Kom
- **Fakultas**: Sains dan Teknologi, UIN Maulana Malik Ibrahim Malang
