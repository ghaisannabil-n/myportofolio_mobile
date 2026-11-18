import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _role = "";
  String _organization = "";
  String _employmentType = "Internship";
  String _description = "";
  String _proofLink = "";
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _employmentTypes = [
    'Internship',
    'Full-time',
    'Part-time',
    'Contract',
    'Organization / Committee',
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return "Belum dipilih";
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  Future<void> _selectDate(BuildContext context, {required bool isStart}) async {
    final DateTime now = DateTime.now();
    final DateTime initial = isStart
        ? (_startDate ?? now)
        : (_endDate ?? _startDate ?? now);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _role = "";
      _organization = "";
      _employmentType = "Internship";
      _description = "";
      _proofLink = "";
      _startDate = null;
      _endDate = null;
    });
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
                  onChanged: (String? value) {
                    setState(() {
                      _role = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Posisi atau peran tidak boleh kosong!";
                    }
                    if (value.trim().length < 3) {
                      return "Posisi minimal terdiri dari 3 karakter!";
                    }
                    if (value.trim().length > 100) {
                      return "Posisi maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Fakultas Ilmu Komputer UI",
                    labelText: "Nama Organisasi / Perusahaan *",
                    prefixIcon: const Icon(Icons.business_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _organization = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama organisasi tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Nama organisasi maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Tipe Pengalaman",
                    prefixIcon: const Icon(Icons.work_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  initialValue: _employmentType,
                  items: _employmentTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _employmentType = newValue!;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<bool>(
                  validator: (_) {
                    if (_startDate == null || _endDate == null) {
                      return "Tanggal mulai dan tanggal selesai wajib dipilih!";
                    }
                    if (_endDate!.isBefore(_startDate!)) {
                      return "Tanggal selesai tidak boleh mendahului tanggal mulai!";
                    }
                    return null;
                  },
                  builder: (FormFieldState<bool> fieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    _selectDate(context, isStart: true),
                                icon: const Icon(Icons.calendar_today_outlined),
                                label: Text(
                                  "Mulai: ${_formatDate(_startDate)}",
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    _selectDate(context, isStart: false),
                                icon: const Icon(Icons.event_available_outlined),
                                label: Text(
                                  "Selesai: ${_formatDate(_endDate)}",
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (fieldState.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                            child: Text(
                              fieldState.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Jelaskan kontribusi dan tanggung jawab utama...",
                    labelText: "Deskripsi Pengalaman *",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    if (value.trim().length < 10) {
                      return "Deskripsi minimal terdiri dari 10 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://linkedin.com/in/username (opsional)",
                    labelText: "Tautan Bukti / Sertifikat",
                    prefixIcon: const Icon(Icons.link),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _proofLink = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final uri = Uri.tryParse(value.trim());
                      final isValidUrl = uri != null &&
                          (uri.scheme == 'http' || uri.scheme == 'https') &&
                          uri.host.isNotEmpty;
                      if (!isValidUrl) {
                        return "Masukkan format URL yang valid (diawali http:// atau https://)!";
                      }
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 12),
              
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _resetForm,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Reset"),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(primaryColor),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Pengalaman berhasil disimpan!',
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Posisi: ${_role.trim()}'),
                                        Text(
                                          'Organisasi: ${_organization.trim()}',
                                        ),
                                        Text('Tipe: $_employmentType'),
                                        Text(
                                          'Periode: ${_formatDate(_startDate)} s.d. ${_formatDate(_endDate)}',
                                        ),
                                        Text(
                                          'Deskripsi: ${_description.trim()}',
                                        ),
                                        Text(
                                          'Tautan: ${_proofLink.trim().isEmpty ? "-" : _proofLink.trim()}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _resetForm();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        icon: const Icon(Icons.save_outlined,
                            color: Colors.white),
                        label: const Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
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