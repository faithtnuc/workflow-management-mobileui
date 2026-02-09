import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;
  final Client client;

  const JobDetailScreen({super.key, required this.job, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textMain),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              client.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '#${job.id}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textMain,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              LucideIcons.moreHorizontal,
              color: AppTheme.textMain,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E293B),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(child: SvgPicture.asset(client.logo)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.titleKey
                            .replaceAll('job', '')
                            .replaceAllMapped(
                              RegExp(r'([A-Z])'),
                              (match) => ' ${match.group(0)}',
                            )
                            .trim(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textMain,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Requested by ${job.requester}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Status & Dates (Grid)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        context,
                        'Status',
                        job.status,
                        icon: LucideIcons.activity,
                      ),
                      _buildInfoItem(
                        context,
                        'Deadline',
                        job.deadline,
                        icon: LucideIcons.calendar,
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        context,
                        'Assignee',
                        job.assignee,
                        icon: LucideIcons.user,
                      ),
                      _buildInfoItem(
                        context,
                        'Internal Deadline',
                        job.internalDeadline,
                        icon: LucideIcons.alertCircle,
                        isUrgent: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Description
            Text(
              'DESCRIPTION',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
              ),
              child: Text(
                job.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textMain,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(job: job, client: client),
                        ),
                      );
                    },
                    icon: const Icon(LucideIcons.messageSquare, size: 18),
                    label: const Text('Messages'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.surface,
                      foregroundColor: AppTheme.primary,
                      elevation: 0,
                      side: const BorderSide(color: AppTheme.border),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.folder, size: 18),
                    label: const Text('Files'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.surface,
                      foregroundColor: AppTheme.textMain,
                      elevation: 0,
                      side: const BorderSide(color: AppTheme.border),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value, {
    required IconData icon,
    bool isUrgent = false,
  }) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isUrgent ? AppTheme.dangerBg : AppTheme.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: isUrgent ? AppTheme.danger : AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: isUrgent ? AppTheme.danger : AppTheme.textMain,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
