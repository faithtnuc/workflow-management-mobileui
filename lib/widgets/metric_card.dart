import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtext;
  final String? trend; // 'up', 'down', or null
  final String? trendLabel;
  final IconData icon;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtext,
    required this.icon,
    this.trend,
    this.trendLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.05),
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
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Icon(icon, size: 16, color: AppTheme.primary),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.textMain,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (trend == 'up')
                const Icon(
                  Icons.arrow_upward,
                  size: 12,
                  color: AppTheme.success,
                ),
              if (trend == 'down')
                const Icon(
                  Icons.arrow_downward,
                  size: 12,
                  color: AppTheme.danger,
                ),
              if (trend != null) const SizedBox(width: 4),
              Expanded(
                child: Text(
                  trend != null ? '$trendLabel' : subtext,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: trend == 'up'
                        ? AppTheme.success
                        : (trend == 'down'
                              ? AppTheme.danger
                              : AppTheme.textSecondary),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
