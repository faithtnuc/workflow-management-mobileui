class User {
  final String id;
  final String name;
  final String role;
  final String avatar; // Asset path or URL
  final int notifications;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.avatar,
    this.notifications = 0,
  });
}

class Client {
  final String id;
  final String name;
  final String logo; // Asset path
  final int activeJobs;
  final int unreadMessages;
  final int totalMessages;

  Client({
    required this.id,
    required this.name,
    required this.logo,
    required this.activeJobs,
    required this.unreadMessages,
    required this.totalMessages,
  });
}

class JobLog {
  final int id;
  final String type; // 'log' or 'comment'
  final String text;
  final String textTR; // Added for localization
  final String user;
  final String timestamp;
  final String visibility; // 'internal' or 'client'

  JobLog({
    required this.id,
    required this.type,
    required this.text,
    required this.textTR,
    required this.user,
    required this.timestamp,
    required this.visibility,
  });
}

class JobFile {
  final String id;
  final String name;
  final String type;
  final String size;
  final String url;

  JobFile({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.url,
  });
}

class Job {
  final String id;
  final String clientId;
  final String titleKey; // For localization if needed, or just display
  final String requester;
  final String deadline;
  final String internalDeadline;
  final String startDate;
  String status;
  final int messages;
  final int internalMessages;
  final String description;
  final String descriptionTR;
  final String requesterEmail;
  final String createdAt;
  String assignee;
  bool isClientVisible;
  final List<String> requirements;
  final List<JobLog> activityLog;
  final List<JobLog> activityLogTR;
  final List<JobFile> files;

  Job({
    required this.id,
    required this.clientId,
    required this.titleKey,
    required this.requester,
    required this.deadline,
    required this.internalDeadline,
    required this.startDate,
    required this.status,
    required this.messages,
    required this.internalMessages,
    required this.description,
    required this.descriptionTR,
    required this.requesterEmail,
    required this.createdAt,
    required this.assignee,
    required this.isClientVisible,
    this.requirements = const [],
    this.activityLog = const [],
    this.activityLogTR = const [],
    this.files = const [],
  });
}

class MockDb {
  static final User user = User(
    id: 'u1',
    name: 'Mert Tunç',
    role: 'Senior Producer',
    avatar: 'assets/logos/logo_parflux.svg',
    notifications: 3,
  );

  static final Map<String, dynamic> stats = {
    'activeJobs': 12,
    'pendingReviews': 4,
    'completedMonth': 28,
    'totalHours': 142.5,
  };

  // Available Requirements (DB Source)
  static const List<String> availableRequirements = [
    'Yazılım',
    'Baskı',
    '3D',
    'Video',
    'Mobil',
    'Tasarım',
  ];

  static final List<Client> clients = [
    Client(
      id: 'c1',
      name: 'Sienna',
      logo: 'assets/logos/logo_sienna.svg',
      activeJobs: 3,
      unreadMessages: 2,
      totalMessages: 15,
    ),
    Client(
      id: 'c2',
      name: 'Abramind',
      logo: 'assets/logos/logo_abramind.svg',
      activeJobs: 7,
      unreadMessages: 4,
      totalMessages: 22,
    ),
    Client(
      id: 'c3',
      name: 'Maison',
      logo: 'assets/logos/logo_maison.svg',
      activeJobs: 1,
      unreadMessages: 0,
      totalMessages: 8,
    ),
    Client(
      id: 'c4',
      name: 'Phyllant',
      logo: 'assets/logos/logo_phyllant.svg',
      activeJobs: 4,
      unreadMessages: 12,
      totalMessages: 45,
    ),
    Client(
      id: 'c5',
      name: 'Pithema',
      logo: 'assets/logos/logo_pithema.svg',
      activeJobs: 2,
      unreadMessages: 1,
      totalMessages: 6,
    ),
    Client(
      id: 'c6',
      name: 'Prowa',
      logo: 'assets/logos/logo_prowa.svg',
      activeJobs: 5,
      unreadMessages: 3,
      totalMessages: 19,
    ),
  ];

