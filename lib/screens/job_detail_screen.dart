import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_db.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class JobDetailScreen extends StatefulWidget {
  final Job job;
  final Client client;

  const JobDetailScreen({super.key, required this.job, required this.client});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();
  String _activeMessageTab = 'client'; // 'client' or 'internal'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    super.dispose();
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

  String _getLocalizedDescription(BuildContext context) {
    final isTr = Localizations.localeOf(context).languageCode == 'tr';
    return (isTr && widget.job.descriptionTR.isNotEmpty)
        ? widget.job.descriptionTR
        : widget.job.description;
  }

  String _formatDate(BuildContext context, String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      final locale = Localizations.localeOf(context).languageCode;
      return intl.DateFormat('d MMM', locale).format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: AppTheme.surface,
              elevation: 0,
              pinned: true,
              floating: true,
              leading: IconButton(
                icon: const Icon(
                  LucideIcons.arrowLeft,
                  color: AppTheme.textMain,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: Text(
                '#${widget.job.id}',
                style: const TextStyle(
                  color: AppTheme.textMain,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
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
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppTheme.primary,
                  unselectedLabelColor: AppTheme.textSecondary,
                  indicatorColor: AppTheme.primary,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  tabs: [
                    const Tab(text: 'Detaylar'), // TODO: Localize
                    Tab(
                      text: l10n.clientChat,
                    ), // Reusing existing localized string vaguely or just 'Mesajlar'
                    const Tab(text: 'Dosyalar'), // TODO: Localize
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildDetailsTab(context),
            _buildMessagesTab(context),
            _buildFilesTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: ClipOval(child: SvgPicture.asset(widget.client.logo)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getLocalizedTitle(context, widget.job.titleKey),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textMain,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          'Requested by ${widget.job.requester}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '•',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(context, widget.job.createdAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        if (widget.job.status == 'Urgent')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.dangerBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Acil',
                              style: TextStyle(
                                color: AppTheme.danger,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Status Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.activity,
                  size: 16,
                  color: AppTheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.job.status, // Should use localized status
                  style: const TextStyle(
                    color: AppTheme.textMain,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Icon(
                  LucideIcons.chevronDown,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dates Section
          Row(
            children: [
              Expanded(
                child: _buildInteractiveField(
                  icon: LucideIcons.calendar,
                  label: 'Müşteri T.',
                  value: _formatDate(context, widget.job.deadline),
                  isUrgent: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInteractiveField(
                  icon: LucideIcons.flag,
                  label: 'Ajans T.',
                  value: _formatDate(context, widget.job.internalDeadline),
                  isUrgent: true, // Internal deadline is important
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // People Section
          Row(
            children: [
              Expanded(
                child: _buildInteractiveField(
                  icon: LucideIcons.user,
                  label: 'Atanan',
                  value: widget.job.assignee, // Could be avatar
                  isUrgent: false,
                  showAvatar: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInteractiveField(
                  icon: widget.job.isClientVisible
                      ? LucideIcons.eye
                      : LucideIcons.eyeOff,
                  label: 'Görünürlük',
                  value: widget.job.isClientVisible ? 'Müşteri' : 'Gizli',
                  isUrgent: false,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Description
          const Text(
            'AÇIKLAMA',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getLocalizedDescription(context),
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textMain,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Requirements
          const Text(
            'GEREKSINIMLER',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.job.requirements.map((req) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Fake checkbox
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.textSecondary),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      req,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textMain,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveField({
    required IconData icon,
    required String label,
    required String value,
    required bool isUrgent,
    bool showAvatar = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.transparent,
        ), // Placeholder for active state
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppTheme.textSecondary),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (!showAvatar) // Don't show chevron if avatar is the main thing, or maybe do? Design says edit icon.
                const Icon(
                  LucideIcons.chevronDown,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (showAvatar) ...[
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppTheme.primary,
                  child: Text(
                    value.isNotEmpty ? value[0] : '?',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isUrgent
                        ? Colors.orange.shade800
                        : AppTheme.textMain,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesTab(BuildContext context) {
    // Filter logs
    final logs = widget.job.activityLog.where((log) {
      if (_activeMessageTab == 'internal') {
        return log.visibility == 'internal';
      } else {
        return log.visibility != 'internal';
      }
    }).toList();

    return Column(
      children: [
        // Segmented Control
        Container(
          padding: const EdgeInsets.all(16),
          color: AppTheme.background,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(child: _buildSegmentBtn('Client', 'client')),
                Expanded(child: _buildSegmentBtn('Internal', 'internal')),
              ],
            ),
          ),
        ),

        // Chat List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: logs.length,
            separatorBuilder: (ctx, i) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final log = logs[index];
              final isMe = log.user == MockDb.user.name;
              return Row(
                mainAxisAlignment: isMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end, // Align to bottom
                children: [
                  if (!isMe) ...[
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: _activeMessageTab == 'internal'
                          ? Colors.orange
                          : AppTheme.primary,
                      child: Text(
                        log.user[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe
                            ? (_activeMessageTab == 'internal'
                                  ? Colors.orange
                                  : AppTheme.primary)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isMe ? 16 : 4),
                          bottomRight: Radius.circular(isMe ? 4 : 16),
                        ),
                        boxShadow: [
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
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          if (!isMe) const SizedBox(height: 4),
                          Text(
                            log.text,
                            style: TextStyle(
                              color: isMe ? Colors.white : AppTheme.textMain,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            log.timestamp.split(' ').last, // Just time for now
                            style: TextStyle(
                              fontSize: 10,
                              color: isMe
                                  ? Colors.white.withOpacity(0.7)
                                  : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // Input
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppTheme.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: _activeMessageTab == 'client'
                        ? 'Message client...'
                        : 'Internal note...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    LucideIcons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    // Logic not required
                    _messageController.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentBtn(String label, String id) {
    final isActive = _activeMessageTab == id;
    final color = id == 'internal' ? Colors.orange : AppTheme.primary;

    return GestureDetector(
      onTap: () => setState(() => _activeMessageTab = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? color : AppTheme.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilesTab(BuildContext context) {
    if (widget.job.files.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.file, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'No files uploaded yet',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.job.files.length,
      separatorBuilder: (ctx, i) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final file = widget.job.files[index];
        IconData fileIcon = LucideIcons.file;
        Color iconColor = Colors.grey;

        if (file.type == 'pdf') {
          fileIcon = LucideIcons.fileText;
          iconColor = Colors.red;
        } else if (file.type == 'image') {
          fileIcon = LucideIcons.image;
          iconColor = Colors.purple;
        } else if (file.type == 'archive') {
          fileIcon = LucideIcons.archive;
          iconColor = Colors.orange;
        } else if (file.type == 'video') {
          fileIcon = LucideIcons.video;
          iconColor = Colors.blue;
        }

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(fileIcon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textMain,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      file.size.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  LucideIcons.downloadCloud,
                  color: AppTheme.textSecondary,
                ),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height + 1; // +1 for border
  @override
  double get maxExtent => _tabBar.preferredSize.height + 1;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppTheme.surface,
      child: Column(children: [_tabBar, const Divider(height: 1)]),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
