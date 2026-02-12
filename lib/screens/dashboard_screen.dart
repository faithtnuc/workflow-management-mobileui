import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/job_card_widget.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const DashboardScreen({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    // Filter active jobs/review
    final jobs = MockDb.jobs;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.navDashboard),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.textMain,
        elevation: 0,
        leading: onMenuPressed != null
            ? IconButton(
                icon: const Icon(LucideIcons.menu),
                onPressed: onMenuPressed,
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      MockDb.user.name,
                      style: const TextStyle(
                        color: AppTheme.textMain,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      MockDb.user.role,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppTheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipOval(
                      child: SvgPicture.asset(
                        MockDb.user.avatar,
                        placeholderBuilder: (context) => Text(
                          MockDb.user.name.substring(0, 1),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummaryCards(context),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.activeJobs,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.filter, size: 16),
                label: Text(AppLocalizations.of(context)!.filter),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.textSecondary,
                  backgroundColor: AppTheme.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppTheme.border),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...jobs.map((job) {
            final client = MockDb.clients.firstWhere(
              (c) => c.id == job.clientId,
            );
            return JobCardWidget(job: job, client: client);
          }),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 175,
            child: _buildCard(
              title: l10n.activeJobs,
              value: '${MockDb.stats['activeJobs']}',
              icon: LucideIcons.briefcase,
              iconColor: Colors.indigo,
              trend: 'up',
              trendLabel: l10n.vsLastMonth,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 175,
            child: _buildCard(
              title: l10n.pendingReviews,
              value: '${MockDb.stats['pendingReviews']}',
              icon: LucideIcons.alertCircle,
              iconColor: Colors.orange,
              subtext: l10n.needsAttention,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 175,
            child: _buildCard(
              title: l10n.completedMonth,
              value: '${MockDb.stats['completedMonth']}',
              icon: LucideIcons.checkCircle,
              iconColor: Colors.green,
              trend: 'up',
              trendLabel: l10n.vsLastMonth,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 175,
            child: _buildCard(
              title: l10n.totalHours,
              value: '${MockDb.stats['totalHours']}',
              icon: LucideIcons.clock,
              iconColor: Colors.blue,
              trend: 'down',
              trendLabel: l10n.vsLastMonth,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    String? trend,
    String? trendLabel,
    String? subtext,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          if (trend != null)
            Row(
              children: [
                Text(
                  trend == 'up' ? '↑ 12%' : '↓ 2%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: trend == 'up' ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  trendLabel ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            )
          else if (subtext != null)
            Text(
              subtext,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
