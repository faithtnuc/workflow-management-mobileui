import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  final Job job;
  final Client client;

  const ChatScreen({super.key, required this.job, required this.client});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _activeTab = 'client'; // 'client' or 'internal'
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Filter logs based on tab
    final logs = widget.job.activityLog.where((log) {
      if (_activeTab == 'internal') {
        return log.visibility == 'internal';
      } else {
        return log.visibility != 'internal';
      }
    }).toList();

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          _activeTab == 'client' ? l10n.clientChat : l10n.internalTeam,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.textMain,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(LucideIcons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Tabs
          Container(
            color: AppTheme.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _buildTab(
                    l10n.segmentClient,
                    'client',
                    Colors.indigo, // Changed to Indigo to match Job Detail
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTab(
                    l10n.segmentInternal,
                    'internal',
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: _activeTab == 'internal'
                  ? Colors.orange.withOpacity(0.05)
                  : AppTheme.background,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  final isMe = log.user == MockDb.user.name;
                  return _buildMessage(log, isMe);
                },
              ),
            ),
          ),

          // Input
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.surface,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    LucideIcons.paperclip,
                    color: AppTheme.textSecondary,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _activeTab == 'client'
                          ? l10n.hintMessageClient
                          : l10n.hintMessageInternal,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.send, color: AppTheme.primary),
                  onPressed: () {
                    // Adding message logic would go here
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, String id, MaterialColor color) {
    final isActive = _activeTab == id;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? color.shade50 : AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? color.shade200 : Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? color.shade700 : AppTheme.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(JobLog log, bool isMe) {
    if (log.type == 'log') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.border,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${log.user} ${log.text.toLowerCase()} • ${log.timestamp}',
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: _activeTab == 'internal'
                  ? Colors.orange
                  : AppTheme.primary,
              child: Text(
                log.user[0],
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe
                    ? (_activeTab == 'internal'
                          ? const Color(0xFFEA580C) // Orange 600
                          : const Color(0xFF4F46E5)) // Indigo 600
                    : AppTheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 0),
                  bottomRight: Radius.circular(isMe ? 0 : 16),
                ),
                boxShadow: [
                  if (!isMe)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Text(
                      log.user,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textMain,
                      ),
                    ),
                  Text(
                    (Localizations.localeOf(context).languageCode == 'tr' &&
                            log.textTR.isNotEmpty)
                        ? log.textTR
                        : log.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : AppTheme.textMain,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
