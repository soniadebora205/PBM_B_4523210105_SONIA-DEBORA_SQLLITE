import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../database_helper.dart';

class TambahMahasiswa extends StatefulWidget {
  const TambahMahasiswa({Key? key}) : super(key: key);

  @override
  State<TambahMahasiswa> createState() => _TambahMahasiswaState();
}

class _TambahMahasiswaState extends State<TambahMahasiswa> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl        = TextEditingController();
  final _ttlCtrl         = TextEditingController();
  final _jenisCtrl       = TextEditingController();
  final _alamatCtrl      = TextEditingController();
  final _agamaCtrl       = TextEditingController();
  final _pendidikanCtrl  = TextEditingController();
  final _noHpCtrl        = TextEditingController();
  final _emailCtrl       = TextEditingController();

  String? _photoPath;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose(); _ttlCtrl.dispose(); _jenisCtrl.dispose();
    _alamatCtrl.dispose(); _agamaCtrl.dispose(); _pendidikanCtrl.dispose();
    _noHpCtrl.dispose(); _emailCtrl.dispose();
    super.dispose();
  }

  // Pilih foto dari galeri atau kamera
  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final choice = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil Foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (choice == null) return;
    final picked = await picker.pickImage(source: choice, imageQuality: 80);
    if (picked != null) {
      setState(() => _photoPath = picked.path);
    }
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    await DatabaseHelper.instance.insertStudent({
      'name':          _nameCtrl.text.trim(),
      'ttl':           _ttlCtrl.text.trim(),
      'jenis_kelamin': _jenisCtrl.text.trim(),
      'alamat':        _alamatCtrl.text.trim(),
      'agama':         _agamaCtrl.text.trim(),
      'major':         _pendidikanCtrl.text.trim(),
      'no_hp':         _noHpCtrl.text.trim(),
      'email':         _emailCtrl.text.trim(),
      'photo_path':    _photoPath,
    });

    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mahasiswa berhasil ditambahkan!'),
          backgroundColor: Color(0xFF009688),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mahasiswa',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF009688),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ── Upload Foto ──────────────────────────────
              GestureDetector(
                onTap: _pickPhoto,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE0F2F1),
                    border: Border.all(color: const Color(0xFF009688), width: 2),
                    image: _photoPath != null
                        ? DecorationImage(
                            image: FileImage(File(_photoPath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _photoPath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Color(0xFF009688), size: 28),
                            SizedBox(height: 4),
                            Text('Upload Foto',
                                style: TextStyle(fontSize: 11, color: Color(0xFF009688))),
                          ],
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 24),

              // ── Field-field form ─────────────────────────
              _field('Nama', _nameCtrl, required: true),
              _field('Tempat, Tanggal Lahir', _ttlCtrl),
              _field('Jenis Kelamin', _jenisCtrl),
              _field('Alamat', _alamatCtrl),
              _field('Agama', _agamaCtrl),
              _field('Pendidikan', _pendidikanCtrl, required: true),
              _field('Nomor HP', _noHpCtrl, type: TextInputType.phone),
              _field('Email', _emailCtrl, type: TextInputType.emailAddress),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _simpan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Tambah',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl,
      {bool required = false, TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDDDDDD))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF009688))),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
        ),
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null
            : null,
      ),
    );
  }
}