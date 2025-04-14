import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/textbutton_component/textbutton_component.dart';
import 'package:tadamon/features/pages/main_page/ui/widget/app_bar/side_page_app_bar.dart';

class TermsGate extends StatefulWidget {
  const TermsGate({super.key});

  @override
  State<TermsGate> createState() => _TermsGateState();
}

class _TermsGateState extends State<TermsGate> with TickerProviderStateMixin {
  bool _loading = true;
  bool _isChecked = false;
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;

final List<String> _terms = [

  // ▓ القسم الأول: الرخصة القانونية (GNU GPL v3)
  'التطبيق متاح تحت رخصة جنو العمومية الإصدار الثالث (GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007). وهي رخصة حرة تتيح لك حرية استخدام البرنامج ودراسته وتعديله وإعادة توزيعه، شريطة الالتزام الكامل ببنود هذه الرخصة.',
  'أي نسخة مُعدّلة من التطبيق يجب أن تظل مرخّصة بنفس رخصة GPLv3، ويجب توضيح التعديلات التي أُجريت على المشروع الأصلي بوضوح.',
  'يُمنع منعًا باتًا استخدام الكود المصدري للتطبيق في أي منتج تجاري مغلق المصدر أو تحت أي رخصة تتعارض مع رخصة GPLv3.',
  'يجب على أي طرف يقوم باستخدام أو توزيع نسخة من التطبيق تضمين نسخة كاملة من ملف الرخصة وإشعارًا بحقوق ملكية الكود الأصلي.',
  'يُقر المستخدم بفهمه الكامل لطبيعة رخصة المصادر المفتوحة وحقوقه والتزاماته بموجبها.',
  'لا يمنح هذا الترخيص أي حقوق في براءات الاختراع أو العلامات التجارية الخاصة بمطوري التطبيق.',

  // ▓ القسم الثاني: المسؤولية القانونية وإخلاء المسؤولية
  'يُقدّم هذا التطبيق "كما هو" دون أي ضمانات صريحة أو ضمنية، ويشمل ذلك على سبيل المثال لا الحصر، الضمانات المتعلقة بقابلية التطبيق للاستخدام أو ملاءمته لغرض معين أو خلوه من الأخطاء.',
  'استخدامك للتطبيق يقع على مسؤوليتك الشخصية بالكامل. لا يتحمل مطورو التطبيق أو أي من المساهمين فيه مسؤولية أي أضرار مباشرة أو غير مباشرة أو عرضية أو تبعية قد تنجم عن استخدامك للتطبيق أو عدم قدرتك على استخدامه.',
  'يُحظر استخدام التطبيق في أي نشاط غير قانوني، أو يتعارض مع الآداب العامة، أو قد يؤدي إلى إلحاق الضرر بأي طرف (جهة أو فرد) أو انتهاك حقوقهم.',
  'يُمنع استخدام التطبيق للتحريض على الكراهية أو العنف أو التمييز أو الإساءة لأي فرد أو جماعة أو نشر أي محتوى غير لائق أو مسيء. سيتم اتخاذ الإجراءات التقنية والقانونية اللازمة ضد المستخدمين الذين يخالفون هذه الشروط.',
  'لا يضمن مطورو التطبيق استمرار عمل التطبيق بشكل دائم أو خلوه من الانقطاعات أو الأخطاء التقنية.',
  'يخلي مطورو التطبيق مسؤوليتهم عن أي محتوى أو روابط خارجية قد تظهر داخل التطبيق والتي يتم توفيرها لأغراض إضافية ولا تخضع لسيطرتهم.',

  // ▓ القسم الثالث: الخصوصية والبيانات
  'هذا التطبيق لا يقوم بجمع أي معلومات تعريفية شخصية (PII) أو بيانات حساسة عن المستخدمين بشكل مباشر.',
  'أي صلاحيات يطلبها التطبيق من المستخدم (مثل الوصول إلى الكاميرا أو الإنترنت) تُستخدم فقط ضمن النطاق الوظيفي المعلن للتطبيق، على سبيل المثال، مسح الرموز الشريطية (الباركود) أو تحميل البيانات، وبموافقة صريحة من المستخدم.',
  'لا يتم مشاركة أي بيانات يتم جمعها بشكل غير مباشر (مثل بيانات الاستخدام المجهولة لتحسين التطبيق) مع أطراف ثالثة إلا في إطار تحسين الخدمة وبشكل لا يكشف عن هوية المستخدم.',
  'عند إرسال بلاغ عن منتج، فإن البيانات المرسلة قد تتضمن معلومات حول المنتج وتفاصيل البلاغ، ولكنها لا ترتبط بشكل مباشر بهوية المستخدم ويتم التعامل معها بسرية وحذفها بشكل دوري بعد مراجعتها.',
  'يتعهد مطورو التطبيق بالحفاظ على سرية البيانات التي قد يتم جمعها بشكل غير مباشر واتخاذ الإجراءات اللازمة لحمايتها من الوصول غير المصرح به.',
  'يحتفظ المستخدم بالحق في مراجعة أو طلب حذف أي بيانات مرتبطة بحسابه (إن وجدت) وفقًا لسياسة الخصوصية المعمول بها.',

  // ▓ القسم الرابع: المحتوى والمجتمع
  'جميع التقارير والمحتوى الذي يقدمه المستخدمون يخضع للمراجعة اليدوية من قبل فريق التطوير. قد يتم تعديل أو حذف أو تجاهل أي محتوى يُعتبر غير دقيق أو غير لائق أو مخالفًا لسياسات التطبيق أو للقانون.',
  'يُمنع استخدام التطبيق لنشر معلومات كاذبة أو مضللة أو تشهيرية أو عنصرية أو تحرض على الكراهية أو تتعارض مع قيم التضامن والعدالة والأخلاق العامة.',
  'لا يتحمل التطبيق أي مسؤولية عن دقة أو صحة أو مصداقية البلاغات المجتمعية التي يرسلها المستخدمون، وتقع مسؤولية هذا المحتوى على عاتق المستخدم الذي قام بإنشائه.',
  'يحق لفريق تطوير التطبيق حذف أي محتوى أو حظر أي مستخدم بشكل مؤقت أو دائم دون إشعار مسبق إذا تبين أنه يخالف هذه الشروط أو يسيء استخدام التطبيق أو يعرض سلامة المستخدمين الآخرين للخطر.',
  'يُشجع المستخدمون على الإبلاغ عن أي محتوى يرونه غير لائق أو مخالفًا للشروط ليتم مراجعته واتخاذ الإجراء المناسب.',
  'لا يضمن فريق التطوير الرد على جميع البلاغات المقدمة من المستخدمين أو اتخاذ إجراء بشأنها.',

  // ▓ القسم الخامس: التحديثات والتعديلات
  'يحتفظ فريق تطوير "تضامن" بحقه الكامل في تعديل أو تحديث أو تغيير هذه الشروط والأحكام في أي وقت دون الحاجة إلى إشعار مسبق. تعتبر النسخة المنشورة داخل التطبيق أو على الموقع الرسمي للتطبيق هي النسخة المعتمدة والنافذة.',
  'تقع على عاتق المستخدم مسؤولية مراجعة هذه الاتفاقية بشكل دوري للتأكد من موافقته المستمرة على أي تغييرات تطرأ عليها. يعتبر استمرار استخدام التطبيق بعد إجراء أي تعديلات بمثابة موافقة ضمنية من المستخدم على هذه التعديلات.',
  'قد تتطلب بعض الميزات الجديدة أو المحسّنة تحديثات لاحقة للتطبيق. قد يتم فرض قيود تقنية مستقبلية على بعض الميزات بناءً على التغييرات في بنية التطبيق أو السياسات العامة أو المتطلبات القانونية.',
  'يحق لفريق التطوير تعليق أو إيقاف أو إنهاء التطبيق أو أي جزء منه بشكل مؤقت أو دائم لأسباب تقنية أو تجارية أو تنظيمية دون إشعار مسبق.',
  'لا يلتزم فريق التطوير بتوفير أي دعم فني أو صيانة مستمرة للتطبيق ما لم يتم الاتفاق على ذلك بشكل صريح.',
  'قد تتضمن التحديثات تغييرات في وظائف التطبيق أو واجهة المستخدم.',

  // ▓ القسم السادس: حقوق النشر والممتلكات الفكرية
  'جميع الأكواد المصدرية والتصاميم والرسومات والشعارات والعلامات التجارية وأي محتوى آخر موجود في التطبيق مملوك بالكامل لفريق تطوير "تضامن" أو الجهات المرخصة له. يُمنع نسخها أو إعادة إنتاجها أو توزيعها أو تعديلها أو استخدامها بأي شكل من الأشكال دون الحصول على إذن خطي مسبق من المالك.',
  'لا يُسمح باستخدام العناصر الرسومية أو العلامات التجارية الخاصة بالتطبيق لأغراض تجارية أو دعائية أو في أي سياق قد يوحي بالارتباط أو التأييد من قبل فريق التطوير إلا بعد الحصول على موافقة مكتوبة صريحة.',
  'أي محاولة لتفكيك أو عكس هندسة التطبيق أو استخراج الكود المصدري أو إنشاء أعمال مشتقة منه تُعتبر انتهاكًا صريحًا لحقوق الملكية الفكرية وتُعرّض الفاعل للملاحقة القانونية.',
  'يجب على المستخدم احترام جميع حقوق النشر والعلامات التجارية والإشعارات الخاصة بالملكية الفكرية الأخرى الموجودة في التطبيق.',
  'لا يمنح استخدام التطبيق المستخدم أي حقوق ملكية في التطبيق أو محتواه.',
  'يحتفظ فريق التطوير بجميع الحقوق غير الممنوحة صراحة للمستخدم بموجب هذه الشروط.',

  // ▓ القسم الأخير: الموافقة النهائية
  'باستخدامك لهذا التطبيق، فإنك تقر وتوافق على جميع الشروط والأحكام المذكورة أعلاه بشكل كامل وغير مشروط. يعتبر هذا الاتفاق ساري المفعول وملزمًا لك بمجرد استخدامك للتطبيق.',
  'في حال عدم موافقتك على أي بند من هذه البنود، يُرجى التوقف عن استخدام التطبيق على الفور وعدم الوصول إليه أو تنزيله.',
  'يخضع تفسير وتطبيق هذه الشروط والأحكام لقوانين جمهورية مصر العربية. في حال نشوء أي نزاع يتعلق بهذه الشروط، تختص محاكم جمهورية مصر العربية بالفصل فيه.',
  'إذا كان أي بند من بنود هذه الاتفاقية غير صالح أو غير قابل للتنفيذ بموجب القانون المعمول به، فسيظل باقي بنود الاتفاقية سارية ونافذة بأقصى قدر يسمح به القانون.',
  'يمثل هذا الاتفاق كامل الاتفاق بينك وبين فريق تطوير التطبيق فيما يتعلق باستخدام التطبيق ويحل محل أي اتفاقيات أو تفاهمات سابقة.',
  'يحق لفريق التطوير التنازل عن حقوقه أو التزاماته بموجب هذه الشروط إلى طرف ثالث دون الحاجة إلى موافقتك.',
];

