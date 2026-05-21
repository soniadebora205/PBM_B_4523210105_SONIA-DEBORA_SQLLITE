import 'dart:io';
import 'package:flutter/material.dart';

class ProfilLengkap extends StatelessWidget {
  final Map<String, dynamic> student;
  const ProfilLengkap({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoPath = student['photo_path'] as String?;
    final hasPhoto  = photoPath != null && photoPath.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profil Saya',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF009688),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // ── Header teal ──────────────────────────────────
          Container(
            width: double.infinity,
            color: const Color(0xFF009688),
            padding: const EdgeInsets.only(top: 20, bottom: 28),
            child: Column(
              children: [
                // Avatar
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    color: Colors.grey[300],
                    image: hasPhoto
                        ? DecorationImage(
                            image: FileImage(File(photoPath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !hasPhoto
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  student['name'] ?? '-',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  student['major'] ?? '-',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          // ── Card detail ───────────────────────────────────
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _tile(Icons.calendar_today, 'Tempat/Tgl Lahir',
                      student['ttl'] ?? '-'),
                  _divider(),
                  _tile(Icons.people, 'Jenis Kelamin',
                      student['jenis_kelamin'] ?? '-'),
                  _divider(),
                  _tile(Icons.home, 'Alamat', student['alamat'] ?? '-'),
                  _divider(),
                  _tile(Icons.favorite, 'Agama', student['agama'] ?? '-'),
                  _divider(),
                  _tile(Icons.phone, 'No. HP/WA', student['no_hp'] ?? '-'),
                  _divider(),
                  _tile(Icons.email, 'Email', student['email'] ?? '-'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF009688), size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, indent: 54, color: Color(0xFFF0F0F0));
}