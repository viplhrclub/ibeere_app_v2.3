import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class IbeereButton extends StatelessWidget {
  const IbeereButton({
    required this.text,
    required this.onPressed,
    this.variant = IbeereButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = true,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final IbeereButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getForegroundColor(),
      elevation: 0,
      shadowColor: _getShadowColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(IbeereDesignTokens.borderRadiusButton),
        side: variant == IbeereButtonVariant.outlined
            ? const BorderSide(color: Color(0xFFE2E8F0), width: 2)
            : BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    ).copyWith(
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) return 0;
        if (states.contains(WidgetState.disabled)) return 0;
        return variant == IbeereButtonVariant.outlined ? 0 : 4;
      }),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case IbeereButtonVariant.primary:
        return IbeereDesignTokens.primaryRed;
      case IbeereButtonVariant.secondary:
        return IbeereDesignTokens.primaryPurple;
      case IbeereButtonVariant.outlined:
        return Colors.transparent;
      case IbeereButtonVariant.white:
        return Colors.white;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case IbeereButtonVariant.primary:
      case IbeereButtonVariant.secondary:
        return Colors.white;
      case IbeereButtonVariant.outlined:
      case IbeereButtonVariant.white:
        return IbeereDesignTokens.textPrimary;
    }
  }

  Color _getShadowColor() {
    switch (variant) {
      case IbeereButtonVariant.primary:
        return IbeereDesignTokens.primaryRed.withOpacity(0.3);
      case IbeereButtonVariant.secondary:
        return IbeereDesignTokens.primaryPurple.withOpacity(0.3);
      case IbeereButtonVariant.outlined:
      case IbeereButtonVariant.white:
        return Colors.black.withOpacity(0.1);
    }
  }
}

enum IbeereButtonVariant { primary, secondary, outlined, white }

class IbeereSocialButton extends StatelessWidget {
  const IbeereSocialButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final SocialProvider provider;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: IbeereDesignTokens.textPrimary,
          elevation: 0,
          shadowColor: Colors.black.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getIconPath(),
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              _getLabel(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getIconPath() {
    switch (provider) {
      case SocialProvider.google:
        return 'assets/images/google_icon.svg';
      case SocialProvider.apple:
        return 'assets/images/appleicon.svg';
    }
  }

  String _getLabel() {
    switch (provider) {
      case SocialProvider.google:
        return 'Continue with Google';
      case SocialProvider.apple:
        return 'Continue with Apple';
    }
  }
}

enum SocialProvider { google, apple }

class IbeereFloatingActionButton extends StatelessWidget {
  const IbeereFloatingActionButton({
    required this.onPressed,
    this.icon = Icons.play_arrow_rounded,
    super.key,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: IbeereDesignTokens.primaryRed.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildDecorativeCircle(12, const Offset(-8, -8)),
          _buildDecorativeCircle(8, const Offset(10, -6)),
          _buildDecorativeCircle(6, const Offset(8, 10)),
          _buildDecorativeCircle(10, const Offset(-10, 8)),
          FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: IbeereDesignTokens.primaryRed,
            elevation: 0,
            child: Icon(
              icon,
              size: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircle(double size, Offset offset) {
    return Positioned(
      left: 32 + offset.dx,
      top: 32 + offset.dy,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
