import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const KidsStationApp());
}

class KidsStationApp extends StatelessWidget {
  const KidsStationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'كيدز ستاشن | Kids Station Egypt',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D28D9),
          primary: const Color(0xFF6D28D9),
          secondary: const Color(0xFFEC4899),
          tertiary: const Color(0xFFF59E0B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const MainHomeShell(),
    );
  }
}

// ==================== MODELS ====================

class Branch {
  final String id;
  final String name;
  final String region;
  final String regionLabel;
  final String address;
  final String phone;
  final double rating;
  final int reviews;
  final String hours;
  final String ages;
  final String crowdStatus; // quiet, moderate, busy
  final String crowdLabel;
  final int price1Hour;
  final int price2Hours;
  final int price5Hours;
  final int priceBirthday;
  final int priceExtraAdult;
  final List<String> activities;
  final String highlights;
  final String sourceUrl;

  const Branch({
    required this.id,
    required this.name,
    required this.region,
    required this.regionLabel,
    required this.address,
    required this.phone,
    required this.rating,
    required this.reviews,
    required this.hours,
    required this.ages,
    required this.crowdStatus,
    required this.crowdLabel,
    required this.price1Hour,
    required this.price2Hours,
    required this.price5Hours,
    required this.priceBirthday,
    required this.priceExtraAdult,
    required this.activities,
    required this.highlights,
    required this.sourceUrl,
  });
}

class ChildProfile {
  final String id;
  final String name;
  final int age;
  final String favActivity;
  bool selectedForBooking;

  ChildProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.favActivity,
    this.selectedForBooking = true,
  });
}

class BookingRecord {
  final String id;
  final String branchId;
  final String branchName;
  final String packageTitle;
  final String date;
  final String timeSlot;
  final List<String> kidsNames;
  final int extraAdults;
  final int totalPaid;
  final String paymentLabel;
  final bool isActiveNow;

  BookingRecord({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.packageTitle,
    required this.date,
    required this.timeSlot,
    required this.kidsNames,
    required this.extraAdults,
    required this.totalPaid,
    required this.paymentLabel,
    this.isActiveNow = false,
  });
}

class GateSessionRecord {
  final String sessionId;
  final String bookingId;
  final String branchId;
  final String branchName;
  final String childName;
  final String parentName;
  final String parentPhone;
  final String wristbandCode;
  final String pickupPin;
  final String checkInTime;
  int remainingMinutes;
  String status; // inside, checked_out

  GateSessionRecord({
    required this.sessionId,
    required this.bookingId,
    required this.branchId,
    required this.branchName,
    required this.childName,
    required this.parentName,
    required this.parentPhone,
    required this.wristbandCode,
    required this.pickupPin,
    required this.checkInTime,
    required this.remainingMinutes,
    this.status = 'inside',
  });
}

// ==================== REAL BRANCHES DATA ====================