  @override
  void initState() {
    super.initState();
    _checkAgreement();
    _initAnimations();
  }

  void _initAnimations() {
    _controllers = List.generate(
      _terms.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 100)),
      ),
    );

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    // Delay start a bit for UX
    Future.delayed(const Duration(milliseconds: 200), () {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }

  Future<void> _checkAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool agreed = prefs.getBool('agreed_to_terms') ?? false;

    if (agreed) {
      _navigateToHome();
    } else {
      setState(() => _loading = false);
    }
  }

  Future<void> _agree() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('agreed_to_terms', true);
    _navigateToHome();
  }

  void _navigateToHome() {
    HapticFeedback.vibrate();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mainPage,
      (route) => false,
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: const SidePageAppBar(
        title: 'اتفاقية استخدام التطبيق',
      ),
      body: Padding(
        padding: const EdgeInsets.all(SenseiConst.padding),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _terms.length,
                itemBuilder: (context, index) {
                  return SlideTransition(
                    position: _slideAnimations[index],
                    child: FadeTransition(
                      opacity: _controllers[index],
                      child: Card(
                        margin: EdgeInsets.only(top: SenseiConst.margin.h),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(SenseiConst.padding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}. ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: Text(_terms[index])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                const Text('أوافق على الشروط والأحكام'),
              ],
            ),
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButtonComponent(
                  onTap: () =>
                      {HapticFeedback.vibrate(), SystemNavigator.pop()},
                  text: ' الخروج من التطبيق',
                  icon: Icons.close,
                  isClose: true,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: ButtonCompnent(
                    // useWidth: true,
                    // width: 0.5.sw,
                    label: 'مرحبًا بكم في تضامن',
                    icon: Icons.keyboard_double_arrow_left_rounded,
                    onPressed: _isChecked ? _agree : null,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
