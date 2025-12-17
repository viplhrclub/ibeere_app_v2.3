import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

/// Standard Card Container for Ibeere 2.0
/// 
/// Elevated card with optional border, shadow, and tap feedback
class IbeereCard extends StatelessWidget {

  const IbeereCard({
    required this.child, super.key,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.borderColor,
    this.elevation = 0,
    this.onTap,
    this.enableTapFeedback = true,
  });
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final VoidCallback? onTap;
  final bool enableTapFeedback;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? DesignTokens.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        boxShadow: elevation != null && elevation! > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: elevation! * 2,
                  offset: Offset(0, elevation! * 0.5),
                ),
              ]
            : [],
      ),
      child: child,
    );

    if (onTap != null && enableTapFeedback) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: content,
        ),
      );
    }

    return content;
  }
}

/// Quiz Category Card for Ibeere 2.0
/// 
/// Specialized card for displaying quiz categories with icon and stats
class IbeereQuizCard extends StatelessWidget {

  const IbeereQuizCard({
    required this.title, required this.subtitle, required this.icon, required this.iconColor, required this.cardColor, super.key,
    this.statsText,
    this.onTap,
    this.height = 120.0,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color cardColor;
  final String? statsText;
  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IbeereCard(
        backgroundColor: cardColor,
        elevation: 2,
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSizeBase,
                            fontWeight: DesignTokens.fontWeightBold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: DesignTokens.spaceSm),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            fontWeight: DesignTokens.fontWeightNormal,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spaceMd),
                  Icon(
                    icon,
                    size: DesignTokens.iconSizeLarge,
                    color: iconColor,
                  ),
                ],
              ),
              if (statsText != null)
                Text(
                  statsText!,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    fontWeight: DesignTokens.fontWeightMedium,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// List Item Card for Ibeere 2.0
/// 
/// Used for displaying list items with optional leading and trailing widgets
class IbeereListCard extends StatelessWidget {

  const IbeereListCard({
    required this.title, super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.backgroundColor,
    this.borderRadius,
  });
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: backgroundColor ?? DesignTokens.surface,
      borderRadius: borderRadius?.topLeft.x ?? DesignTokens.radiusMd,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: DesignTokens.spaceMd),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      fontWeight: DesignTokens.fontWeightSemibold,
                      color: DesignTokens.primary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        fontWeight: DesignTokens.fontWeightNormal,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: DesignTokens.spaceMd),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Avatar Circle for Ibeere 2.0
/// 
/// User avatar with optional badge
class IbeereAvatar extends StatelessWidget {

  const IbeereAvatar({
    required this.initials, super.key,
    this.imageUrl,
    this.size = 48.0,
    this.backgroundColor = const Color(0xFF007AFF),
    this.badge,
  });
  final String? imageUrl;
  final String initials;
  final double size;
  final Color backgroundColor;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: backgroundColor,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null
              ? Text(
                  initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size / 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        if (badge != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: badge!,
          ),
      ],
    );
  }
}