const List<Branch> kBranches = [
  Branch(
    id: 'new-cairo',
    name: 'فرع القاهرة الجديدة (التسعين الشمالي)',
    region: 'east',
    regionLabel: 'القاهرة الجديدة',
    address: 'شارع التسعين الشمالي، قسم أول القاهرة الجديدة، التجمع الخامس',
    phone: '01000455777',
    rating: 4.6,
    reviews: 1897,
    hours: 'السبت - الأربعاء: 10 ص - 10 م | الخميس والجمعة: 10 ص - 11 م',
    ages: '1 - 10 سنوات',
    crowdStatus: 'quiet',
    crowdLabel: 'هادئ الآن 🟢 (مناسب للأطفال الصغار)',
    price1Hour: 240,
    price2Hours: 440,
    price5Hours: 650,
    priceBirthday: 4500,
    priceExtraAdult: 100,
    activities: [
      'بيت الكور الضخم',
      'تسلق الحوائط',
      'رمل حركي (Kinetic Sand)',
      'ليجو ومكعبات',
      'المطبخ التخيلي وبيوت اللعب',
      'كافيه أولياء الأمور'
    ],
    highlights: 'أكبر منطقة ألعاب تفاعلية وتعليمية في التجمع الخامس مع كافيه مريح لمتابعة أطفالك.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-new-cairo-110525',
  ),
  Branch(
    id: 'sheikh-zayed-americana',
    name: 'فرع الشيخ زايد (أمريكانا بلازا)',
    region: 'west',
    regionLabel: 'الشيخ زايد',
    address: 'أمريكانا بلازا، حي الروضة، الشيخ زايد',
    phone: '01115020502',
    rating: 4.5,
    reviews: 548,
    hours: 'السبت - الأربعاء: 10 ص - 10 م | الخميس والجمعة: 10 ص - 11 م',
    ages: '1 - 10 سنوات',
    crowdStatus: 'moderate',
    crowdLabel: 'متوسط الازدحام 🟡 (إقبال عائلي معتدل)',
    price1Hour: 240,
    price2Hours: 440,
    price5Hours: 650,
    priceBirthday: 4500,
    priceExtraAdult: 100,
    activities: [
      'تسلق الحوائط الآمن',
      'ليجو وتحديات بازل',
      'صلصال رملي',
      'رسم وتلوين',
      'ألعاب مغناطيسية',
      'استراحة وكافيه للأهل'
    ],
    highlights: 'موقع متميز داخل أمريكانا بلازا يجمع بين الألعاب الحركية وتنمية المهارات الذهنية.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-sheikh-zayed-americana-plaza-61050',
  ),
  Branch(
    id: 'sheikh-zayed-hub',
    name: 'فرع الشيخ زايد (ذا هب مول سوديك)',
    region: 'west',
    regionLabel: 'الشيخ زايد - سوديك',
    address: 'ذا هب مول (The Hub SODIC)، الشيخ زايد',
    phone: '01115020502',
    rating: 4.5,
    reviews: 412,
    hours: 'يومياً من 10:00 صباحاً حتى 10:00 مساءً',
    ages: '1 - 10 سنوات',
    crowdStatus: 'quiet',
    crowdLabel: 'هادئ الآن 🟢 (أفضل سعر تذكرة صباحية)',
    price1Hour: 210,
    price2Hours: 390,
    price5Hours: 590,
    priceBirthday: 4200,
    priceExtraAdult: 100,
    activities: [
      'منطقة سوفت بلاي',
      'بيت الكور',
      'رمل حركي',
      'تلوين وحرف يدوية',
      'ألعاب ذكاء وبازل'
    ],
    highlights: 'يتميز بأسعار خاصة تبدأ من 210 ج.م للساعة وأجواء هادئة وآمنة داخل كمبوند سوديك.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-hub-mall-sheikh-zayed-112405',
  ),
  Branch(
    id: 'nasr-city',
    name: 'فرع مدينة نصر (توكانو كومبليكس)',
    region: 'central',
    regionLabel: 'مدينة نصر',
    address: '66 شارع يوسف عباس، توكانو كومبليكس، أمام جامعة الأزهر، مدينة نصر',
    phone: '01103273001',
    rating: 4.5,
    reviews: 954,
    hours: 'يومياً من 10:00 صباحاً حتى 11:00 مساءً',
    ages: '1 - 10 سنوات',
    crowdStatus: 'busy',
    crowdLabel: 'نشط الآن 🟠 (يفضل الحجز الإلكتروني المسبق)',
    price1Hour: 240,
    price2Hours: 440,
    price5Hours: 650,
    priceBirthday: 4500,
    priceExtraAdult: 100,
    activities: [
      'مبنى من 3 طوابق ألعاب',
      'بيت الكور العملاق',
      'محطات التظاهر والمهن',
      'الرمل الحركي',
      'مناطق الكتل والمكعبات',
      'كافيه عائلي'
    ],
    highlights: 'مبنى متكامل مكون من 3 طوابق سحرية للأطفال يشمل محطات تمثيل الأدوار والكافيه.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-nasr-city-122707',
  ),
  Branch(
    id: 'maadi',
    name: 'فرع المعادي (زهراء المعادي)',
    region: 'central',
    regionLabel: 'المعادي',
    address: 'زهراء المعادي، القاهرة',
    phone: '01115020502',
    rating: 4.5,
    reviews: 620,
    hours: 'يومياً من 10:00 صباحاً حتى 10:00 مساءً',
    ages: '1 - 10 سنوات',
    crowdStatus: 'quiet',
    crowdLabel: 'هادئ الآن 🟢 (متاح دخول فوري)',
    price1Hour: 240,
    price2Hours: 440,
    price5Hours: 650,
    priceBirthday: 4400,
    priceExtraAdult: 100,
    activities: [
      'ترامبولين وسوفت بلاي',
      'بيت الكور',
      'فنون وحرف يدوية',
      'ألعاب منتسوري خشبية',
      'كافيه أولياء الأمور'
    ],
    highlights: 'وجهة مفضلة لعائلات المعادي تجمع بين اللعب الحركي الآمن والأنشطة الفنية.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-maadi-62363',
  ),
  Branch(
    id: 'madinaty',
    name: 'فرع مدينتي (Madinaty)',
    region: 'east',
    regionLabel: 'مدينتي',
    address: 'منطقة الخدمات والمراكز التجارية، مدينتي، القاهرة الجديدة',
    phone: '01115020502',
    rating: 4.6,
    reviews: 730,
    hours: 'يومياً من 10:00 صباحاً حتى 11:00 مساءً',
    ages: '1 - 10 سنوات',
    crowdStatus: 'moderate',
    crowdLabel: 'متوسط الازدحام 🟡 (متاح حجز فوري)',
    price1Hour: 240,
    price2Hours: 440,
    price5Hours: 650,
    priceBirthday: 4600,
    priceExtraAdult: 100,
    activities: [
      'بيت الكور والزحاليق',
      'تسلق الحوائط',
      'المطبخ التخيلي والسوبر ماركت',
      'الرمل الطبي الآمن',
      'قاعة أعياد ميلاد'
    ],
    highlights: 'مساحة عصرية واسعة مجهزة بأحدث ألعاب المحاكاة وقاعة احتفالات أعياد الميلاد.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-madinaty-122709',
  ),
  Branch(
    id: 'rehab',
    name: 'فرع مدينة الرحاب',
    region: 'east',
    regionLabel: 'الرحاب',
    address: 'مدينة الرحاب، القاهرة الجديدة',
    phone: '01115020502',
    rating: 4.5,
    reviews: 510,
    hours: 'يومياً من 10:00 صباحاً حتى 10:00 مساءً',
    ages: '1 - 10 سنوات',
    crowdStatus: 'quiet',
    crowdLabel: 'هادئ الآن 🟢 (مثالي للزيارة الآن)',
    price1Hour: 240,
    price2Hours: 440,
    price5Hours: 650,
    priceBirthday: 4400,
    priceExtraAdult: 100,
    activities: [
      'ألعاب البناء والليجو',
      'بيت الكور',
      'رسم وتلوين الوجه',
      'متاهة التحدي الحركي',
      'استراحة الأهالي'
    ],
    highlights: 'فرع عائلي قريب من سكان الرحاب مع إشراف متخصصين على أنشطة الأطفال.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-rehab-114015',
  ),
  Branch(
    id: 'obour',
    name: 'فرع مدينة العبور',
    region: 'east',
    regionLabel: 'العبور',
    address: 'مدينة العبور، القاهرة الكبرى',
    phone: '01115020502',
    rating: 4.5,
    reviews: 390,
    hours: 'يومياً من 10:00 صباحاً حتى 10:00 مساءً',
    ages: '1 - 10 سنوات',
    crowdStatus: 'quiet',
    crowdLabel: 'هادئ الآن 🟢 (متاح حجز فوري)',
    price1Hour: 240,
    price2Hours: 440,
    price5Hours: 650,
    priceBirthday: 4300,
    priceExtraAdult: 100,
    activities: [
      'منطقة القفز واللعب الحر',
      'الرمل الحركي',
      'ألعاب الذكاء والتركيب',
      'بيوت اللعب التخيلية',
      'كافيه مريح'
    ],
    highlights: 'يخدم عائلات مدينة العبور والشروق بمساحات لعب آمنة ومعقمة بالكامل.',
    sourceUrl: 'https://kidzapp.com/eg/kids-activities/cairo/fun-play/kids-station-obour-122708',
  ),
];

