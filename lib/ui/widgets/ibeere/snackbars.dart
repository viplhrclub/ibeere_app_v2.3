// lib/ui/widgets/ibeere/snackbars.dart
// Ibeere 2.0 Design System - Snackbar & Toast Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Custom Snackbar with Ibeere styling
class IbeereSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    VoidCallback? onDismissed,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            _getIconForType(type),
            color: _getColorForType(type),
            size: 24,
          ),
          IbeereSpacing.horizontalGapMd,
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: IbeereColors.white,
                  ),
            ),
          ),
        ],
      ),
      backgroundColor: _getBackgroundColorForType(type),
      duration: duration,
      action: action,
      shape: RoundedRectangleBorder(
        borderRadius: IbeereBorderRadius.radiusMd,
      ),
      margin: IbeereSpacing.paddingMd,
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      onVisible: () {},
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
  }) {
    return show(
      context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      onDismissed: onDismissed,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismissed,
  }) {
    return show(
      context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      onDismissed: onDismissed,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
  }) {
    return show(
      context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      onDismissed: onDismissed,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
  }) {
    return show(
      context,
      message: message,
      duration: duration,
      onDismissed: onDismissed,
    );
  }

  static IconData _getIconForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }

  static Color _getColorForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return IbeereColors.success;
      case SnackBarType.error:
        return IbeereColors.error;
      case SnackBarType.warning:
        return IbeereColors.warning;
      case SnackBarType.info:
        return IbeereColors.primary;
    }
  }

  static Color _getBackgroundColorForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return IbeereColors.success.withValues(alpha: 0.9);
      case SnackBarType.error:
        return IbeereColors.error.withValues(alpha: 0.9);
      case SnackBarType.warning:
        return IbeereColors.warning.withValues(alpha: 0.9);
      case SnackBarType.info:
        return IbeereColors.primary.withValues(alpha: 0.9);
    }
  }
}

/// Toast Overlay (for non-modal notifications)
class IbeereToast {
  static OverlayEntry? _overlayEntry;

  static void show(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    ToastType type = ToastType.info,
  }) {
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: position == ToastPosition.bottom ? 80 : null,
        top: position == ToastPosition.top ? 80 : null,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColorForType(type),
              borderRadius: IbeereBorderRadius.radiusMd,
              boxShadow: [
                BoxShadow(
                  color: IbeereColors.shadowColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: IbeereSpacing.paddingMd,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getIconForType(type),
                  color: IbeereColors.white,
                  size: 20,
                ),
                IbeereSpacing.horizontalGapMd,
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      type: ToastType.success,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: ToastType.error,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      type: ToastType.warning,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context,
      message: message,
      duration: duration,
    );
  }

  static IconData _getIconForType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }

  static Color _getBackgroundColorForType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return IbeereColors.success;
      case ToastType.error:
        return IbeereColors.error;
      case ToastType.warning:
        return IbeereColors.warning;
      case ToastType.info:
        return IbeereColors.primary;
    }
  }
}

enum SnackBarType { success, error, warning, info }
enum ToastType { success, error, warning, info }
enum ToastPosition { top, bottom }

