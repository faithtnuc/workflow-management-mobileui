import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../l10n/app_localizations.dart';
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

  String _getLocalizedStatus(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'Completed':
        return l10n.statusCompleted;
      case 'Review':
        return l10n.statusReview;
      case 'Waiting':
        return l10n.statusWaiting;
      case 'Urgent':
        return l10n.statusUrgent;
      case 'In Progress':
        return l10n.statusInProgress;
      default:
        return status;
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
        margin: const EdgeInsets.only(bottom: 8), // Reduced margin
        padding: const EdgeInsets.all(12), // Reduced padding
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Client Logo + Title + Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14, // Smaller avatar
                  backgroundColor: const Color(0xFF1E293B),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipOval(child: SvgPicture.asset(client.logo)),
                  ),
                ),
                const SizedBox(width: 8),
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
                        style: const TextStyle(
                          color: AppTheme.textMain,
                          fontWeight: FontWeight.bold,
                          fontSize: 13, // Smaller font
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        client.name,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 11, // Smaller font
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getLocalizedStatus(context, job.status),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Bottom Row: Deadlines
            Row(
              children: [
                Icon(
                  LucideIcons.calendar,
                  size: 12,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${AppLocalizations.of(context)!.deadline}: ${job.deadline}',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
                const Spacer(),
                if (job.internalDeadline.isNotEmpty) ...[
                  Icon(
                    LucideIcons.calendar, // Changed to Calendar icon
                    size: 12,
                    color: Colors.blue, // Changed color to Blue or Info
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${AppLocalizations.of(context)!.agencyDeadline}: ${job.internalDeadline}',
                    style: const TextStyle(
                      color: Colors.blue, // Changed color to match icon
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
