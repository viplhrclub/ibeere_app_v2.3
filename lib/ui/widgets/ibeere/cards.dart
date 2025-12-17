// lib/ui/widgets/ibeere/cards.dart
// Ibeere 2.0 Design System - Card Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Base Elevated Card (used for most content)
class IbeereCard extends StatelessWidget {
  const IbeereCard({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.onTap,
    this.elevation,
    this.border,
    this.backgroundColor,
    this.borderRadius,
  });
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final double? elevation;
  final Border? border;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final finalBorderRadius =
        borderRadius as BorderRadius? ?? IbeereBorderRadius.radiusMd;
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        border: border ?? Border.all(color: IbeereColors.divider),
        borderRadius: finalBorderRadius,
      ),
      child: Material(
        color: backgroundColor ?? IbeereColors.cardBackground,
        elevation: elevation ?? 0,
        shadowColor: IbeereColors.shadowColor,
        borderRadius: finalBorderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: finalBorderRadius,
          child: Padding(
            padding: padding ?? IbeereSpacing.paddingMd,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Quiz Category Card (clickable category tile)
class IbeereQuizCategoryCard extends StatelessWidget {
  const IbeereQuizCategoryCard({
    required this.title,
    super.key,
    this.subtitle,
    this.icon,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
    this.isSelected = false,
    this.trailing,
  });
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      onTap: onTap,
      backgroundColor: backgroundColor ?? IbeereColors.cardBackground,
      border: isSelected
          ? Border.all(color: IbeereColors.primary, width: 2)
          : Border.all(color: IbeereColors.divider),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: IbeereSpacing.paddingMd,
              decoration: BoxDecoration(
                color: (iconColor ?? IbeereColors.primary).withValues(
                  alpha: 0.1,
                ),
                borderRadius: IbeereBorderRadius.radiusMd,
              ),
              child: Icon(
                icon,
                color: iconColor ?? IbeereColors.primary,
                size: 24,
              ),
            ),
            IbeereSpacing.horizontalGapMd,
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: IbeereColors.gray900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  IbeereSpacing.verticalGapXs,
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: IbeereColors.gray600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Quiz Option Card (for quiz options/answers)
class IbeereOptionCard extends StatelessWidget {
  const IbeereOptionCard({
    required this.label,
    super.key,
    this.isSelected = false,
    this.isCorrect = false,
    this.isIncorrect = false,
    this.onTap,
    this.index,
    this.selectedColor,
  });
  final String label;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final VoidCallback? onTap;
  final int? index;
  final Color? selectedColor;

  Color _getBackgroundColor() {
    if (isCorrect) return IbeereColors.success.withValues(alpha: 0.1);
    if (isIncorrect) return IbeereColors.error.withValues(alpha: 0.1);
    if (isSelected) {
      return (selectedColor ?? IbeereColors.primary).withValues(alpha: 0.1);
    }
    return IbeereColors.cardBackground;
  }

  Color _getBorderColor() {
    if (isCorrect) return IbeereColors.success;
    if (isIncorrect) return IbeereColors.error;
    if (isSelected) return selectedColor ?? IbeereColors.primary;
    return IbeereColors.divider;
  }

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      onTap: onTap,
      backgroundColor: _getBackgroundColor(),
      border: Border.all(
        color: _getBorderColor(),
        width: isSelected || isCorrect || isIncorrect ? 2 : 1,
      ),
      child: Row(
        children: [
          if (index != null) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getBorderColor(),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index!), // A, B, C, D
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: IbeereColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            IbeereSpacing.horizontalGapMd,
          ],
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: IbeereColors.gray900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isCorrect)
            const Icon(
              Icons.check_circle,
              color: IbeereColors.success,
            )
          else if (isIncorrect)
            const Icon(
              Icons.cancel,
              color: IbeereColors.error,
            ),
        ],
      ),
    );
  }
}

/// Stats Card (for displaying stats/metrics)
class IbeereStatsCard extends StatelessWidget {
  const IbeereStatsCard({
    required this.label,
    required this.value,
    super.key,
    this.icon,
    this.accentColor,
    this.onTap,
  });
  final String label;
  final String value;
  final IconData? icon;
  final Color? accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: IbeereColors.gray600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  color: accentColor ?? IbeereColors.primary,
                  size: 20,
                ),
            ],
          ),
          IbeereSpacing.verticalGapSm,
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: accentColor ?? IbeereColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reward/Badge Card
class IbeereBadgeCard extends StatelessWidget {
  const IbeereBadgeCard({
    required this.title,
    required this.description,
    required this.icon,
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
    this.isLocked = false,
  });
  final String title;
  final String description;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      onTap: isLocked ? null : onTap,
      backgroundColor: backgroundColor ?? IbeereColors.cardBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: IbeereSpacing.paddingLg,
            decoration: BoxDecoration(
              color: (iconColor ?? IbeereColors.primary).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isLocked
                  ? IbeereColors.gray400
                  : (iconColor ?? IbeereColors.primary),
              size: 32,
            ),
          ),
          IbeereSpacing.verticalGapMd,
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isLocked ? IbeereColors.gray400 : IbeereColors.gray900,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          IbeereSpacing.verticalGapXs,
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: IbeereColors.gray600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isLocked) ...[
            IbeereSpacing.verticalGapMd,
            const Icon(
              Icons.lock,
              color: IbeereColors.gray400,
              size: 20,
            ),
          ],
        ],
      ),
    );
  }
}

