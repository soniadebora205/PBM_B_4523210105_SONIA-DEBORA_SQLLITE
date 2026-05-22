import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas5Page());
}

class Tugas5Page extends StatelessWidget {
  const Tugas5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const HalamanProfil(),
    );
  }
}

// =============================================
// HALAMAN 1 - PROFIL UTAMA
// =============================================
class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- HEADER / HERO SECTION ---
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF48C9B0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: Column(
                  children: [
                    // ========================================
                    // TEMPAT FOTO - Ganti dengan foto kamu!
                    // Caranya: taruh file foto kamu di folder
                    // assets/ lalu ganti NetworkImage di bawah
                    // dengan AssetImage('assets/foto_kamu.jpg')
                    // ========================================
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'foto_mbak_ada.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Placeholder kalau foto belum ada
                            return Container(
                              color: Colors.white24,
                              child: const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Nama
                    const Text(
                      'Sonia Debora Napitupulu',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 6),

                    // NPM Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'NPM: 4523210105',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // --- DATA DIRI ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data Diri',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C63FF),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Card data diri
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _infoRow(Icons.person_outline, 'Nama Lengkap',
                                'Sonia Debora Napitupulu'),
                            _divider(),
                            _infoRow(Icons.badge_outlined, 'NPM', '4523210105'),
                            _divider(),
                            _infoRow(Icons.cake_outlined, 'Tempat/Tgl Lahir',
                                'Depok, 20 Februari 2005'),
                            _divider(),
                            _infoRow(Icons.wc_outlined, 'Jenis Kelamin',
                                'Perempuan'),
                            _divider(),
                            _infoRow(Icons.location_on_outlined, 'Alamat',
                                'Kecamatan Tapos, Kota Depok'),
                            _divider(),
                            _infoRow(Icons.church_outlined, 'Agama',
                                'Kristen'),
                            _divider(),
                            _infoRow(Icons.school_outlined, 'Pendidikan',
                                'S1 Teknik Informatika'),
                            _divider(),
                            _infoRow(Icons.phone_outlined, 'No. HP/WA',
                                '085772905464'),
                            _divider(),
                            _infoRow(Icons.email_outlined, 'Email',
                                'adoradebora99@email.com'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // --- TOMBOL NAVIGASI KE HALAMAN 2 ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HalamanBiodata(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text(
                          'Lihat Biodata Card',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper: baris info
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF6C63FF), size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, color: Color(0xFFEEEEEE));
  }
}

// =============================================
// HALAMAN 2 - BIODATA CARD (Praktik Mandiri)
// =============================================
class HalamanBiodata extends StatelessWidget {
  const HalamanBiodata({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
        title: const Text(
          'Biodata Mahasiswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Display Text - Nama & NPM
              const Text(
                'Sonia Debora Napitupulu',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                '4523210105',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF48C9B0),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 32),

              // Card Biodata
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF48C9B0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    children: [
                      // ========================================
                      // TEMPAT FOTO DI CARD
                      // ========================================
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/foto_sonia.jpg', // <-- GANTI DENGAN FOTO KAMU
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.white24,
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Sonia Debora Napitupulu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 6),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'NPM: 4523210105',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Info row dalam card
                      _cardInfoRow(Icons.cake, 'Depok, 20 Februari 2005'),
                      const SizedBox(height: 10),
                      _cardInfoRow(Icons.location_on, 'Cilangkap, Depok'),
                      const SizedBox(height: 10),
                      _cardInfoRow(Icons.school, 'S1 Teknik Informatika'),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Tombol kembali ke Halaman 1
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text(
                    'Kembali ke Profil',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6C63FF),
                    side: const BorderSide(color: Color(0xFF6C63FF), width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}