// ==================== MAIN SHELL STATE ====================

class MainHomeShell extends StatefulWidget {
  const MainHomeShell({super.key});

  @override
  State<MainHomeShell> createState() => _MainHomeShellState();
}

class _MainHomeShellState extends State<MainHomeShell> {
  int _currentIndex = 0;
  String _searchQuery = '';
  String _regionFilter = 'all';
  bool _onlyQuiet = false;
  final Set<String> _favoriteBranches = {'new-cairo', 'sheikh-zayed-americana'};

  int _loyaltyPoints = 450;
  int _remainingTimerSeconds = 1 * 3600 + 18 * 60 + 45;
  Timer? _sessionTimer;

  // Booking wizard state
  String _selectedBranchId = 'new-cairo';
  String _selectedPackageKey = 'hour2'; // hour1, hour2, hour5, birthday
  String _selectedDate = '2026-10-24';
  String _selectedTimeSlot = '04:00 م';
  int _extraAdults = 0;
  bool _addonSocks = false;
  bool _addonMeal = false;
  bool _addonPhoto = false;
  bool _promoApplied = false;
  bool _useLoyaltyDiscount = false;
  String _paymentMethod = 'InstaPay / محفظة ذكية';

  String _selectedGateBranchId = 'new-cairo';
  int _firestoreOpsCount = 14;
  final Map<String, String> _branchCrowdOverrides = {};

  final List<GateSessionRecord> _gateSessions = [
    GateSessionRecord(
      sessionId: 'GS-101',
      bookingId: 'KS-88412',
      branchId: 'new-cairo',
      branchName: 'فرع القاهرة الجديدة (التسعين الشمالي)',
      childName: 'آدم (6 سنوات)',
      parentName: 'أ. سارة',
      parentPhone: '01012345678',
      wristbandCode: 'WB-204',
      pickupPin: '4829',
      checkInTime: '05:00 م',
      remainingMinutes: 78,
    ),
    GateSessionRecord(
      sessionId: 'GS-102',
      bookingId: 'KS-88190',
      branchId: 'new-cairo',
      branchName: 'فرع القاهرة الجديدة (التسعين الشمالي)',
      childName: 'عمر (5 سنوات) + هنا (7 سنوات)',
      parentName: 'م. أحمد محمود',
      parentPhone: '01123459876',
      wristbandCode: 'WB-205 / WB-206',
      pickupPin: '9104',
      checkInTime: '05:25 م',
      remainingMinutes: 42,
    ),
  ];

  final List<String> _firestoreLiveLogs = [
    '[18:55:10] LISTEN branches/* -> 8 branches synced with Cloud Firestore',
    '[18:56:04] SET bookings/KS-88412 -> status: active, branch: new-cairo',
    '[18:56:05] SET gate_sessions/GS-101 -> wristband: WB-204, pickupPin: 4829',
  ];

  void _logFirestore(String op, String path, String detail) {
    final now = TimeOfDay.now();
    final t = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    _firestoreOpsCount++;
    _firestoreLiveLogs.insert(0, '[$t] $op $path -> $detail');
  }

  final List<ChildProfile> _children = [
    ChildProfile(id: 'kid-1', name: 'آدم', age: 6, favActivity: 'بيت الكور والتسلق'),
    ChildProfile(id: 'kid-2', name: 'فريدة', age: 4, favActivity: 'الرمل الحركي والصلصال'),
  ];

