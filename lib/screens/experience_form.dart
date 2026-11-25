import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  static const Map<String, String> _categoryOptions = {
    'internship': 'Internship',
    'work': 'Work',
    'organization': 'Organization',
    'volunteer': 'Volunteer',
    'academic': 'Academic',
  };

  String _title = '';
  String _description = '';
  String _category = _categoryOptions.keys.first;
  String _thumbnail = '';
  bool _isSubmitting = false;

  String? _validateOptionalUrl(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    final uri = Uri.tryParse(trimmed);
    final isValid =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!isValid) {
      return 'Masukkan format URL yang valid';
    }
    return null;
  }

  String _friendlyErrorMessage(ApiException e) {
    switch (e.statusCode) {
      case 400:
        return 'Data tidak valid (400). Periksa kembali isian formulir.';
      case 403:
        return 'Akses ditolak (403). Akun tidak memiliki izin.';
      case 404:
        return 'Endpoint tidak ditemukan (404).';
      default:
        if (e.statusCode >= 500) {
          return 'Terjadi kesalahan pada server (${e.statusCode}). Coba lagi nanti.';
        }
        return 'Gagal menyimpan pengalaman (${e.statusCode}).';
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _title = '';
      _description = '';
      _category = _categoryOptions.keys.first;
      _thumbnail = '';
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;
    setState(() {
      _isSubmitting = true;
    });
    final newExperience = Experience(
      title: _title.trim(),
      description: _description.trim(),
      category: _category,
      thumbnail: _thumbnail.trim(),
    );
    try {
      final created = await context.read<ApiClient>().createExperience(
        newExperience,
        token: token,
      );
      if (!mounted) return;
      final action = await showDialog<String>(
        context: context,
        builder: (dialogContext) {
          final displayCategory = created.categoryDisplay.isNotEmpty
              ? created.categoryDisplay
              : created.category;
          return AlertDialog(
            title: const Text('Experience berhasil disimpan!'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${created.title}'),
                  Text('Category: $displayCategory'),
                  Text('Description: ${created.description}'),
                  if (created.thumbnail.isNotEmpty)
                    Text('Thumbnail: ${created.thumbnail}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, 'add_more'),
                child: const Text('Tambah Lagi'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext, 'view_list'),
                child: const Text('Lihat Daftar'),
              ),
            ],
          );
        },
      );
      if (!mounted) return;
      if (action == 'view_list') {
        await Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(builder: (_) => const ExperienceListScreen()),
        );
      } else {
        _resetForm();
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi login kedaluwarsa (401). Silakan login ulang.'),
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_friendlyErrorMessage(e))));
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal terhubung ke server. Periksa koneksi Anda.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Experience Form',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Input 1: Posisi / Peran (Role) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Software Engineer Intern",
                    labelText: "Posisi / Peran *",
                    prefixIcon: const Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) => _title = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Title *",
                    labelText: "Nama Organisasi / Perusahaan *",
                    prefixIcon: const Icon(Icons.category_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categoryOptions.entries
                      .map(
                        (entry) => DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: _isSubmitting
                      ? null
                      : (newValue) {
                          if (newValue != null) {
                            setState(() => _category = newValue);
                          }
                        },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Jelaskan kontribusi dan tanggung jawab utama...',
                    labelText: 'Description *',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: 'https://example.com/thumbnail.png (opsional)',
                    labelText: 'Thumbnail URL (Optional)',
                    prefixIcon: const Icon(Icons.image_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => _thumbnail = value,
                  validator: _validateOptionalUrl,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _isSubmitting ? null : _resetForm,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: _isSubmitting ? null : _submit,
                        icon: _isSubmitting
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.save_outlined),
                        label: Text(_isSubmitting ? 'Menyimpan...' : 'Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