  static final List<Job> jobs = [
    Job(
      id: '10022',
      clientId: 'c1',
      titleKey: 'jobQ3Marketing',
      requester: 'Sarah Connor',
      deadline: '2023-11-15',
      internalDeadline: '2023-11-13',
      startDate: '2023-11-09',
      status: 'Review',
      messages: 2,
      internalMessages: 5,
      description:
          "Comprehensive marketing campaign strategy for Q3, including social media ramp-up and influencer partnerships.",
      descriptionTR:
          "Q3 için kapsamlı pazarlama kampanyası stratejisi, sosyal medya artışı ve etkileyici ortaklıkları dahil.",
      requesterEmail: 'sarah.connor@sienna.com',
      createdAt: '2023-10-20',
      assignee: 'Mert Tunç',
      isClientVisible: true,

      requirements: [
        "Yazılım",
        "Tasarım",
        "Mobil",
      ], // Updated to match new keys
      activityLog: [
        JobLog(
          id: 1,
          type: 'log',
          text: 'Job created',
          textTR: 'İş oluşturuldu',
          user: 'Sarah Connor',
          timestamp: '2023-10-20 09:00',
          visibility: 'internal',
        ),
        JobLog(
          id: 2,
          type: 'comment',
          text:
              'Initial draft is ready for review. I focused on the "modern" look.',
          textTR:
              'İlk taslak inceleme için hazır. "Modern" görünüme odaklandım.',
          user: 'Mert Tunç',
          timestamp: '2023-10-25 14:30',
          visibility: 'internal',
        ),
        JobLog(
          id: 3,
          type: 'comment',
          text:
              'Looks good, minor tweaks on the budget section needed. Can we make the font larger?',
          textTR:
              'Güzel görünüyor, bütçe bölümünde ufak düzeltmeler gerekiyor. Yazı tipini büyütebilir miyiz?',
          user: 'Sarah Connor',
          timestamp: '2023-10-26 10:15',
          visibility: 'client',
        ),
        JobLog(
          id: 4,
          type: 'comment',
          text:
              'Sure, I will update the typography and send a new version by EOD.',
          textTR:
              'Elbette, tipografiyi güncelleyip gün sonuna kadar yeni bir versiyon göndereceğim.',
          user: 'Mert Tunç',
          timestamp: '2023-10-26 11:00',
          visibility: 'client',
        ),
        JobLog(
          id: 5,
          type: 'comment',
          text: 'Internal Note: Check if we have the license for that font.',
          textTR:
              'Dahili Not: O yazı tipi için lisansımız olup olmadığını kontrol et.',
          user: 'Mert Tunç',
          timestamp: '2023-10-26 11:05',
          visibility: 'internal',
        ),
      ],
      files: [
        JobFile(
          id: 'f1',
          name: 'Q3_Strategy_Brief.pdf',
          type: 'pdf',
          size: '2.4 MB',
          url: '#',
        ),
        JobFile(
          id: 'f2',
          name: 'Sienna_Assets_V1.zip',
          type: 'archive',
          size: '156 MB',
          url: '#',
        ),
        JobFile(
          id: 'f3',
          name: 'Moodboard_Q3.jpg',
          type: 'image',
          size: '4.1 MB',
          url: '#',
        ),
      ],
    ),
    Job(
      id: '10023',
      clientId: 'c2',
      titleKey: 'jobHomepageRedesign',
      requester: 'Hank Scorpio',
      deadline: '2023-11-12',
      internalDeadline: '2023-11-10',
      startDate: '2023-11-06',
      status: 'Review',
      messages: 0,
      internalMessages: 1,
      description:
          "Complete redesign of the corporate homepage to align with the new branding guidelines. Focus on conversion optimization and mobile responsiveness.",
      descriptionTR:
          "Yeni marka yönergelerine uyum sağlamak için kurumsal ana sayfanın tam tasarımı. Dönüşüm optimizasyonu ve mobil uyumluluğa odaklanın.",
      requesterEmail: 'hank.scorpio@abramind.com',
      createdAt: '2023-10-01',
      assignee: 'Mert Tunç',
      isClientVisible: false,
      requirements: [
        "Tasarım",
        "Yazılım",
        "Mobil",
      ], // Synced with Web: UX/UI->Tasarım, Frontend->Yazılım, SEO->Mobil
      activityLog: [
        JobLog(
          id: 1,
          type: 'log',
          text: 'Job created',
          textTR: 'İş oluşturuldu',
          user: 'Hank Scorpio',
          timestamp: '2023-10-01 11:00',
          visibility: 'internal',
        ),
        JobLog(
          id: 2,
          type: 'comment',
          text: 'Wireframes approved. Moving to high-fidelity designs.',
          textTR:
              'Tel kafesler onaylandı. Yüksek sadakatli tasarımlara geçiliyor.',
          user: 'Mert Tunç',
          timestamp: '2023-10-05 16:45',
          visibility: 'client',
        ),
        JobLog(
          id: 3,
          type: 'comment',
          text: 'Internal note: Client is sensitive about the color palette.',
          textTR: 'Dahili not: Müşteri renk paleti konusunda hassas.',
          user: 'Mert Tunç',
          timestamp: '2023-10-05 16:50',
          visibility: 'internal',
        ),
        JobLog(
          id: 4,
          type: 'comment',
          text:
              'I really like the new direction! Can we make the logo pop more?',
          textTR:
              'Yeni yönü gerçekten beğendim! Logoyu daha belirgin yapabilir miyiz?',
          user: 'Hank Scorpio',
          timestamp: '2023-10-06 09:30',
          visibility: 'client',
        ),
        JobLog(
          id: 5,
          type: 'comment',
          text: 'Absolutely, I will add more contrast to the header area.',
          textTR: 'Kesinlikle, başlık alanına daha fazla kontrast ekleyeceğim.',
          user: 'Mert Tunç',
          timestamp: '2023-10-06 10:00',
          visibility: 'client',
        ),
      ],
      files: [
        JobFile(
          id: 'f1',
          name: 'Homepage_Wireframes_v2.fig',
          type: 'design',
          size: '12 MB',
          url: '#',
        ),
        JobFile(
          id: 'f2',
          name: 'Abramind_Logo_Pack.zip',
          type: 'archive',
          size: '45 MB',
          url: '#',
        ),
      ],
    ),
    Job(
      id: '10024',
      clientId: 'c3',
      titleKey: 'jobNutritionalPDF',
      requester: 'Richard T.',
      deadline: '2023-11-20',
      internalDeadline: '2023-11-18',
      startDate: '2023-11-15',
      status: 'Review',
      messages: 5,
      internalMessages: 0,
      description:
          "Design and layout for the new nutritional guide PDF. Needs to be print-ready and accessible for digital distribution.",
      descriptionTR:
          "Yeni beslenme rehberi PDF'si için tasarım ve düzen. Baskıya hazır ve dijital dağıtım için erişilebilir olmalı.",
      requesterEmail: 'richard.t@maison.com',
      createdAt: '2023-10-28',
      assignee: 'Fatih Tunç',
      isClientVisible: true,
      requirements: [
        "Tasarım",
        "Baskı",
      ], // Graphic Design->Tasarım, Print Layout->Baskı
      activityLog: [
        JobLog(
          id: 1,
          type: 'log',
          text: 'Job created',
          textTR: 'İş oluşturuldu',
          user: 'Richard T.',
          timestamp: '2023-10-28 08:30',
          visibility: 'internal',
        ),
      ],
    ),
    Job(
      id: '10025',
      clientId: 'c1',
      titleKey: 'jobSocialMedia',
      requester: 'John Doe',
      deadline: '2023-11-14',
      internalDeadline: '2023-11-12',
      startDate: '2023-11-10',
      status: 'Completed',
      messages: 0,
      internalMessages: 0,
      description:
          "November social media content calendar and assets creation.",
      descriptionTR:
          "Kasım ayı sosyal medya içerik takvimi ve varlık oluşturma.",
      requesterEmail: 'john.doe@sienna.com',
      createdAt: '2023-11-01',
      assignee: 'Emily Zhang',
      isClientVisible: true,
      requirements: [
        "Mobil",
        "Tasarım",
      ], // Social Media->Mobil, Graphic Design->Tasarım
      activityLog: [
        JobLog(
          id: 1,
          type: 'log',
          text: 'Job created',
          textTR: 'İş oluşturuldu',
          user: 'John Doe',
          timestamp: '2023-11-01 10:00',
          visibility: 'internal',
        ),
      ],
    ),
    Job(
      id: '10026',
      clientId: 'c4',
      titleKey: 'jobSafetyVideo',
      requester: 'Albert W.',
      deadline: '2023-11-10',
      internalDeadline: '2023-11-08',
      startDate: '2023-11-03',
      status: 'Urgent',
      messages: 1,
      internalMessages: 3,
      description:
          "Internal safety training video editing and voiceover synchronization.",
      descriptionTR:
          "Dahili güvenlik eğitimi videosu düzenleme ve ses senkronizasyonu.",
      requesterEmail: 'albert.w@phyllant.com',
      createdAt: '2023-11-05',
      assignee: 'James Chen',
      isClientVisible: true,
      requirements: [
        "Video",
        "Tasarım",
      ], // Video Editing->Video, Motion Graphics->Tasarım
      activityLog: [
        JobLog(
          id: 1,
          type: 'log',
          text: 'Job created',
          textTR: 'İş oluşturuldu',
          user: 'Albert W.',
          timestamp: '2023-11-05 09:15',
          visibility: 'internal',
        ),
        JobLog(
          id: 2,
          type: 'comment',
          text: 'Raw footage uploaded to server.',
          textTR: 'Ham görüntüler sunucuya yüklendi.',
          user: 'Alex Jensen',
          timestamp: '2023-11-06 11:30',
          visibility: 'internal',
        ),
        JobLog(
          id: 3,
          type: 'comment',
          text: 'Please check the audio levels in scene 3.',
          textTR: 'Lütfen 3. sahnedeki ses seviyelerini kontrol edin.',
          user: 'Albert W.',
          timestamp: '2023-11-06 14:20',
          visibility: 'client',
        ),
      ],
      files: [
        JobFile(
          id: 'f1',
          name: 'Safety_Script_Final.pdf',
          type: 'pdf',
          size: '1.2 MB',
          url: '#',
        ),
        JobFile(
          id: 'f2',
          name: 'Raw_Footage_Scene1.mp4',
          type: 'video',
          size: '450 MB',
          url: '#',
        ),
        JobFile(
          id: 'f3',
          name: 'phyllant_intro_animation.mov',
          type: 'video',
          size: '85 MB',
          url: '#',
        ),
      ],
    ),
    Job(
      id: '10027',
      clientId: 'c5',
      titleKey: 'jobSuitInterface',
      requester: 'Pepper Potts',
      deadline: '2023-11-25',
      internalDeadline: '2023-11-22',
      startDate: '2023-11-18',
      status: 'In Progress',
      messages: 0,
      internalMessages: 2,
      description: "UI design for the HUD interface of the Mark 85 suit.",
      descriptionTR: "Mark 85 zırhının HUD arayüzü için UI tasarımı.",
      requesterEmail: 'pepper.potts@pithema.com',
      createdAt: '2023-11-15',
      assignee: 'Sarah Miller',
      isClientVisible: false,
      requirements: ["Tasarım", "3D"], // UI Design->Tasarım, Holography->3D
      activityLog: [
        JobLog(
          id: 1,
          type: 'log',
          text: 'Job created',
          textTR: 'İş oluşturuldu',
          user: 'Pepper Potts',
          timestamp: '2023-11-15 08:30',
          visibility: 'internal',
        ),
        JobLog(
          id: 2,
          type: 'comment',
          text: 'Tony wants the blue to be more "electric".',
          textTR: 'Tony mavinin daha "elektrikli" olmasını istiyor.',
          user: 'Pepper Potts',
          timestamp: '2023-11-16 10:00',
          visibility: 'client',
        ),
        JobLog(
          id: 3,
          type: 'comment',
          text: 'Internal Note: Check the hex codes from the brand guidelines.',
          textTR:
              'Dahili Not: Marka yönergelerindeki onaltılık kodları kontrol et.',
          user: 'Fatih Tunç',
          timestamp: '2023-11-16 10:15',
          visibility: 'internal',
        ),
      ],
    ),
  ];
}
