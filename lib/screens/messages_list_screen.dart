import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class MessagesListScreen extends StatelessWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We strictly want to show jobs that have messages or active chats.
    // For mockup, let's list clients or jobs.
    // The web app has a 'Messages' tab? Actually Web has sidebar chat.
    // Let's show a list of Clients with active message counts, and upon clicking expand to see jobs?
    // OR just list all jobs with recent activity.
    // Let's list Jobs sorted by most recent activity (mocked).

    final jobs = MockDb.jobs
        .where((j) => j.messages > 0 || j.internalMessages > 0)
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.navMessages),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.textMain,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(LucideIcons.edit), onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        itemCount: jobs.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final job = jobs[index];
          final client = MockDb.clients.firstWhere((c) => c.id == job.clientId);

          final l10n = AppLocalizations.of(context)!;
          return ListTile(
            tileColor: AppTheme.surface,
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF1E293B),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ClipOval(child: SvgPicture.asset(client.logo)),
                  ),
                ),
                if (job.internalMessages > 0)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              _getLocalizedTitle(context, job.titleKey),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: Text(
              '${client.name} • ${job.requester}',
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  l10n.timeNow,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
                if (job.messages + job.internalMessages > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${job.messages + job.internalMessages}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(job: job, client: client),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getLocalizedTitle(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'jobQ3Marketing':
        return l10n.jobQ3Marketing;
      case 'jobHomepageRedesign':
        return l10n.jobHomepageRedesign;
      case 'jobNutritionalPDF':
        return l10n.jobNutritionalPDF;
      case 'jobSocialMedia':
        return l10n.jobSocialMedia;
      case 'jobSafetyVideo':
        return l10n.jobSafetyVideo;
      case 'jobSuitInterface':
        return l10n.jobSuitInterface;
      case 'jobMobileRefresh':
        return l10n.jobMobileRefresh;
      default:
        return key
            .replaceAll('job', '')
            .replaceAllMapped(
              RegExp(r'([A-Z])'),
              (match) => ' ${match.group(0)}',
            )
            .trim();
    }
  }
}
