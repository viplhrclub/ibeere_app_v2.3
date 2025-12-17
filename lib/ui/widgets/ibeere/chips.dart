// lib/ui/widgets/ibeere/chips.dart
// Ibeere 2.0 Design System - Chip/Tag Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Basic Chip Component
class IbeereChip extends StatelessWidget {
  const IbeereChip({
    required this.label,
    super.key,
    this.onTap,
    this.onDelete,
    this.icon,
    this.backgroundColor,
    this.labelColor,
    this.borderColor,
    this.fontSize,
  });
  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? borderColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: IbeereSpacing.paddingHorizontalLg,
      decoration: BoxDecoration(
        color: backgroundColor ?? IbeereColors.gray100,
        borderRadius: IbeereBorderRadius.radiusLg,
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: labelColor ?? IbeereColors.gray900,
              ),
              IbeereSpacing.horizontalGapXs,
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: labelColor ?? IbeereColors.gray900,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (onDelete != null) ...[
              IbeereSpacing.horizontalGapXs,
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: labelColor ?? IbeereColors.gray900,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Selectable Filter Chip
class IbeereFilterChip extends StatefulWidget {
  const IbeereFilterChip({
    required this.label,
    super.key,
    this.isSelected = false,
    this.onSelected,
    this.icon,
    this.selectedColor,
    this.unselectedColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
  });
  final String label;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final IconData? icon;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;

  @override
  State<IbeereFilterChip> createState() => _IbeereFilterChipState();
}

class _IbeereFilterChipState extends State<IbeereFilterChip> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onSelected?.call(_isSelected);
      },
      child: Container(
        padding: IbeereSpacing.paddingHorizontalLg,
        decoration: BoxDecoration(
          color: _isSelected
              ? (widget.selectedColor ?? IbeereColors.primary)
              : (widget.unselectedColor ?? IbeereColors.gray100),
          borderRadius: IbeereBorderRadius.radiusLg,
          border: Border.all(
            color: _isSelected
                ? (widget.selectedColor ?? IbeereColors.primary)
                : IbeereColors.gray300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: 16,
                color: _isSelected
                    ? (widget.selectedLabelColor ?? IbeereColors.white)
                    : (widget.unselectedLabelColor ?? IbeereColors.gray900),
              ),
              IbeereSpacing.horizontalGapXs,
            ],
            Text(
              widget.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: _isSelected
                    ? (widget.selectedLabelColor ?? IbeereColors.white)
                    : (widget.unselectedLabelColor ?? IbeereColors.gray900),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category/Subject Chip with Badge
class IbeereCategoryChip extends StatelessWidget {
  const IbeereCategoryChip({
    required this.label,
    super.key,
    this.questionCount,
    this.onTap,
    this.backgroundColor,
    this.labelColor,
    this.isHighlighted = false,
  });
  final String label;
  final int? questionCount;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: IbeereSpacing.paddingHorizontalLg,
        decoration: BoxDecoration(
          color: isHighlighted
              ? (backgroundColor ?? IbeereColors.primary)
              : (backgroundColor ?? IbeereColors.gray100),
          borderRadius: IbeereBorderRadius.radiusLg,
          border: Border.all(
            color: isHighlighted
                ? (backgroundColor ?? IbeereColors.primary)
                : IbeereColors.gray300,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isHighlighted
                    ? (labelColor ?? IbeereColors.white)
                    : (labelColor ?? IbeereColors.gray900),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (questionCount != null) ...[
              IbeereSpacing.horizontalGapXs,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: IbeereSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? IbeereColors.white
                      : IbeereColors.primary,
                  borderRadius: IbeereBorderRadius.radiusXs,
                ),
                child: Text(
                  '$questionCount',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isHighlighted
                        ? IbeereColors.primary
                        : IbeereColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Difficulty Level Chip
class IbeereDifficultyChip extends StatelessWidget {
  const IbeereDifficultyChip({
    required this.label,
    required this.level,
    super.key,
    this.onTap,
  });
  final String label;
  final DifficultyLevel level;
  final VoidCallback? onTap;

  Color _getColor() {
    switch (level) {
      case DifficultyLevel.easy:
        return IbeereColors.success;
      case DifficultyLevel.medium:
        return IbeereColors.warning;
      case DifficultyLevel.hard:
        return IbeereColors.error;
    }
  }

  IconData _getIcon() {
    switch (level) {
      case DifficultyLevel.easy:
        return Icons.trending_down;
      case DifficultyLevel.medium:
        return Icons.trending_flat;
      case DifficultyLevel.hard:
        return Icons.trending_up;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: IbeereSpacing.paddingHorizontalLg,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: IbeereBorderRadius.radiusLg,
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              size: 16,
              color: color,
            ),
            IbeereSpacing.horizontalGapXs,
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Status Chip (for showing status badges)
class IbeereStatusChip extends StatelessWidget {
  const IbeereStatusChip({
    required this.label,
    required this.status,
    super.key,
    this.onTap,
  });
  final String label;
  final StatusType status;
  final VoidCallback? onTap;

  Color _getColor() {
    switch (status) {
      case StatusType.active:
        return IbeereColors.success;
      case StatusType.inactive:
        return IbeereColors.gray500;
      case StatusType.pending:
        return IbeereColors.warning;
      case StatusType.completed:
        return IbeereColors.primary;
      case StatusType.failed:
        return IbeereColors.error;
    }
  }

  IconData _getIcon() {
    switch (status) {
      case StatusType.active:
        return Icons.check_circle;
      case StatusType.inactive:
        return Icons.cancel;
      case StatusType.pending:
        return Icons.schedule;
      case StatusType.completed:
        return Icons.task_alt;
      case StatusType.failed:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: IbeereSpacing.paddingHorizontalLg,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: IbeereBorderRadius.radiusLg,
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              size: 16,
              color: color,
            ),
            IbeereSpacing.horizontalGapXs,
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DifficultyLevel { easy, medium, hard }

enum StatusType { active, inactive, pending, completed, failed }

