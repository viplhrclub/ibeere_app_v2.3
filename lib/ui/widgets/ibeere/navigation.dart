// lib/ui/widgets/ibeere/navigation.dart
// Ibeere 2.0 Design System - Navigation & Tab Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Custom Bottom Navigation Bar
class IbeereBottomNavBar extends StatefulWidget {
  const IbeereBottomNavBar({
    required this.items,
    super.key,
    this.onTap,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.showBorder = true,
  });
  final List<IbeereNavItem> items;
  final ValueChanged<int>? onTap;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool showLabels;
  final bool showBorder;

  @override
  State<IbeereBottomNavBar> createState() => _IbeereBottomNavBarState();
}

class _IbeereBottomNavBarState extends State<IbeereBottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? IbeereColors.white,
        border: widget.showBorder
            ? const Border(
                top: BorderSide(
                  color: IbeereColors.divider,
                ),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: IbeereColors.shadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: IbeereSpacing.paddingVerticalMd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              widget.items.length,
              (index) {
                final item = widget.items[index];
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onTap?.call(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color: isSelected
                            ? (widget.selectedColor ?? IbeereColors.primary)
                            : (widget.unselectedColor ?? IbeereColors.gray600),
                        size: 24,
                      ),
                      if (widget.showLabels) ...[
                        IbeereSpacing.verticalGapXs,
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: isSelected
                                    ? (widget.selectedColor ??
                                          IbeereColors.primary)
                                    : (widget.unselectedColor ??
                                          IbeereColors.gray600),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                        ),
                      ],
                      if (item.badge != null && item.badge! > 0) ...[
                        Positioned(
                          right: -8,
                          top: -8,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: IbeereColors.error,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '${item.badge}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: IbeereColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Navigation Item Model
class IbeereNavItem {
  IbeereNavItem({
    required this.label,
    required this.icon,
    this.badge,
  });
  final String label;
  final IconData icon;
  final int? badge;
}

/// Custom Tab Bar
class IbeereTabBar extends StatefulWidget implements PreferredSizeWidget {
  const IbeereTabBar({
    required this.tabs,
    super.key,
    this.onTabChanged,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.isScrollable = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.selectedTextStyle,
    this.unselectedTextStyle,
  });
  final List<String> tabs;
  final ValueChanged<int>? onTabChanged;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool isScrollable;
  final EdgeInsets padding;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  State<IbeereTabBar> createState() => _IbeereTabBarState();
}

class _IbeereTabBarState extends State<IbeereTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor ?? IbeereColors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: widget.padding,
        child: Row(
          children: List.generate(
            widget.tabs.length,
            (index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onTabChanged?.call(index);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index < widget.tabs.length - 1 ? 24 : 0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.tabs[index],
                        style:
                            (isSelected
                                ? widget.selectedTextStyle
                                : widget.unselectedTextStyle) ??
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: isSelected
                                  ? (widget.selectedColor ??
                                        IbeereColors.primary)
                                  : (widget.unselectedColor ??
                                        IbeereColors.gray600),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                      ),
                      IbeereSpacing.verticalGapXs,
                      if (isSelected)
                        Container(
                          height: 3,
                          width: 24,
                          decoration: BoxDecoration(
                            color: widget.selectedColor ?? IbeereColors.primary,
                            borderRadius: IbeereBorderRadius.radiusXs,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

/// Segmented Control (Toggle between options)
class IbeereSegmentedControl<T> extends StatefulWidget {
  const IbeereSegmentedControl({
    required this.options,
    required this.selectedValue,
    super.key,
    this.onChanged,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.width,
  });
  final List<IbeereSegmentOption<T>> options;
  final T selectedValue;
  final ValueChanged<T>? onChanged;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? width;

  @override
  State<IbeereSegmentedControl<T>> createState() =>
      _IbeereSegmentedControlState<T>();
}

class _IbeereSegmentedControlState<T> extends State<IbeereSegmentedControl<T>> {
  late T _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: IbeereSpacing.paddingSm,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? IbeereColors.gray100,
        borderRadius: IbeereBorderRadius.radiusMd,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.options.length,
          (index) {
            final option = widget.options[index];
            final isSelected = _selectedValue == option.value;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedValue = option.value;
                  });
                  widget.onChanged?.call(option.value);
                },
                child: Container(
                  padding: IbeereSpacing.paddingVerticalSm,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (widget.selectedColor ?? IbeereColors.primary)
                        : Colors.transparent,
                    borderRadius: IbeereBorderRadius.radiusSm,
                  ),
                  child: Text(
                    option.label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? (widget.unselectedColor ?? IbeereColors.white)
                          : (widget.unselectedColor ?? IbeereColors.gray600),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Segmented Control Option Model
class IbeereSegmentOption<T> {
  IbeereSegmentOption({
    required this.label,
    required this.value,
  });
  final String label;
  final T value;
}

/// Breadcrumb Navigation
class IbeereBreadcrumb extends StatelessWidget {
  const IbeereBreadcrumb({
    required this.items,
    super.key,
    this.separatorColor,
    this.textColor,
    this.activeColor,
  });
  final List<IbeereBreadcrumbItem> items;
  final Color? separatorColor;
  final Color? textColor;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            final isLast = index == items.length - 1;
            return Row(
              children: [
                GestureDetector(
                  onTap: isLast ? null : item.onTap,
                  child: Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isLast
                          ? (activeColor ?? IbeereColors.primary)
                          : (textColor ?? IbeereColors.gray600),
                      fontWeight: isLast ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                if (!isLast) ...[
                  IbeereSpacing.horizontalGapSm,
                  Icon(
                    Icons.chevron_right,
                    color: separatorColor ?? IbeereColors.gray400,
                    size: 18,
                  ),
                  IbeereSpacing.horizontalGapSm,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Breadcrumb Item Model
class IbeereBreadcrumbItem {
  IbeereBreadcrumbItem({
    required this.label,
    this.onTap,
  });
  final String label;
  final VoidCallback? onTap;
}

