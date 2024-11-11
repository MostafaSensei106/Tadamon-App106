import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSenseiDev extends StatelessWidget {
  const ContactSenseiDev({super.key});

  static const _socialLinks = [
    _SocialLink(
      url: 'https://www.linkedin.com/in/mostafa-mahmoud-963a78235/',
      icon: FontAwesomeIcons.linkedin,
      color: Color(0xFF0077B5),
    ),
    _SocialLink(
      url: 'https://github.com/MostafaSensei106',
      icon: FontAwesomeIcons.github,
      color: Color(0xFF181717),
    ),
    _SocialLink(
      url: 'https://www.facebook.com/MostafaSensei106',
      icon: FontAwesomeIcons.facebook,
      color: Color(0xFF1877F2),
    ),
  ];

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();

  void showDevDialog(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Wrap(
            children: [
              _buildHeader(context),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 80.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryFixedDim,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          Text(
            S.of(context).ContactDev,
            style: theme.textTheme.titleMedium?.copyWith(fontFamily: 'Tajawal'),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8.0),
                _buildMessageContainer(context, S.of(context).DevMassage),
                const SizedBox(height: 4.0),
                _buildProfileRow(context, S.of(context).DevThx),
                const SizedBox(height: 4.0),
                _buildSupportButton(context),
                const SizedBox(height: 4.0),
                _buildSocialMediaMessage(context),
              ],
            ),
          ),
          _buildCloseButton(context),
        ],
      ),
    );
  }

  Widget _buildMessageContainer(BuildContext context, String message) {
    return Row(
      children: [
        SizedBox(width: 0.172.sw),
        Expanded(
          child: _MessageBox(message: message),
        ),
      ],
    );
  }

  Widget _buildProfileRow(BuildContext context, String message) {
    return Row(
      children: [
        buildAvatar(context),
        const SizedBox(width: 8.0),
        Expanded(
          child: _MessageBox(message: message),
        ),
      ],
    );
  }

  Widget buildAvatar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/MHlogo.png',
        width: 0.15.sw,
        height: 0.15.sw,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSupportButton(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primaryContainer,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.volunteer_activism_outlined,
                size: SenseiConst.iconSize.sp,
                color: theme.colorScheme.onPrimaryContainer,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  S.of(context).DevDonate,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaMessage(BuildContext context) {
    return Row(
      children: [
        buildAvatar(context),
        const SizedBox(width: 8.0),
        Expanded(
          child: _buildSocialMediaContent(context),
        ),
      ],
    );
  }

  Widget _buildSocialMediaContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).ContactDevMassage,
            style: _getMessageStyle(context),
          ),
          _SocialMediaRow(socialLinks: _socialLinks),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SenseiConst.outBorderRadius.r),
            )),
          ),
          child: Text(S.of(context).close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  TextStyle _getMessageStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Tajawal',
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}

class _MessageBox extends StatelessWidget {
  const _MessageBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Text(
        message,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'Tajawal',
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _SocialMediaRow extends StatelessWidget {
  const _SocialMediaRow({required this.socialLinks});

  final List<_SocialLink> socialLinks;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: socialLinks
          .map((link) => _SocialButton(
                icon: link.icon,
                url: link.url,
                color: link.color,
              ))
          .toList(),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.url,
    required this.color,
  });

  final IconData icon;
  final String url;
  final Color color;

  Future<void> _launchURL() async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon),
      iconSize: 25.0,
      color: color,
      onPressed: _launchURL,
    );
  }
}

class _SocialLink {
  const _SocialLink({
    required this.url,
    required this.icon,
    required this.color,
  });

  final String url;
  final IconData icon;
  final Color color;
}
