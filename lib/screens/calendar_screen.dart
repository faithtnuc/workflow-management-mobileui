import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../data/mock_db.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────
// Shared color helper – single source of truth for
// both calendar bars AND agenda card strips.
// ─────────────────────────────────────────────────────────
Color statusColor(String status) {
  switch (status) {
    case 'Urgent':
      return AppTheme.danger;
    case 'Review':
      return AppTheme.primary; // Indigo 600
    case 'Completed':
      return AppTheme.success;
    case 'Waiting':
      return AppTheme.warning;
    case 'In Progress':
      return AppTheme.info;
    default:
      return AppTheme.primary;
  }
}

// ─────────────────────────────────────────────────────────
// Shared title localizer
// ─────────────────────────────────────────────────────────
String localizedTitle(AppLocalizations l10n, String key) {
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
      return key;
  }
}

// ─────────────────────────────────────────────────────────
// CalendarScreen
// ─────────────────────────────────────────────────────────
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _controller = CalendarController();
  DateTime _displayMonth = DateTime(2023, 11, 1);
  DateTime _selectedDate = DateTime(2023, 11, 1);
  List<Job> _selectedJobs = [];

  @override
  void initState() {
    super.initState();
    _updateSelectedJobs();
  }

  void _updateSelectedJobs() {
    final jobs = MockDb.jobs.where((job) {
      final start = DateTime.tryParse(job.startDate) ?? DateTime(2023, 11, 1);
      final end = DateTime.tryParse(job.deadline) ?? DateTime(2023, 11, 1);

      final selected = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
      );
      final s = DateTime(start.year, start.month, start.day);
      final e = DateTime(end.year, end.month, end.day);

      return (selected.isAtSameMomentAs(s) || selected.isAfter(s)) &&
          (selected.isAtSameMomentAs(e) || selected.isBefore(e));
    }).toList();

    setState(() => _selectedJobs = jobs);
  }

  void _goToMonth(int delta) {
    final newMonth = DateTime(
      _displayMonth.year,
      _displayMonth.month + delta,
      1,
    );
    setState(() => _displayMonth = newMonth);
    _controller.displayDate = newMonth;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _displayMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _displayMonth = DateTime(picked.year, picked.month, 1);
        _selectedDate = picked;
      });
      _controller.displayDate = picked;
      _updateSelectedJobs();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final monthLabel = intl.DateFormat(
      'MMMM yyyy',
      locale,
    ).format(_displayMonth);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Custom Header ──────────────────────────────
            Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
              child: Row(
                children: [
                  // Left: Title stack
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.productionCalendar,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        GestureDetector(
                          onTap: _pickDate,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                monthLabel,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMain,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                LucideIcons.chevronDown,
                                size: 18,
                                color: AppTheme.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right: Navigation
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _HeaderIconButton(
                        icon: LucideIcons.chevronLeft,
                        onTap: () => _goToMonth(-1),
                      ),
                      TextButton(
                        onPressed: () {
                          final today = DateTime.now();
                          setState(() {
                            _displayMonth = DateTime(
                              today.year,
                              today.month,
                              1,
                            );
                            _selectedDate = today;
                          });
                          _controller.displayDate = today;
                          _updateSelectedJobs();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          foregroundColor: AppTheme.textMain,
                        ),
                        child: Text(
                          locale == 'tr' ? 'Bugün' : 'Today',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      _HeaderIconButton(
                        icon: LucideIcons.chevronRight,
                        onTap: () => _goToMonth(1),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: AppTheme.border),

            // ── SfCalendar (header hidden) ─────────────────
            Expanded(
              flex: 5,
              child: Container(
                color: AppTheme.surface,
                child: SfCalendar(
                  controller: _controller,
                  view: CalendarView.month,
                  initialDisplayDate: DateTime(2023, 11, 1),
                  dataSource: JobDataSource(MockDb.jobs, MockDb.clients, l10n),
                  firstDayOfWeek: 1,
                  backgroundColor: AppTheme.surface,
                  headerHeight: 0, // ← hide default header

                  onViewChanged: (ViewChangedDetails details) {
                    // Keep our custom header in sync
                    if (details.visibleDates.isNotEmpty) {
                      final mid = details
                          .visibleDates[details.visibleDates.length ~/ 2];
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(
                            () => _displayMonth = DateTime(
                              mid.year,
                              mid.month,
                              1,
                            ),
                          );
                        }
                      });
                    }
                  },

                  onSelectionChanged: (CalendarSelectionDetails details) {
                    if (details.date != null) {
                      setState(() {
                        _selectedDate = details.date!;
                        _updateSelectedJobs();
                      });
                    }
                  },

                  viewHeaderStyle: const ViewHeaderStyle(
                    dayTextStyle: TextStyle(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),

                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    showAgenda: false,
                    monthCellStyle: MonthCellStyle(
                      textStyle: TextStyle(
                        color: AppTheme.textMain,
                        fontSize: 13,
                      ),
                      trailingDatesTextStyle: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                      leadingDatesTextStyle: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                      todayBackgroundColor: Color(0xFFEFF6FF),
                      todayTextStyle: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppTheme.primary, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const Divider(height: 1, color: AppTheme.border),

            // ── Custom Agenda ──────────────────────────────
            Expanded(
              flex: 4,
              child: Container(
                color: AppTheme.background,
                child: _selectedJobs.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.calendarOff,
                              size: 32,
                              color: AppTheme.textSecondary.withOpacity(0.4),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.jobs,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        itemCount: _selectedJobs.length,
                        itemBuilder: (context, index) {
                          final job = _selectedJobs[index];
                          final client = MockDb.clients.firstWhere(
                            (c) => c.id == job.clientId,
                            orElse: () => Client(
                              id: 'unknown',
                              name: 'Unknown',
                              logo: '',
                              activeJobs: 0,
                              unreadMessages: 0,
                              totalMessages: 0,
                            ),
                          );
                          return _AgendaJobCard(
                            job: job,
                            client: client,
                            selectedDate: _selectedDate,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Tiny icon button used in the custom header
// ─────────────────────────────────────────────────────────
class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 20, color: AppTheme.textSecondary),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Agenda Card – Hybrid design with logo & progress
// ─────────────────────────────────────────────────────────
class _AgendaJobCard extends StatelessWidget {
  final Job job;
  final Client client;
  final DateTime selectedDate;

  const _AgendaJobCard({
    required this.job,
    required this.client,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Progress calculation
    final start = DateTime.tryParse(job.startDate) ?? DateTime(2023, 11, 1);
    final end = DateTime.tryParse(job.deadline) ?? DateTime(2023, 11, 2);

    final dSelected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final dStart = DateTime(start.year, start.month, start.day);
    final dEnd = DateTime(end.year, end.month, end.day);

    final totalDays = dEnd.difference(dStart).inDays + 1;
    int currentDay = (dSelected.difference(dStart).inDays + 1).clamp(
      1,
      totalDays,
    );
    final isDeadlineDay = currentDay >= totalDays;

    // Color – uses the SAME shared function as the calendar bars
    final color = statusColor(job.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 1 ▸ Left Color Strip
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 2 ▸ Client Logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFF1E293B),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: ClipOval(
                    child: client.logo.isNotEmpty
                        ? SvgPicture.asset(client.logo, width: 26, height: 26)
                        : const Icon(
                            LucideIcons.building,
                            size: 16,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // 3 ▸ Title + Client Name
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizedTitle(l10n, job.titleKey),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textMain,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      client.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4 ▸ Progress Column
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: AppTheme.border)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.dayProgress(currentDay, totalDays),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDeadlineDay
                          ? AppTheme.success
                          : AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  isDeadlineDay
                      ? Icon(
                          LucideIcons.flag,
                          size: 16,
                          color: AppTheme.success,
                        )
                      : const Icon(
                          LucideIcons.chevronsRight,
                          size: 16,
                          color: AppTheme.textSecondary,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// SfCalendar DataSource
// ─────────────────────────────────────────────────────────
class JobDataSource extends CalendarDataSource {
  final List<Client> clients;
  final AppLocalizations l10n;

  JobDataSource(List<Job> source, this.clients, this.l10n) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    final Job job = appointments![index] as Job;
    return DateTime.tryParse(job.startDate) ?? DateTime(2023, 11, 1);
  }

  @override
  DateTime getEndTime(int index) {
    final Job job = appointments![index] as Job;
    return DateTime.tryParse(job.deadline) ?? DateTime(2023, 11, 2);
  }

  @override
  String getSubject(int index) {
    final Job job = appointments![index] as Job;
    final title = localizedTitle(l10n, job.titleKey);
    final client = clients.firstWhere((c) => c.id == job.clientId);
    return '${client.name} • $title';
  }

  @override
  Color getColor(int index) {
    final Job job = appointments![index] as Job;
    return statusColor(job.status); // ← same function as agenda cards
  }

  @override
  bool isAllDay(int index) => true;
}
