import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../controllers/language_controller.dart';
import '../data/mock_db.dart';
import '../screens/add_job_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/messages_list_screen.dart';
import '../theme/app_theme.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      const CalendarScreen(),
      const MessagesListScreen(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildCustomDrawer(),
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        backgroundColor: AppTheme.surface,
        indicatorColor: AppTheme.primary.withOpacity(0.1),
        destinations: const [
          NavigationDestination(
            icon: Icon(LucideIcons.layoutDashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.calendar),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.messageSquare),
            label: 'Messages',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCustomDrawer() {
    return Drawer(
      width: 300,
      backgroundColor: Colors.transparent, // We'll style the container inside
      child: Row(
        children: [
          // Left Rail - Clients (Discord Style)
          Container(
            width: 72,
            height: double.infinity,
            color: const Color(0xFF0F172A), // Slate 900
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ...MockDb.clients.map((client) => _buildClientAvatar(client)),
                  const Spacer(),
                  _buildAddButton(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Right Rail - Menu
          Expanded(
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FLUXBOARD',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMain,
                                  letterSpacing: 1.2,
                                ),
                          ),
                          Text(
                            'Workflow Management',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        children: [
                          _buildDrawerItem(
                            LucideIcons.briefcase,
                            'Jobs',
                            badge: '12',
                          ),
                          _buildDrawerItem(LucideIcons.users, 'Timesheets'),
                          _buildDrawerItem(LucideIcons.users, 'Clients'),
                          _buildDrawerItem(LucideIcons.lightbulb, 'Ideas'),
                          _buildDrawerItem(LucideIcons.fileText, 'Reporting'),
                          _buildDrawerItem(LucideIcons.creditCard, 'Finance'),
                          _buildDrawerItem(LucideIcons.userCog, 'HR'),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Text(
                              'WORKSPACES',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppTheme.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          _buildWorkspaceItem(
                            'Design Team',
                            Colors.purpleAccent,
                          ),
                          _buildWorkspaceItem('Dev Squad', Colors.blueAccent),
                          _buildWorkspaceItem('Marketing', Colors.pinkAccent),
                        ],
                      ),
                    ),
                    const Divider(),
                    // Language Switcher
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Language',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textMain,
                            ),
                          ),
                          ValueListenableBuilder<Locale>(
                            valueListenable: LanguageController.instance,
                            builder: (context, locale, child) {
                              return Row(
                                children: [
                                  _buildLanguageOption(
                                    'TR',
                                    locale.languageCode == 'tr',
                                  ),
                                  const SizedBox(width: 8),
                                  _buildLanguageOption(
                                    'EN',
                                    locale.languageCode == 'en',
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: _buildDrawerItem(LucideIcons.settings, 'Settings'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String code, bool isSelected) {
    return GestureDetector(
      onTap: () {
        LanguageController.instance.setLanguage(code.toLowerCase());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected
                ? AppTheme.primary
                : AppTheme.textSecondary.withOpacity(0.5),
          ),
        ),
        child: Text(
          code,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildClientAvatar(Client client) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1E293B), // Slate 800
            ),
            padding: const EdgeInsets.all(2), // Border placeholder
            child: ClipOval(
              child: SvgPicture.asset(
                client.logo,
                fit: BoxFit.cover,
                placeholderBuilder: (BuildContext context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          if (client.activeJobs > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF0F172A),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  '${client.activeJobs}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        // Close drawer first
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddJobScreen()),
        );
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF475569),
            style: BorderStyle.none,
          ),
          color: Colors.transparent,
        ),
        child: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF475569), width: 1),
            ),
            child: const Icon(
              LucideIcons.plus,
              color: Color(0xFF64748B),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, {String? badge}) {
    return ListTile(
      leading: Icon(icon, size: 20, color: AppTheme.textSecondary),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                ),
              ),
            )
          : null,
      dense: true,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {},
    );
  }

  Widget _buildWorkspaceItem(String label, Color color) {
    return ListTile(
      leading: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.textSecondary,
        ),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      onTap: () {},
    );
  }
}
