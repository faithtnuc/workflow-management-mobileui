import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
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
        title: const Text('Dashboard'),
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
          IconButton(icon: const Icon(LucideIcons.bell), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummaryCards(),
          const SizedBox(height: 24),
          const Text(
            'Recent Jobs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textMain,
            ),
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

  Widget _buildSummaryCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 175,
            child: _buildCard(
              title: 'Active Jobs',
              value: '${MockDb.stats['activeJobs']}',
              icon: LucideIcons.briefcase,
              iconColor: Colors.indigo,
              trend: 'up',
              trendLabel: 'vs last month',
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 175,
            child: _buildCard(
              title: 'Pending Reviews',
              value: '${MockDb.stats['pendingReviews']}',
              icon: LucideIcons.alertCircle,
              iconColor: Colors.orange,
              subtext: 'Needs attention',
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 175,
            child: _buildCard(
              title: 'Completed',
              value: '${MockDb.stats['completedMonth']}',
              icon: LucideIcons.checkCircle,
              iconColor: Colors.green,
              trend: 'up',
              trendLabel: 'vs last month',
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 175,
            child: _buildCard(
              title: 'Total Hours',
              value: '${MockDb.stats['totalHours']}',
              icon: LucideIcons.clock,
              iconColor: Colors.blue,
              trend: 'down',
              trendLabel: 'vs last month',
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
