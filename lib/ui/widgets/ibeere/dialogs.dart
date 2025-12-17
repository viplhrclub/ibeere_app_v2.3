// lib/ui/widgets/ibeere/dialogs.dart
// Ibeere 2.0 Design System - Dialog & Modal Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Base Alert Dialog
class IbeereAlertDialog extends StatelessWidget {
  const IbeereAlertDialog({
    required this.title,
    required this.message,
    this.positiveButtonText,
    this.negativeButtonText,
    this.onPositivePressed,
    this.onNegativePressed,
    this.icon,
    this.iconColor,
    this.isDismissible = true,
    super.key,
  });
  final String title;
  final String message;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;
  final IconData? icon;
  final Color? iconColor;
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: IbeereColors.white,
          borderRadius: IbeereBorderRadius.radiusLg,
        ),
        padding: IbeereSpacing.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: IbeereSpacing.paddingMd,
                decoration: BoxDecoration(
                  color: (iconColor ?? IbeereColors.primary).withValues(
                    alpha: 0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? IbeereColors.primary,
                  size: 32,
                ),
              ),
              IbeereSpacing.verticalGapMd,
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: IbeereColors.gray900,
              ),
              textAlign: TextAlign.center,
            ),
            IbeereSpacing.verticalGapMd,
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IbeereColors.gray600,
              ),
              textAlign: TextAlign.center,
            ),
            IbeereSpacing.verticalGapLg,
            Row(
              children: [
                if (negativeButtonText != null) ...[
                  Expanded(
                    child: IbeereSecondaryButton(
                      label: negativeButtonText!,
                      onPressed: () {
                        Navigator.of(context).pop();
                        onNegativePressed?.call();
                      },
                    ),
                  ),
                  IbeereSpacing.horizontalGapMd,
                ],
                Expanded(
                  child: IbeerePrimaryButton(
                    label: positiveButtonText ?? 'OK',
                    onPressed: () {
                      Navigator.of(context).pop();
                      onPositivePressed?.call();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Confirmation Dialog (with specific action)
class IbeereConfirmDialog extends StatelessWidget {
  const IbeereConfirmDialog({
    required this.title,
    required this.message,
    required this.actionText,
    required this.onConfirm,
    this.cancelText = 'Cancel',
    this.onCancel,
    this.icon,
    this.actionColor,
    this.isDangerous = false,
    super.key,
  });
  final String title;
  final String message;
  final String actionText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final IconData? icon;
  final Color? actionColor;
  final bool isDangerous;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: IbeereColors.white,
          borderRadius: IbeereBorderRadius.radiusLg,
        ),
        padding: IbeereSpacing.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: IbeereSpacing.paddingMd,
                decoration: BoxDecoration(
                  color:
                      (actionColor ??
                              (isDangerous
                                  ? IbeereColors.error
                                  : IbeereColors.primary))
                          .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color:
                      actionColor ??
                      (isDangerous ? IbeereColors.error : IbeereColors.primary),
                  size: 32,
                ),
              ),
              IbeereSpacing.verticalGapMd,
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: IbeereColors.gray900,
              ),
              textAlign: TextAlign.center,
            ),
            IbeereSpacing.verticalGapMd,
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IbeereColors.gray600,
              ),
              textAlign: TextAlign.center,
            ),
            IbeereSpacing.verticalGapLg,
            Row(
              children: [
                Expanded(
                  child: IbeereSecondaryButton(
                    label: cancelText,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                  ),
                ),
                IbeereSpacing.horizontalGapMd,
                Expanded(
                  child: IbeerePrimaryButton(
                    label: actionText,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom Sheet Dialog
class IbeereBottomSheet extends StatelessWidget {
  const IbeereBottomSheet({
    required this.child,
    this.title,
    this.padding = const EdgeInsets.all(16),
    this.isDismissible = true,
    this.onDismissed,
    this.backgroundColor,
    this.maxHeight,
    super.key,
  });
  final String? title;
  final Widget child;
  final EdgeInsets padding;
  final bool isDismissible;
  final VoidCallback? onDismissed;
  final Color? backgroundColor;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? IbeereColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(IbeereBorderRadius.radiusLg.topLeft.x),
          topRight: Radius.circular(IbeereBorderRadius.radiusLg.topRight.x),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: IbeereSpacing.paddingVerticalMd,
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: IbeereColors.gray300,
                borderRadius: IbeereBorderRadius.radiusXs,
              ),
            ),
          ),
          if (title != null) ...[
            Padding(
              padding: padding.copyWith(bottom: 0),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: IbeereColors.gray900,
                ),
              ),
            ),
            IbeereSpacing.verticalGapMd,
          ],
          Flexible(
            child: SingleChildScrollView(
              padding: padding,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    double? maxHeight,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => IbeereBottomSheet(
        title: title,
        isDismissible: isDismissible,
        maxHeight: maxHeight,
        child: child,
      ),
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(IbeereBorderRadius.radiusLg.topLeft.x),
          topRight: Radius.circular(IbeereBorderRadius.radiusLg.topRight.x),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

/// Option List Dialog (choosing from options)
class IbeereOptionsDialog<T> extends StatelessWidget {
  const IbeereOptionsDialog({
    required this.title,
    required this.options,
    this.onSelected,
    this.selectedValue,
    this.allowMultiSelect = false,
    super.key,
  });
  final String title;
  final List<IbeereDialogOption<T>> options;
  final ValueChanged<T>? onSelected;
  final T? selectedValue;
  final bool allowMultiSelect;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: IbeereColors.white,
          borderRadius: IbeereBorderRadius.radiusLg,
        ),
        padding: IbeereSpacing.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: IbeereColors.gray900,
              ),
            ),
            IbeereSpacing.verticalGapMd,
            ...options.map((option) {
              final isSelected = selectedValue == option.value;
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      option.label,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: IbeereColors.gray900,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_circle,
                            color: IbeereColors.primary,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            color: IbeereColors.gray400,
                          ),
                    onTap: () {
                      Navigator.of(context).pop();
                      onSelected?.call(option.value);
                    },
                  ),
                  if (option != options.last)
                    const Divider(
                      color: IbeereColors.divider,
                      height: 1,
                    ),
                ],
              );
            }),
            IbeereSpacing.verticalGapMd,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: IbeereColors.gray600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog Option Model
class IbeereDialogOption<T> {
  IbeereDialogOption({
    required this.label,
    required this.value,
    this.icon,
  });
  final String label;
  final T value;
  final IconData? icon;
}

