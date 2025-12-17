// lib/ui/widgets/ibeere/buttons.dart
// Ibeere 2.0 Design System - Button Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Primary Action Button (main CTA)
class IbeerePrimaryButton extends StatelessWidget {
  const IbeerePrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.padding,
    this.textStyle,
    this.icon,
    this.height,
    this.minWidth,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final bool isFullWidth;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Icon? icon;
  final double? height;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : minWidth,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: IbeereColors.primary,
          foregroundColor: IbeereColors.white,
          disabledBackgroundColor: IbeereColors.disabled,
          disabledForegroundColor: IbeereColors.gray400,
          padding: padding ?? IbeereSpacing.paddingSymmetricMedium,
          shape: RoundedRectangleBorder(
            borderRadius: IbeereBorderRadius.radiusMd,
          ),
          elevation: 2,
          shadowColor: IbeereColors.overlay,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isEnabled ? IbeereColors.white : IbeereColors.gray400,
                  ),
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    IbeereSpacing.horizontalGapMd,
                  ],
                  Text(
                    label,
                    style:
                        textStyle ??
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: IbeereColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Secondary Action Button (alternate CTA)
class IbeereSecondaryButton extends StatelessWidget {
  const IbeereSecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.padding,
    this.textStyle,
    this.icon,
    this.height,
    this.minWidth,
    this.borderColor,
    this.backgroundColor,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final bool isFullWidth;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Icon? icon;
  final double? height;
  final double? minWidth;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : minWidth,
      height: height ?? 48,
      child: OutlinedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: IbeereColors.primary,
          backgroundColor: backgroundColor ?? IbeereColors.white,
          disabledForegroundColor: IbeereColors.gray400,
          padding: padding ?? IbeereSpacing.paddingSymmetricMedium,
          side: BorderSide(
            color: borderColor ?? IbeereColors.primary,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: IbeereBorderRadius.radiusMd,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    IbeereColors.primary,
                  ),
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    IbeereSpacing.horizontalGapMd,
                  ],
                  Text(
                    label,
                    style:
                        textStyle ??
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: IbeereColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Text-only Button (minimal style)
class IbeereTextButton extends StatelessWidget {
  const IbeereTextButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isEnabled = true,
    this.textStyle,
    this.textColor,
    this.icon,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isEnabled;
  final TextStyle? textStyle;
  final Color? textColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? IbeereColors.primary,
        padding: IbeereSpacing.paddingSymmetricSmall,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            IbeereSpacing.horizontalGapSm,
          ],
          Text(
            label,
            style:
                textStyle ??
                Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor ?? IbeereColors.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

/// Icon-only Button
class IbeereIconButton extends StatelessWidget {
  const IbeereIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.isEnabled = true,
    this.size = 48,
    this.color,
    this.backgroundColor,
    this.iconSize,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: backgroundColor ?? IbeereColors.gray100,
        shape: RoundedRectangleBorder(
          borderRadius: IbeereBorderRadius.radiusMd,
        ),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: IbeereBorderRadius.radiusMd,
          child: Center(
            child: Icon(
              icon,
              size: iconSize ?? 20,
              color: color ?? IbeereColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Floating Action Button (FAB)
class IbeereFAB extends StatelessWidget {
  const IbeereFAB({
    required this.icon,
    required this.onPressed,
    super.key,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.size,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? IbeereColors.primary,
      foregroundColor: foregroundColor ?? IbeereColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: IbeereBorderRadius.radiusFull,
      ),
      elevation: 4,
      child: Icon(icon),
    );
  }
}

