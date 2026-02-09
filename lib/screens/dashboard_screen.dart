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
    return Row(
      children: [
        Expanded(
          child: _buildCard(
            'Active',
            '${MockDb.stats['activeJobs']}',
            Colors.blue,
            LucideIcons.briefcase,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCard(
            'Review',
            '${MockDb.stats['pendingReviews']}',
            Colors.orange,
            LucideIcons.eye,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, String value, Color color, IconData icon) {
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
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
