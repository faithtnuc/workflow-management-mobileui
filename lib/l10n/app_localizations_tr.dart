// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get productionCalendar => 'Üretim Takvimi';

  @override
  String dayProgress(Object current, Object total) {
    return 'Gün $current / $total';
  }

  @override
  String get dashboard => 'İşler';

  @override
  String get jobs => 'İş Ekle';

  @override
  String get timesheets => 'Kullanıcılar';

  @override
  String get clients => 'Müşteriler';

  @override
  String get ideas => 'Fikirler';

  @override
  String get reporting => 'Raporlama';

  @override
  String get finance => 'Finans';

  @override
  String get hr => 'İK';

  @override
  String get settings => 'Ayarlar';

  @override
  String get workspaces => 'Çalışma Alanları';

  @override
  String get activeJobs => 'Aktif İşler';

  @override
  String get pendingReviews => 'Bekleyen Onaylar';

  @override
  String get completedMonth => 'Tamamlanan (Ay)';

  @override
  String get viewAll => 'Tümünü Gör';

  @override
  String get newJob => 'Yeni İş';

  @override
  String get statusCompleted => 'Tamamlandı';

  @override
  String get statusReview => 'İnceleniyor';

  @override
  String get statusWaiting => 'Beklemede';

  @override
  String get statusUrgent => 'Acil';

  @override
  String get statusInProgress => 'Devam Ediyor';

  @override
  String get filterActive => 'Aktif İşler';

  @override
  String get clientChat => 'Müşteri Sohbeti';

  @override
  String get internalTeam => 'İç Ekip';

  @override
  String get totalHours => 'Toplam Süre';

  @override
  String get vsLastMonth => 'geçen aya göre';

  @override
  String get needsAttention => 'Dikkat gerekiyor';

  @override
  String get filter => 'Filtrele';

  @override
  String get deadline => 'Termin';

  @override
  String get agencyDeadline => 'Ajans Termin';

  @override
  String get jobQ3Marketing => 'Q3 Pazarlama Varlıkları';

  @override
  String get jobHomepageRedesign => 'Anasayfa Yenileme V2';

  @override
  String get jobNutritionalPDF => 'Beslenme Önizleme PDF';

  @override
  String get jobSocialMedia => 'Sosyal Medya Kampanyası';

  @override
  String get jobSafetyVideo => 'Güvenlik Protokolü Videosu';

  @override
  String get jobSuitInterface => 'Suit Arayüz Mockup';

  @override
  String get jobMobileRefresh => 'Mobil Uygulama Yenileme';

  @override
  String get workflowManagement => 'İş Akış Yönetimi';

  @override
  String get language => 'Dil';

  @override
  String get menuJobs => 'İşler';

  @override
  String get designTeam => 'Tasarım Ekibi';

  @override
  String get devSquad => 'Yazılım Ekibi';

  @override
  String get marketing => 'Pazarlama';

  @override
  String requestedBy(String name) {
    return '$name tarafından istendi';
  }

  @override
  String get tabDetails => 'Detaylar';

  @override
  String get tabMessages => 'Mesajlar';

  @override
  String get tabFiles => 'Dosyalar';

  @override
  String get labelStatus => 'Durum';

  @override
  String get labelClientDate => 'Müşteri Tarihi';

  @override
  String get labelAssignee => 'Yetkili Kişi';

  @override
  String get labelAgencyDate => 'Ajans Tarihi';

  @override
  String get labelVisibility => 'Müşteri Görünürlüğü';

  @override
  String get visible => 'Göster';

  @override
  String get hidden => 'Gizle';

  @override
  String get labelUrgency => 'Aciliyet';

  @override
  String get urgent => 'Acil';

  @override
  String get notUrgent => 'Acil Değil';

  @override
  String get headerDescription => 'AÇIKLAMA';

  @override
  String get headerRequirements => 'GEREKSİNİMLER';

  @override
  String get hintMessageClient => 'Müşteriye mesaj yaz...';

  @override
  String get hintMessageInternal => 'Dahili not ekle...';

  @override
  String get segmentClient => 'Müşteri';

  @override
  String get segmentInternal => 'Dahili';

  @override
  String get reqSoftware => 'Yazılım';

  @override
  String get reqPrint => 'Baskı';

  @override
  String get req3D => '3D';

  @override
  String get reqVideo => 'Video';

  @override
  String get reqMobile => 'Mobil';

  @override
  String get reqDesign => 'Tasarım';

  @override
  String get navDashboard => 'Panel';

  @override
  String get navCalendar => 'Takvim';

  @override
  String get navMessages => 'Mesajlar';

  @override
  String get timeNow => 'Şimdi';
}
