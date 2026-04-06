import 'package:flutter/material.dart';
import '../utils/constants.dart';

// ─────────────────────────────────────────────
//  UBIT LOGO
// ─────────────────────────────────────────────
class UbitLogo extends StatelessWidget {
  final bool lightMode;
  const UbitLogo({super.key, this.lightMode = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: lightMode ? Colors.white : AppColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              'U',
              style: TextStyle(
                color: lightMode ? AppColors.primary : Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'UBIT Hub',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: lightMode ? Colors.white : AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  FIELD LABEL
// ─────────────────────────────────────────────
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: AppTextStyles.label),
    );
  }
}

// ─────────────────────────────────────────────
//  PRIMARY BUTTON
// ─────────────────────────────────────────────
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          if (icon != null) ...[
            const SizedBox(width: 6),
            Icon(icon, size: 16),
          ]
        ],
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

// ─────────────────────────────────────────────
//  SECTION HEADER
// ─────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({super.key, required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        GestureDetector(
          onTap: onViewAll,
          child: const Text('View All', style: AppTextStyles.link),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  VERIFIED BADGE
// ─────────────────────────────────────────────
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_outlined, size: 13, color: Colors.white),
          SizedBox(width: 4),
          Text(
            'Verified Student',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CONDITION BADGE (for marketplace)
// ─────────────────────────────────────────────
class ConditionBadge extends StatelessWidget {
  final String condition;
  const ConditionBadge({super.key, required this.condition});

  Color get _bgColor {
    switch (condition) {
      case 'Like New':  return AppColors.successLight;
      case 'Good':      return AppColors.primaryLight;
      default:          return AppColors.warningLight;
    }
  }

  Color get _textColor {
    switch (condition) {
      case 'Like New':  return AppColors.success;
      case 'Good':      return AppColors.primary;
      default:          return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        condition,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: _textColor,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  FORM SECTION TITLE
// ─────────────────────────────────────────────
class FormSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const FormSectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  PROFILE FORM FIELD
// ─────────────────────────────────────────────
class ProfileFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;
  final String? Function(String?)? validator;

  const ProfileFormField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          style: const TextStyle(fontSize: 14, color: AppColors.textDark),
          decoration: appInputDecoration(
            hintText: hintText,
            readOnly: readOnly,
          ),
        ),
      ],
    );
  }
}
