import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @productionCalendar.
  ///
  /// In en, this message translates to:
  /// **'Production Calendar'**
  String get productionCalendar;

  /// No description provided for @dayProgress.
  ///
  /// In en, this message translates to:
  /// **'Day {current} / {total}'**
  String dayProgress(Object current, Object total);

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @timesheets.
  ///
  /// In en, this message translates to:
  /// **'Timesheets'**
  String get timesheets;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @ideas.
  ///
  /// In en, this message translates to:
  /// **'Ideas'**
  String get ideas;

  /// No description provided for @reporting.
  ///
  /// In en, this message translates to:
  /// **'Reporting'**
  String get reporting;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @hr.
  ///
  /// In en, this message translates to:
  /// **'HR'**
  String get hr;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @workspaces.
  ///
  /// In en, this message translates to:
  /// **'Workspaces'**
  String get workspaces;

  /// No description provided for @activeJobs.
  ///
  /// In en, this message translates to:
  /// **'Active Jobs'**
  String get activeJobs;

  /// No description provided for @pendingReviews.
  ///
  /// In en, this message translates to:
  /// **'Pending Reviews'**
  String get pendingReviews;

  /// No description provided for @completedMonth.
  ///
  /// In en, this message translates to:
  /// **'Completed (Month)'**
  String get completedMonth;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @newJob.
  ///
  /// In en, this message translates to:
  /// **'New Job'**
  String get newJob;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get statusReview;

  /// No description provided for @statusWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get statusWaiting;

  /// No description provided for @statusUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get statusUrgent;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @filterActive.
  ///
  /// In en, this message translates to:
  /// **'Active Jobs'**
  String get filterActive;

  /// No description provided for @clientChat.
  ///
  /// In en, this message translates to:
  /// **'Client Chat'**
  String get clientChat;

  /// No description provided for @internalTeam.
  ///
  /// In en, this message translates to:
  /// **'Internal Team'**
  String get internalTeam;

  /// No description provided for @totalHours.
  ///
  /// In en, this message translates to:
  /// **'Total Hours'**
  String get totalHours;

  /// No description provided for @vsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'vs last month'**
  String get vsLastMonth;

  /// No description provided for @needsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get needsAttention;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @agencyDeadline.
  ///
  /// In en, this message translates to:
  /// **'Agency Deadline'**
  String get agencyDeadline;

  /// No description provided for @jobQ3Marketing.
  ///
  /// In en, this message translates to:
  /// **'Q3 Marketing Assets'**
  String get jobQ3Marketing;

  /// No description provided for @jobHomepageRedesign.
  ///
  /// In en, this message translates to:
  /// **'Homepage Redesign V2'**
  String get jobHomepageRedesign;

  /// No description provided for @jobNutritionalPDF.
  ///
  /// In en, this message translates to:
  /// **'Nutritional PDF'**
  String get jobNutritionalPDF;

  /// No description provided for @jobSocialMedia.
  ///
  /// In en, this message translates to:
  /// **'Social Media Campaign'**
  String get jobSocialMedia;

  /// No description provided for @jobSafetyVideo.
  ///
  /// In en, this message translates to:
  /// **'Safety Protocols Video'**
  String get jobSafetyVideo;

  /// No description provided for @jobSuitInterface.
  ///
  /// In en, this message translates to:
  /// **'Suit Interface Mockups'**
  String get jobSuitInterface;

  /// No description provided for @jobMobileRefresh.
  ///
  /// In en, this message translates to:
  /// **'Mobile App Refresh'**
  String get jobMobileRefresh;

  /// No description provided for @workflowManagement.
  ///
  /// In en, this message translates to:
  /// **'Workflow Management'**
  String get workflowManagement;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @menuJobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get menuJobs;

  /// No description provided for @designTeam.
  ///
  /// In en, this message translates to:
  /// **'Design Team'**
  String get designTeam;

  /// No description provided for @devSquad.
  ///
  /// In en, this message translates to:
  /// **'Dev Squad'**
  String get devSquad;

  /// No description provided for @marketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing'**
  String get marketing;

  /// No description provided for @requestedBy.
  ///
  /// In en, this message translates to:
  /// **'Requested by {name}'**
  String requestedBy(String name);

  /// No description provided for @tabDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get tabDetails;

  /// No description provided for @tabMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get tabMessages;

  /// No description provided for @tabFiles.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get tabFiles;

  /// No description provided for @labelStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get labelStatus;

  /// No description provided for @labelClientDate.
  ///
  /// In en, this message translates to:
  /// **'Client Date'**
  String get labelClientDate;

  /// No description provided for @labelAssignee.
  ///
  /// In en, this message translates to:
  /// **'Assignee'**
  String get labelAssignee;

  /// No description provided for @labelAgencyDate.
  ///
  /// In en, this message translates to:
  /// **'Agency Date'**
  String get labelAgencyDate;

  /// No description provided for @labelVisibility.
  ///
  /// In en, this message translates to:
  /// **'Client Visibility'**
  String get labelVisibility;

  /// No description provided for @visible.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get visible;

  /// No description provided for @hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hidden;

  /// No description provided for @labelUrgency.
  ///
  /// In en, this message translates to:
  /// **'Urgency'**
  String get labelUrgency;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// No description provided for @notUrgent.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get notUrgent;

  /// No description provided for @headerDescription.
  ///
  /// In en, this message translates to:
  /// **'DESCRIPTION'**
  String get headerDescription;

  /// No description provided for @headerRequirements.
  ///
  /// In en, this message translates to:
  /// **'REQUIREMENTS'**
  String get headerRequirements;

  /// No description provided for @hintMessageClient.
  ///
  /// In en, this message translates to:
  /// **'Message client...'**
  String get hintMessageClient;

  /// No description provided for @hintMessageInternal.
  ///
  /// In en, this message translates to:
  /// **'Internal note...'**
  String get hintMessageInternal;

  /// No description provided for @segmentClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get segmentClient;

  /// No description provided for @segmentInternal.
  ///
  /// In en, this message translates to:
  /// **'Internal'**
  String get segmentInternal;

  /// No description provided for @reqSoftware.
  ///
  /// In en, this message translates to:
  /// **'Software'**
  String get reqSoftware;

  /// No description provided for @reqPrint.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get reqPrint;

  /// No description provided for @req3D.
  ///
  /// In en, this message translates to:
  /// **'3D'**
  String get req3D;

  /// No description provided for @reqVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get reqVideo;

  /// No description provided for @reqMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get reqMobile;

  /// No description provided for @reqDesign.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get reqDesign;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
