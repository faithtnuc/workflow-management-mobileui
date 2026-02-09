import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../screens/job_detail_screen.dart';
import '../theme/app_theme.dart';

class JobCardWidget extends StatelessWidget {
  final Job job;
  final Client client;

  const JobCardWidget({super.key, required this.job, required this.client});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppTheme.success;
      case 'Review':
        return const Color(0xFF4F46E5); // Indigo
      case 'Waiting':
        return AppTheme.warning;
      case 'Urgent':
        return AppTheme.danger;
      default:
        return AppTheme.info;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Completed':
        return AppTheme.successBg;
      case 'Review':
        return const Color(0xFFEEF2FF); // Indigo 50
      case 'Waiting':
        return AppTheme.warningBg;
      case 'Urgent':
        return AppTheme.dangerBg;
      default:
        return AppTheme.infoBg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(job.status);
    final statusBgColor = _getStatusBgColor(job.status);

    return GestureDetector(
      onTap: () {
        // Need to import JobDetailScreen usage in file or ensure it's available
        // Since implementing circular dependency might be tricky with simple files,
        // I will assume simple import works or context based navigation.
        // Actually better to use Navigator in parent, but let's do it here.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailScreen(job: job, client: client),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        job.status == 'Urgent'
                            ? LucideIcons.alertCircle
                            : LucideIcons.clock,
                        size: 12,
                        color: statusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        job.status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  job.deadline,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF1E293B),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipOval(child: SvgPicture.asset(client.logo)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // Use a mapping or helper for localized titles if needed, for now using key nicely formatted
                        job.titleKey
                            .replaceAll('job', '')
                            .replaceAllMapped(
                              RegExp(r'([A-Z])'),
                              (match) => ' ${match.group(0)}',
                            )
                            .trim(),
                        style: const TextStyle(
                          color: AppTheme.textMain,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${client.name} • ${job.requester}',
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              job.description,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  LucideIcons.messageSquare,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${job.messages} Client',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  LucideIcons.messageCircle,
                  size: 14,
                  color: Color(0xFFF97316),
                ), // Orange
                const SizedBox(width: 4),
                Text(
                  '${job.internalMessages} Internal',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFF97316),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  LucideIcons.chevronRight,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
