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
    'تطبيق "تضامن" أداة توعوية لا تمثل أي جهة سياسية.',
    'استخدام التطبيق على مسؤوليتك الخاصة، ولا يتحمل المطور أي تبعات قانونية.',
    'يُمنع استخدام التطبيق للتحريض أو لأي غرض غير قانوني.',
    'جميع الأكواد والتصاميم مملوكة لمطوري التطبيق ولا يجوز إعادة استخدامها تجارياً.',
    'المعلومات المعروضة قد لا تكون دقيقة دائماً ويُرجى التحقق منها.',
    'التطبيق لا يجمع بيانات حساسة أو يشارك معلوماتك.',
    'باستخدامك للتطبيق فإنك توافق على الشروط كاملة، وقد يتم تعديلها لاحقًا دون إشعار.',
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
                        margin: EdgeInsets.symmetric(
                            vertical: SenseiConst.margin.h - 4),
                        elevation: 2,
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
            SizedBox(height: 8.h),
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
                Directionality(textDirection: TextDirection.ltr,
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
