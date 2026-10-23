[README.md](https://github.com/user-attachments/files/33893245/README.md)
# تطبيق كيدز ستاشن مصر (Kids Station App - Flutter + Firebase + Gate Reception)

مشروع تطبيق موبايل متكامل مبني بإطار العمل **Flutter** ومربوط سحابياً بـ **Firebase Cloud Firestore**، يجمع بين:
1. **واجهة أولياء الأمور والعملاء:** دليل الفروع الـ 8، الحجز الإلكتروني، محفظة نقاط الولاء، ومؤقت اللعب اللحظي.
2. **لوحة تحكم الإدارة واستقبال بوابات الفروع (Branch Gate Reception & Check-In/Out):** مسح تذاكر الـ QR عند البوابة، إصدار الأساور الذكية (`WB-...`)، توليد كود أمان استلام الطفل (`Pickup PIN`)، تسجيل الزوار المباشرين (`Walk-In`)، والتحكم اللحظي في حالة ازدحام الفروع.

## هيكل ملفات المشروع المرفق
- `lib/main.dart`: الكود الرئيسي للتطبيق شاملاً التبويبات الـ 5 (الفروع، الحجز، تذاكري، أطفالي والمحفظة، بوابة الفرع والإدارة).
- `lib/services/firebase_service.dart`: خدمة الربط السحابي مع **Firebase Cloud Firestore** (`branches`, `bookings`, `gate_sessions`, `notifications`).
- `firestore.rules`: قواعد الأمان الجاهزة للنشر في لوحة تحكم Firebase.
- `pubspec.yaml`: إعدادات الحزم (`firebase_core`, `cloud_firestore`, `firebase_auth`, `mobile_scanner`).

## خطوات ربط Firebase وتشغيل المشروع
1. أنشئ مشروعاً جديداً في [Firebase Console](https://console.firebase.google.com/) وفعّل **Cloud Firestore**.
2. اربط المشروع بتطبيق Flutter عبر أداة FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
3. انسخ قواعد الأمان من ملف `firestore.rules` إلى تبويب **Firestore Rules**.
4. شغّل التطبيق:
   ```bash
   flutter pub get
   flutter run
   ```
