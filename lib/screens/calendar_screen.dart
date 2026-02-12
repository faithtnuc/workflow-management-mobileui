import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../data/mock_db.dart';
import '../theme/app_theme.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Production Calendar'),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.textMain,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.chevronLeft),
            onPressed: () {
              _controller.backward!();
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.calendar),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _controller.displayDate ?? DateTime(2023, 11, 1),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                _controller.displayDate = picked;
              }
            },
            tooltip: 'Pick Date',
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronRight),
            onPressed: () {
              _controller.forward!();
            },
          ),
        ],
      ),
      body: Container(
        color: AppTheme.surface,
        child: SfCalendar(
          controller: _controller,
          view: CalendarView.month,
          // Start in Nov 2023 to show mock data
          initialDisplayDate: DateTime(2023, 11, 1),
          showNavigationArrow: true,
          dataSource: JobDataSource(MockDb.jobs, MockDb.clients),
          firstDayOfWeek: 1, // Monday
          // Localization

          // Header styling
          headerStyle: const CalendarHeaderStyle(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textMain,
            ),
            backgroundColor: AppTheme.surface,
            textAlign: TextAlign.center,
          ),

          // View Header (Day names)
          viewHeaderStyle: const ViewHeaderStyle(
            dayTextStyle: TextStyle(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Month View Settings
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,
            agendaItemHeight: 70,
            agendaStyle: AgendaStyle(
              backgroundColor: Colors.white,
              appointmentTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              dateTextStyle: TextStyle(
                color: AppTheme.textMain,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              dayTextStyle: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            monthCellStyle: MonthCellStyle(
              textStyle: TextStyle(color: AppTheme.textMain, fontSize: 13),
              trailingDatesTextStyle: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
              leadingDatesTextStyle: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
              todayBackgroundColor: Color(0xFFEFF6FF), // Primary light
              todayTextStyle: TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Appointment Builder for custom look if needed,
          // but specifically requested "Colored bars with text" which is default for appointmentDisplayMode
        ),
      ),
    );
  }
}

class JobDataSource extends CalendarDataSource {
  final List<Client> clients;

  JobDataSource(List<Job> source, this.clients) {
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
    final client = clients.firstWhere(
      (c) => c.id == job.clientId,
      orElse: () => Client(
        id: 'unknown',
        name: 'Client',
        logo: '',
        activeJobs: 0,
        unreadMessages: 0,
        totalMessages: 0,
      ),
    );
    return '${client.name}: ${job.titleKey}';
  }

  @override
  Color getColor(int index) {
    final Job job = appointments![index] as Job;
    return _getColorForStatus(job.status);
  }

  @override
  bool isAllDay(int index) {
    return true;
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'Urgent':
        return const Color(0xFFEF4444); // Red
      case 'Review':
        return const Color(0xFF3B82F6); // Blue
      case 'In Progress':
        return const Color(0xFFF59E0B); // Orange/Amber
      case 'Completed':
        return const Color(0xFF10B981); // Green
      default:
        return AppTheme.primary;
    }
  }
}