  final List<BookingRecord> _bookings = [
    BookingRecord(
      id: 'KS-88412',
      branchId: 'new-cairo',
      branchName: 'فرع القاهرة الجديدة (التسعين الشمالي)',
      packageTitle: 'ساعتين لعب (2 Hours)',
      date: '2026-10-23',
      timeSlot: '05:00 م',
      kidsNames: ['آدم (6 سنوات)'],
      extraAdults: 0,
      totalPaid: 440,
      paymentLabel: 'InstaPay / محفظة ذكية',
      isActiveNow: true,
    ),
    BookingRecord(
      id: 'KS-79205',
      branchId: 'sheikh-zayed-americana',
      branchName: 'فرع الشيخ زايد (أمريكانا بلازا)',
      packageTitle: 'باقة اليوم المرح (5 Hours VIP)',
      date: '2026-10-30',
      timeSlot: '02:00 م',
      kidsNames: ['آدم (6 سنوات)', 'فريدة (4 سنوات)'],
      extraAdults: 1,
      totalPaid: 1205,
      paymentLabel: 'بطاقة بنكية',
      isActiveNow: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingTimerSeconds > 0 && mounted) {
        setState(() {
          _remainingTimerSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final h = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final m = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Branch get _selectedBranch =>
      kBranches.firstWhere((b) => b.id == _selectedBranchId, orElse: () => kBranches.first);

  void _jumpToBookingForBranch(String branchId, {String? packageKey, bool applyPromo = false}) {
    setState(() {
      _selectedBranchId = branchId;
      if (packageKey != null) _selectedPackageKey = packageKey;
      if (applyPromo) _promoApplied = true;
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildBranchesDirectoryTab(),
      _buildBookingWizardTab(),
      _buildTicketsTab(),
      _buildProfileAndWalletTab(),
      _buildAdminAndGateReceptionTab(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(138),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4C1D95), Color(0xFF7C3AED), Color(0xFFDB2777)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.toys_rounded, color: Color(0xFFFCD34D), size: 28),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'كيدز ستاشن مصر',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                'أهلاً أ. سارة 👋 • دليل الفروع والحجز الفوري',
                                style: TextStyle(color: Color(0xFFE9D5FF), fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => setState(() => _currentIndex = 3),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('نقاط الولاء', style: TextStyle(color: Colors.white70, fontSize: 10)),
                              Text(
                                '⭐ $_loyaltyPoints نقطة',
                                style: const TextStyle(
                                  color: Color(0xFFFCD34D),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Active Play Session Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, color: Color(0xFF6EE7B7), size: 20),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'جلسة نشطة: آدم (فرع القاهرة الجديدة)',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'الوقت المتبقي: ${_formatDuration(_remainingTimerSeconds)}',
                                  style: const TextStyle(color: Color(0xFFFCD34D), fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF59E0B),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            minimumSize: const Size(0, 32),
                          ),
                          onPressed: () {
                            setState(() {
                              _remainingTimerSeconds += 3600;
                              _loyaltyPoints += 20;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم تمديد وقت اللعب ساعة إضافية وإضافة +20 نقطة ولاء ⭐')),
                            );
                          },
                          child: const Text('+ تمديد ساعة', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.location_on_outlined),
            selectedIcon: Icon(Icons.location_on),
            label: 'دليل الفروع',
          ),
          const NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'حجز تذكرة',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('${_bookings.length}'),
              child: const Icon(Icons.qr_code_2_outlined),
            ),
            selectedIcon: Badge(
              label: Text('${_bookings.length}'),
              child: const Icon(Icons.qr_code_2),
            ),
            label: 'تذاكري',
          ),
          const NavigationDestination(
            icon: Icon(Icons.family_restroom_outlined),
            selectedIcon: Icon(Icons.family_restroom),
            label: 'أطفالي',
          ),
          const NavigationDestination(
            icon: Icon(Icons.qr_code_scanner_outlined),
            selectedIcon: Icon(Icons.qr_code_scanner),
            label: 'بوابة الفرع',
          ),
        ],
      ),
    );
  }

  // ==================== TAB 1: BRANCHES DIRECTORY ====================

  Widget _buildBranchesDirectoryTab() {
    final filtered = kBranches.where((b) {
      if (_regionFilter == 'fav' && !_favoriteBranches.contains(b.id)) return false;
      if (_regionFilter != 'all' && _regionFilter != 'fav' && b.region != _regionFilter) return false;
      if (_onlyQuiet && b.crowdStatus != 'quiet') return false;
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.trim().toLowerCase();
        final hay = '${b.name} ${b.address} ${b.regionLabel} ${b.activities.join(' ')}'.toLowerCase();
        if (!hay.contains(q)) return false;
      }
      return true;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Promo card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFEC4899)]),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عرض نهاية الأسبوع 🎉',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'باقة اللعب المفتوح 5 ساعات بـ 650 ج.م فقط!',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'شامل دخول مرافق مجاناً + خصم 15% للأخوات بالكود KIDS15',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6D28D9),
                ),
                onPressed: () => _jumpToBookingForBranch(_selectedBranchId, packageKey: 'hour5', applyPromo: true),
                child: const Text('احجز العرض', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Search input
        TextField(
          onChanged: (val) => setState(() => _searchQuery = val),
          decoration: InputDecoration(
            hintText: 'ابحث باسم الفرع، المنطقة، أو النشاط (الشيخ زايد، التجمع)...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Region chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildRegionChip('all', 'الكل (8 فروع)'),
              _buildRegionChip('east', 'القاهرة الجديدة والرحاب ومدينتي (4)'),
              _buildRegionChip('west', 'الشيخ زايد وأكتوبر (2)'),
              _buildRegionChip('central', 'مدينة نصر والمعادي (2)'),
              _buildRegionChip('fav', '❤️ المفضلة'),
            ],
          ),
        ),
        const SizedBox(height: 6),

        // Quiet toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _onlyQuiet,
                  onChanged: (val) => setState(() => _onlyQuiet = val ?? false),
                ),
                const Text('الفروع الهادئة الآن فقط 🟢', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
            Text(
              'المعروض: ${filtered.length} فروع',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF6D28D9)),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Branches cards
        ...filtered.map((branch) => _buildBranchCard(branch)),
      ],
    );
  }

  Widget _buildRegionChip(String key, String label) {
    final selected = _regionFilter == key;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ChoiceChip(
        label: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        selected: selected,
        onSelected: (_) => setState(() => _regionFilter = key),
      ),
    );
  }

  Widget _buildBranchCard(Branch branch) {
    final isFav = _favoriteBranches.contains(branch.id);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDE9FE),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              branch.regionLabel,
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF5B21B6)),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '⭐ ${branch.rating} (${branch.reviews} تقييم)',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFB45309)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        branch.name,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.pink),
                  onPressed: () {
                    setState(() {
                      if (isFav) {
                        _favoriteBranches.remove(branch.id);
                      } else {
                        _favoriteBranches.add(branch.id);
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('📍 ${branch.address}', style: const TextStyle(fontSize: 12, color: Colors.black87)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(branch.crowdLabel, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  Text('الأعمار: ${branch.ages}', style: const TextStyle(fontSize: 11, color: Color(0xFF6D28D9), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: branch.activities
                  .take(4)
                  .map((act) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(act, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                      ))
                  .toList(),
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('تبدأ التذكرة من', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text(
                      '${branch.price1Hour} ج.م / ساعة',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF6D28D9)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () => _showBranchDetailsSheet(branch),
                      child: const Text('التفاصيل والأسعار', style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () => _jumpToBookingForBranch(branch.id),
                      child: const Text('احجز الآن 🎟️', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBranchDetailsSheet(Branch branch) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(branch.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('📍 ${branch.address}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(branch.highlights, style: const TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 12),
              Text('🕒 مواعيد العمل: ${branch.hours}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text('📞 هاتف الفرع: ${branch.phone}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('قائمة أسعار التذاكر بالفرع:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPricePill('ساعة لعب', '${branch.price1Hour} ج.م'),
                  _buildPricePill('ساعتين لعب', '${branch.price2Hours} ج.م'),
                  _buildPricePill('باقة 5 ساعات', '${branch.price5Hours} ج.م'),
                  _buildPricePill('مرافق إضافي', '${branch.priceExtraAdult} ج.م'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _jumpToBookingForBranch(branch.id);
                  },
                  child: const Text('احجز في هذا الفرع الآن 🎟️', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPricePill(String label, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
          const SizedBox(height: 2),
          Text(price, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF6D28D9))),
        ],
      ),
    );
  }

  // ==================== TAB 2: ONLINE BOOKING WIZARD ====================

  int _calculateBasePrice(Branch b, int kidsCount) {
    switch (_selectedPackageKey) {
      case 'hour1':
        return b.price1Hour * kidsCount;
      case 'hour2':
        return b.price2Hours * kidsCount;
      case 'hour5':
        return b.price5Hours * kidsCount;
      case 'birthday':
        return b.priceBirthday;
      default:
        return b.price2Hours * kidsCount;
    }
  }

  String _getPackageTitle() {
    switch (_selectedPackageKey) {
      case 'hour1':
        return 'ساعة لعب (1 Hour)';
      case 'hour2':
        return 'ساعتين لعب (2 Hours)';
      case 'hour5':
        return 'باقة اليوم المرح (5 Hours VIP)';
      case 'birthday':
        return 'باقة عيد ميلاد (15 طفل)';
      default:
        return 'ساعتين لعب (2 Hours)';
    }
  }

  Widget _buildBookingWizardTab() {
    final branch = _selectedBranch;
    final selectedKids = _children.where((c) => c.selectedForBooking).toList();
    final kidsCount = max(1, selectedKids.length);
    final baseTotal = _calculateBasePrice(branch, kidsCount);
    final addonsTotal = (_extraAdults * branch.priceExtraAdult) +
        (_addonSocks ? 35 * kidsCount : 0) +
        (_addonMeal ? 95 * kidsCount : 0) +
        (_addonPhoto ? 60 : 0);
    final subtotal = baseTotal + addonsTotal;
    int discount = 0;
    if (_promoApplied) discount += (subtotal * 0.15).round();
    if (_useLoyaltyDiscount && _loyaltyPoints >= 200) discount += 50;
    final finalTotal = max(0, subtotal - discount);
    final earnedPoints = (finalTotal * 0.1).round();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('الحجز الإلكتروني الفوري 🎟️', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                const Text('اختر الفرع والباقة واستلم تذكرة الـ QR للدخول المباشر', style: TextStyle(fontSize: 12, color: Colors.black54)),
                const Divider(height: 24),

                // 1. Branch Dropdown
                const Text('1. اختر فرع كيدز ستاشن:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedBranchId,
                  items: kBranches
                      .map((b) => DropdownMenuItem(
                            value: b.id,
                            child: Text('${b.name} (من ${b.price1Hour} ج.م)', style: const TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedBranchId = val);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Package choice
                const Text('2. اختر باقة اللعب أو الاحتفال:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildPackageChoiceCard('hour1', 'ساعة لعب', '${branch.price1Hour} ج.م / طفل'),
                    _buildPackageChoiceCard('hour2', 'ساعتين لعب 🔥', '${branch.price2Hours} ج.م / طفل'),
                    _buildPackageChoiceCard('hour5', 'باقة 5 ساعات ⭐', '${branch.price5Hours} ج.م / طفل'),
                    _buildPackageChoiceCard('birthday', 'عيد ميلاد 🎂', '${branch.priceBirthday} ج.م للباقة'),
                  ],
                ),
                const SizedBox(height: 16),

                // 3. Time Slot
                const Text('3. اختر موعد الدخول المفضل:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['10:00 ص', '12:00 م', '02:00 م', '04:00 م', '06:00 م', '08:00 م']
                      .map((slot) => ChoiceChip(
                            label: Text(slot, style: const TextStyle(fontSize: 12)),
                            selected: _selectedTimeSlot == slot,
                            onSelected: (_) => setState(() => _selectedTimeSlot = slot),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // 4. Kids Selection
                const Text('4. الأطفال المشاركون بالحجز:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                ..._children.map((kid) => CheckboxListTile(
                      value: kid.selectedForBooking,
                      title: Text('${kid.name} (${kid.age} سنوات)', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: Text('النشاط المفضل: ${kid.favActivity}', style: const TextStyle(fontSize: 11)),
                      onChanged: (val) => setState(() => kid.selectedForBooking = val ?? false),
                    )),

                // 5. Extra adults & Addons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'مرافقين إضافيين (+100 ج.م للمرافق الإضافي، وأول مرافق مجاناً):',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => setState(() => _extraAdults = max(0, _extraAdults - 1)),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('$_extraAdults', style: const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () => setState(() => _extraAdults = min(6, _extraAdults + 1)),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ],
                ),
                CheckboxListTile(
                  dense: true,
                  value: _addonSocks,
                  onChanged: (v) => setState(() => _addonSocks = v ?? false),
                  title: const Text('🧦 جوارب مانعة للانزلاق (+35 ج.م / طفل)', style: TextStyle(fontSize: 12)),
                ),
                CheckboxListTile(
                  dense: true,
                  value: _addonMeal,
                  onChanged: (v) => setState(() => _addonMeal = v ?? false),
                  title: const Text('🍱 وجبة كيدز صحية (+95 ج.م / طفل)', style: TextStyle(fontSize: 12)),
                ),
                CheckboxListTile(
                  dense: true,
                  value: _addonPhoto,
                  onChanged: (v) => setState(() => _addonPhoto = v ?? false),
                  title: const Text('📸 صورة فورية تذكارية (+60 ج.م)', style: TextStyle(fontSize: 12)),
                ),
                const Divider(height: 20),

                // 6. Discounts
                SwitchListTile(
                  dense: true,
                  value: _promoApplied,
                  onChanged: (v) => setState(() => _promoApplied = v),
                  title: const Text('تفعيل كود خصم الأخوات KIDS15 (-15%)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                SwitchListTile(
                  dense: true,
                  value: _useLoyaltyDiscount,
                  onChanged: (v) {
                    if (v && _loyaltyPoints < 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('رصيد نقاطك أقل من 200 نقطة')),
                      );
                      return;
                    }
                    setState(() => _useLoyaltyDiscount = v);
                  },
                  title: Text('استبدال 200 نقطة ولاء بخصم فوري 50 ج.م (رصيدك: $_loyaltyPoints)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),

                // Summary box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('التذاكر (${_getPackageTitle()})', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          Text('$baseTotal ج.م', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('الإضافات والمرافقين', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text('$addonsTotal ج.م', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      if (discount > 0) ...[
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('إجمالي الخصم المطبق', style: TextStyle(color: Color(0xFF6EE7B7), fontSize: 12)),
                            Text('-$discount ج.م', style: const TextStyle(color: Color(0xFF6EE7B7), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                      const Divider(color: Colors.white24, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('الإجمالي المطلوب سداده', style: TextStyle(color: Colors.white60, fontSize: 11)),
                              Text(
                                '$finalTotal ج.م',
                                style: const TextStyle(color: Color(0xFFFCD34D), fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          Text(
                            '+$earnedPoints نقطة ولاء ⭐',
                            style: const TextStyle(color: Color(0xFF6EE7B7), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF59E0B),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            if (selectedKids.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('يرجى اختيار طفل واحد على الأقل لإتمام الحجز')),
                              );
                              return;
                            }
                            final newId = 'KS-${10000 + Random().nextInt(89999)}';
                            final newRecord = BookingRecord(
                              id: newId,
                              branchId: branch.id,
                              branchName: branch.name,
                              packageTitle: _getPackageTitle(),
                              date: _selectedDate,
                              timeSlot: _selectedTimeSlot,
                              kidsNames: selectedKids.map((k) => '${k.name} (${k.age} سنوات)').toList(),
                              extraAdults: _extraAdults,
                              totalPaid: finalTotal,
                              paymentLabel: _paymentMethod,
                            );
                            setState(() {
                              if (_useLoyaltyDiscount && _loyaltyPoints >= 200) {
                                _loyaltyPoints -= 200;
                                _useLoyaltyDiscount = false;
                              }
                              _loyaltyPoints += earnedPoints;
                              _bookings.insert(0, newRecord);
                              _logFirestore('SET', 'bookings/$newId', 'branch: ${branch.id}, totalPaid: $finalTotal EGP');
                              _currentIndex = 2;
                            });
                            _showQrDialog(newRecord);
                          },
                          child: const Text(
                            'تأكيد الحجز وإصدار تذكرة الـ QR ✨',
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageChoiceCard(String key, String title, String priceLabel) {
    final active = _selectedPackageKey == key;
    return InkWell(
      onTap: () => setState(() => _selectedPackageKey = key),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFF5F3FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? const Color(0xFF6D28D9) : const Color(0xFFE2E8F0),
            width: active ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(priceLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF6D28D9))),
          ],
        ),
      ),
    );
  }

  // ==================== TAB 3: MY TICKETS ====================

  Widget _buildTicketsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('تذاكري وحجوزاتي الرقمية 📲', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
        const Text('امسح رمز الـ QR عند بوابة الفرع للدخول السريع واستلام أسورة اللعب', style: TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 12),
        ..._bookings.map((bk) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('#${bk.id}', style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.grey)),
                        Text('${bk.totalPaid} ج.م', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF6D28D9))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(bk.branchName, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
                    Text('${bk.packageTitle} • ${bk.date} (${bk.timeSlot})', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                    Text('الأطفال: ${bk.kidsNames.join('، ')}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => _showQrDialog(bk),
                            icon: const Icon(Icons.qr_code_2),
                            label: const Text('عرض تذكرة الـ QR للدخول'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  void _showQrDialog(BookingRecord bk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(bk.branchName, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(bk.packageTitle, style: const TextStyle(fontSize: 12, color: Color(0xFF6D28D9), fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black87, width: 2),
              ),
              child: const Icon(Icons.qr_code_2_rounded, size: 120, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Text(bk.id, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            Text('${bk.date} • ${bk.timeSlot}', style: const TextStyle(fontSize: 12)),
            Text('الأطفال: ${bk.kidsNames.join('، ')}', style: const TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: bk.id));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم نسخ كود التذكرة ${bk.id}')),
              );
            },
            child: const Text('نسخ الكود'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  // ==================== TAB 4: KIDS PROFILE & LOYALTY WALLET ====================

  Widget _buildProfileAndWalletTab() {
    final nameController = TextEditingController();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF4C1D95), Color(0xFF7C3AED)]),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('عضوية العائلة الذهبية ⭐', style: TextStyle(color: Color(0xFFFCD34D), fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('رصيدك الحالي: $_loyaltyPoints نقطة', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
              const SizedBox(height: 6),
              const Text('استبدل نقاطك بساعات لعب مجانية أو ضيافة في كافيه أولياء الأمور.', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('أطفالي المسجلين بملف العائلة 👧👦', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        ..._children.map((kid) => Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: ListTile(
                leading: const CircleAvatar(child: Text('🧒')),
                title: Text('${kid.name} (${kid.age} سنوات)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('يفضل: ${kid.favActivity}', style: const TextStyle(fontSize: 12)),
              ),
            )),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('إضافة طفل جديد لحساب العائلة:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'اسم الطفل (مثل: ليلى)',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) return;
                    setState(() {
                      _children.add(ChildProfile(
                        id: 'kid-${DateTime.now().millisecondsSinceEpoch}',
                        name: name,
                        age: 5,
                        favActivity: 'بيت الكور والتسلق',
                      ));
                    });
                  },
                  child: const Text('+ حفظ وإضافة الطفل'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==================== TAB 5: ADMIN DASHBOARD & BRANCH GATE RECEPTION + FIREBASE ====================

  Widget _buildAdminAndGateReceptionTab() {
    final scanController = TextEditingController();
    final walkInChildController = TextEditingController();
    final walkInPhoneController = TextEditingController();
    final activeSessions = _gateSessions.where((s) => s.status == 'inside').toList();
    final totalRevenue = _bookings.fold<int>(0, (sum, b) => sum + b.totalPaid);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 1. Firebase & Gate Header Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '🔥 Firebase Firestore متزامن لحظياً',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                  ),
                  Text(
                    '$_firestoreOpsCount عملية سحابية',
                    style: const TextStyle(color: Color(0xFF6EE7B7), fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'لوحة تحكم الإدارة واستقبال بوابات الفروع 🛂',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
              ),
              const Text(
                'مسح تذاكر الـ QR، إصدار الأساور الذكية، التحقق من كود استلام الطفل، وتحديث ازدحام الفروع',
                style: TextStyle(color: Colors.white70, fontSize: 11),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildAdminKpiTile('أطفال بالداخل', '${activeSessions.length}', const Color(0xFF6EE7B7)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildAdminKpiTile('إجمالي التذاكر', '${_bookings.length}', const Color(0xFFFCD34D)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildAdminKpiTile('تحصيلات البوابة', '$totalRevenue ج.م', Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // 2. QR Gate Check-In Scanner Card
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '1. استقبال بوابة الفرع ومسح تذكرة الدخول (QR Check-In) 📲',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedGateBranchId,
                  items: kBranches
                      .map((b) => DropdownMenuItem(
                            value: b.id,
                            child: Text('بوابة: ${b.name}', style: const TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedGateBranchId = v);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: scanController,
                        decoration: InputDecoration(
                          hintText: 'أدخل كود التذكرة (مثل KS-79205)',
                          isDense: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(backgroundColor: const Color(0xFF059669)),
                      onPressed: () => _handleGateQrScan(scanController.text),
                      icon: const Icon(Icons.qr_code_scanner, size: 18),
                      label: const Text('تفعيل الدخول'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('تذاكر الحجوزات المسجلة بـ Firestore (اضغط للمسح الفوري):', style: TextStyle(fontSize: 11, color: Colors.black54)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _bookings
                      .map((bk) => ActionChip(
                            avatar: const Icon(Icons.confirmation_number, size: 15),
                            label: Text('${bk.id} (${bk.kidsNames.first})', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            onPressed: () => _handleGateQrScan(bk.id),
                          ))
                      .toList(),
                ),
                const Divider(height: 24),
                const Text('تسجيل دخول زائر مباشر على البوابة (Walk-In):', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: walkInChildController,
                        decoration: const InputDecoration(
                          hintText: 'اسم الطفل',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: walkInPhoneController,
                        decoration: const InputDecoration(
                          hintText: 'هاتف ولي الأمر',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        final childName = walkInChildController.text.trim().isEmpty
                            ? 'طفل زائر'
                            : walkInChildController.text.trim();
                        final phone = walkInPhoneController.text.trim().isEmpty
                            ? '01000000000'
                            : walkInPhoneController.text.trim();
                        final wb = 'WB-${300 + Random().nextInt(690)}';
                        final pin = '${1000 + Random().nextInt(8999)}';
                        final sessId = 'GS-${200 + Random().nextInt(790)}';
                        final gateBranch = kBranches.firstWhere((b) => b.id == _selectedGateBranchId);
                        setState(() {
                          _gateSessions.insert(
                            0,
                            GateSessionRecord(
                              sessionId: sessId,
                              bookingId: 'WALK-IN',
                              branchId: gateBranch.id,
                              branchName: gateBranch.name,
                              childName: childName,
                              parentName: 'زائر مباشر بالفرع',
                              parentPhone: phone,
                              wristbandCode: wb,
                              pickupPin: pin,
                              checkInTime: 'الآن',
                              remainingMinutes: 120,
                            ),
                          );
                          _logFirestore('SET', 'gate_sessions/$sessId', 'walkIn: true, wristband: $wb, pin: $pin');
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم إصدار الأسورة ($wb) وكود الاستلام ($pin) للطفل $childName ✅')),
                        );
                      },
                      child: const Text('+ إصدار أسورة'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // 3. Active Children Inside Branch Monitor
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '2. الأطفال المتواجدون داخل الفرع والأساور الذكية ⌚',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                if (activeSessions.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: Text('لا توجد جلسات نشطة حالياً داخل البوابة')),
                  )
                else
                  ...activeSessions.map((sess) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '⌚ أسورة: ${sess.wristbandCode}',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF6D28D9)),
                                ),
                                Text(
                                  '🔐 كود الاستلام: ${sess.pickupPin}',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFFB45309)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('👧 ${sess.childName} • ولي الأمر: ${sess.parentName} (${sess.parentPhone})',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                            Text('⏱️ المتبقي: ${sess.remainingMinutes} دقيقة • ${sess.branchName}',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF059669), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      sess.remainingMinutes += 30;
                                      _logFirestore('UPDATE', 'gate_sessions/${sess.sessionId}', 'remainingMinutes: ${sess.remainingMinutes}');
                                    });
                                  },
                                  child: const Text('+30 د', style: TextStyle(fontSize: 11)),
                                ),
                                const SizedBox(width: 6),
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _logFirestore('SET', 'notifications/call_${sess.sessionId}', 'parentPhone: ${sess.parentPhone}');
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('تم إرسال نداء لولي الأمر (${sess.parentName}) عبر التطبيق 🔔')),
                                    );
                                  },
                                  child: const Text('🔔 نداء للأهل', style: TextStyle(fontSize: 11)),
                                ),
                                const SizedBox(width: 6),
                                FilledButton(
                                  style: FilledButton.styleFrom(backgroundColor: const Color(0xFFE11D48)),
                                  onPressed: () {
                                    setState(() {
                                      sess.status = 'checked_out';
                                      _logFirestore('UPDATE', 'gate_sessions/${sess.sessionId}', 'status: checked_out, pinVerified: ${sess.pickupPin}');
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('تم التحقق من الكود (${sess.pickupPin}) وتسجيل خروج آمن للطفل ${sess.childName} ✅')),
                                    );
                                  },
                                  child: const Text('🚪 تسجيل خروج', style: TextStyle(fontSize: 11)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // 4. Live Firestore Operations Log
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '3. سجل عمليات Firebase Cloud Firestore اللحظي 🔥',
                style: TextStyle(color: Color(0xFFFCD34D), fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._firestoreLiveLogs.take(6).map((log) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      log,
                      style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdminKpiTile(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(color: valueColor, fontSize: 15, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  void _handleGateQrScan(String rawCode) {
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty) return;
    final idx = _bookings.indexWhere((b) => b.id.toUpperCase() == code);
    if (idx == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لم يتم العثور على التذكرة $code في قاعدة بيانات Firebase ⚠️')),
      );
      return;
    }
    final bk = _bookings[idx];
    final wb = 'WB-${210 + Random().nextInt(780)}';
    final pin = '${1000 + Random().nextInt(8999)}';
    final sessId = 'GS-${110 + Random().nextInt(880)}';

    setState(() {
      _gateSessions.insert(
        0,
        GateSessionRecord(
          sessionId: sessId,
          bookingId: bk.id,
          branchId: bk.branchId,
          branchName: bk.branchName,
          childName: bk.kidsNames.join(' + '),
          parentName: 'أ. سارة (حجز إلكتروني)',
          parentPhone: '01012345678',
          wristbandCode: wb,
          pickupPin: pin,
          checkInTime: 'الآن',
          remainingMinutes: bk.packageTitle.contains('5') ? 300 : 120,
        ),
      );
      _logFirestore('UPDATE', 'bookings/${bk.id}', 'status: active, checkedInAtGate: true');
      _logFirestore('SET', 'gate_sessions/$sessId', 'wristband: $wb, pickupPin: $pin');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم مسح التذكرة ${bk.id} وتخصيص الأسورة ($wb) وكود الاستلام ($pin) ✅')),
    );
  }

}
