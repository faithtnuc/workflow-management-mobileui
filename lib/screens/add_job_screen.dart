import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../theme/app_theme.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedClient;

  @override
  void initState() {
    super.initState();
    if (MockDb.clients.isNotEmpty) {
      _selectedClient = MockDb.clients.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('New Job'),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.textMain,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mock save
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Job Created (Mock)')),
                );
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Create',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionLabel('CLIENT'),
              DropdownButtonFormField<String>(
                initialValue: _selectedClient,
                decoration: _inputDecoration('Select Client'),
                items: MockDb.clients
                    .map(
                      (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedClient = v),
              ),

              const SizedBox(height: 24),

              _buildSectionLabel('JOB DETAILS'),
              TextFormField(
                decoration: _inputDecoration('Job Title'),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: _inputDecoration(
                        'Deadline',
                        icon: LucideIcons.calendar,
                      ),
                      readOnly: true,
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(
                            const Duration(days: 7),
                          ),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: 'Review',
                      decoration: _inputDecoration('Status'),
                      items: ['Pending', 'In Progress', 'Review', 'Urgent']
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Description'),
                maxLines: 4,
              ),

              const SizedBox(height: 24),
              _buildSectionLabel('REQUIREMENTS'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildChip('Software'),
                  _buildChip('Print'),
                  _buildChip('3D'),
                  _buildChip('Video', selected: true),
                  _buildChip('Mobile'),
                ],
              ),

              const SizedBox(height: 24),
              _buildSectionLabel('FILES'),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.border,
                    style: BorderStyle.none,
                  ), // Dotted border hard
                ),
                child: CustomPaint(
                  painter: _DottedBorderPainter(),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.uploadCloud,
                          color: AppTheme.textSecondary,
                          size: 32,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap to upload files',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: AppTheme.surface,
      suffixIcon: icon != null
          ? Icon(icon, color: AppTheme.textSecondary)
          : null,
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppTheme.textSecondary,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildChip(String label, {bool selected = false}) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) {},
      selectedColor: AppTheme.primary.withOpacity(0.1),
      checkmarkColor: AppTheme.primary,
      labelStyle: TextStyle(
        color: selected ? AppTheme.primary : AppTheme.textMain,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: selected ? AppTheme.primary : AppTheme.border),
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.border
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ),
    );

    // Simple dash
    final dashPath = Path();
    double dashWidth = 5;
    double dashSpace = 5;
    double distance = 0;
    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
