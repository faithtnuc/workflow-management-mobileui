import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../theme/app_theme.dart';
import '../widgets/job_card_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Group jobs by deadline
    final jobs = MockDb.jobs;
    jobs.sort((a, b) => a.deadline.compareTo(b.deadline));

    // Group logic is simple for now, just list them with headers
    // Actually, let's just show a list for the mockup with date headers

    // We can use a map to group
    Map<String, List<Job>> groupedJobs = {};
    for (var job in jobs) {
      if (!groupedJobs.containsKey(job.deadline)) {
        groupedJobs[job.deadline] = [];
      }
      groupedJobs[job.deadline]!.add(job);
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Production Calendar'),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.textMain,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(LucideIcons.calendar), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groupedJobs.length,
        itemBuilder: (context, index) {
          String dateKey = groupedJobs.keys.elementAt(index);
          List<Job> dayJobs = groupedJobs[dateKey]!;
          DateTime date = DateTime.tryParse(dateKey) ?? DateTime.now();
          String dayLabel = DateFormat('EEEE, MMM d').format(date);

          // Check if today
          final now = DateTime.now();
          bool isToday =
              date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Text(
                      dayLabel,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isToday
                            ? AppTheme.primary
                            : AppTheme.textSecondary,
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              ...dayJobs.map((job) {
                final client = MockDb.clients.firstWhere(
                  (c) => c.id == job.clientId,
                );
                return JobCardWidget(job: job, client: client);
              }),
            ],
          );
        },
      ),
    );
  }
}
