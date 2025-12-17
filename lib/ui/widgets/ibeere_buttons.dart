import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

/// Primary Elevated Button for Ibeere 2.0
/// 
/// Used for main call-to-action buttons
class IbeerePrimaryButton extends StatefulWidget {

  const IbeerePrimaryButton({
    required this.label, required this.onPressed, super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height = 48.0,
    this.icon,
    this.isFullWidth = false,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double height;
  final IconData? icon;
  final bool isFullWidth;

  @override
  State<IbeerePrimaryButton> createState() => _IbeerePrimaryButtonState();
}

class _IbeerePrimaryButtonState extends State<IbeerePrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isFullWidth ? double.infinity : widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007AFF),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF007AFF).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withValues(alpha: 0.5),
                  ),
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Secondary Outlined Button for Ibeere 2.0
/// 
/// Used for secondary actions and alternative choices
class IbeereSecondaryButton extends StatelessWidget {

  const IbeereSecondaryButton({
    required this.label, required this.onPressed, super.key,
    this.isEnabled = true,
    this.width,
    this.height = 48.0,
    this.icon,
    this.isFullWidth = false,
    this.borderColor,
    this.textColor,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double? width;
  final double height;
  final IconData? icon;
  final bool isFullWidth;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: borderColor ?? const Color(0xFF007AFF),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: textColor ?? const Color(0xFF007AFF)),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? const Color(0xFF007AFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Text Button (Ghost Button) for Ibeere 2.0
/// 
/// Used for tertiary actions with minimal visual weight
class IbeereTextButton extends StatelessWidget {

  const IbeereTextButton({
    required this.label, required this.onPressed, super.key,
    this.isEnabled = true,
    this.textColor,
    this.icon,
  });
  final String label;
  final VoidCallback onPressed;
  final bool isEnabled;
  final Color? textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: textColor ?? DesignTokens.primary),
            const SizedBox(width: DesignTokens.spaceSm),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              fontWeight: DesignTokens.fontWeightSemibold,
              color: textColor ?? DesignTokens.primary,
            ),
          ),
        ],
      ),
    );
  }
}

