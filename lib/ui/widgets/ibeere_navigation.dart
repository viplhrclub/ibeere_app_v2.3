import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

/// Custom AppBar for Ibeere 2.0
/// 
/// Styled app bar with Ibeere design system
class IbeereAppBar extends StatelessWidget implements PreferredSizeWidget {

  const IbeereAppBar({
    required this.title, super.key,
    this.centerTitle = false,
    this.actions,
    this.leading,
    this.onLeadingPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.elevation = 0,
    this.showBackButton = true,
  });
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final VoidCallback? onLeadingPressed;
  final Color backgroundColor;
  final Color textColor;
  final double elevation;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: DesignTokens.fontSizeLg,
          fontWeight: DesignTokens.fontWeightSemibold,
          color: textColor,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: leading ??
          (showBackButton
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: textColor),
                  onPressed: onLeadingPressed ?? () => Navigator.pop(context),
                )
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(DesignTokens.appBarHeight);
}

/// Tab Bar for Ibeere 2.0
/// 
/// Custom styled tab bar
class IbeereTabBar extends StatelessWidget {

  const IbeereTabBar({
    required this.tabs, super.key,
    this.controller,
    this.onTap,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
  });
  final List<String> tabs;
  final TabController? controller;
  final void Function(int)? onTap;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      onTap: onTap,
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      indicatorColor: indicatorColor ?? DesignTokens.primary,
      labelColor: labelColor ?? DesignTokens.primary,
      unselectedLabelColor: unselectedLabelColor ?? Colors.grey[600],
      labelStyle: const TextStyle(
        fontSize: DesignTokens.fontSizeBase,
        fontWeight: DesignTokens.fontWeightSemibold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: DesignTokens.fontSizeBase,
        fontWeight: DesignTokens.fontWeightNormal,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 3,
    );
  }
}

/// Bottom Navigation Bar for Ibeere 2.0
/// 
/// Custom bottom navigation with active/inactive states
class IbeereBottomNavigation extends StatelessWidget {

  const IbeereBottomNavigation({
    required this.currentIndex, required this.items, super.key,
    this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });
  final int currentIndex;
  final void Function(int)? onTap;
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
      backgroundColor: backgroundColor ?? DesignTokens.surface,
      selectedItemColor: selectedItemColor ?? DesignTokens.primary,
      unselectedItemColor: unselectedItemColor ?? Colors.grey[400],
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(
        fontSize: DesignTokens.fontSizeSm,
        fontWeight: DesignTokens.fontWeightSemibold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: DesignTokens.fontSizeSm,
        fontWeight: DesignTokens.fontWeightNormal,
      ),
    );
  }
}

/// Chip/Tag for Ibeere 2.0
/// 
/// Reusable chip component with optional delete action
class IbeereChip extends StatelessWidget {

  const IbeereChip({
    required this.label, super.key,
    this.icon,
    this.onTap,
    this.onDelete,
    this.backgroundColor,
    this.labelColor,
    this.isSelected = false,
  });
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spaceMd,
          vertical: DesignTokens.spaceSm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? backgroundColor ?? DesignTokens.primary
              : backgroundColor ?? DesignTokens.background,
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
          border: Border.all(
            color: isSelected
                ? (backgroundColor ?? DesignTokens.primary)
                : (backgroundColor ?? DesignTokens.primary)
                    .withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: DesignTokens.iconSizeSmall,
                color: labelColor ?? (isSelected ? Colors.white : DesignTokens.primary),
              ),
              const SizedBox(width: DesignTokens.spaceSm),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm,
                fontWeight: DesignTokens.fontWeightMedium,
                color: labelColor ?? (isSelected ? Colors.white : DesignTokens.primary),
              ),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: DesignTokens.spaceSm),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: DesignTokens.iconSizeSmall,
                  color: labelColor ?? (isSelected ? Colors.white : DesignTokens.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Badge for Ibeere 2.0
/// 
/// Small badge for notifications and counts
class IbeereBadge extends StatelessWidget {

  const IbeereBadge({
    required this.label, super.key,
    this.backgroundColor,
    this.textColor,
    this.size = 20.0,
  });
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? DesignTokens.error,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: DesignTokens.fontSizeXs,
          fontWeight: DesignTokens.fontWeightBold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Divider for Ibeere 2.0
/// 
/// Custom divider line
class IbeereDivider extends StatelessWidget {

  const IbeereDivider({
    super.key,
    this.height = 1.0,
    this.color,
    this.thickness = 1.0,
  });
  final double height;
  final Color? color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color ?? Colors.grey[300],
      thickness: thickness,
    );
  }
}

