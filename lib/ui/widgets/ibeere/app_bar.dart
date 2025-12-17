// lib/ui/widgets/ibeere/app_bar.dart
// Ibeere 2.0 Design System - AppBar Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Base Ibeere AppBar
class IbeereAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IbeereAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.onBackPressed,
    this.showBackButton = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  });
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final EdgeInsets contentPadding;

  @override
  Size get preferredSize => Size.fromHeight(
    56 + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? IbeereColors.white,
      foregroundColor: foregroundColor ?? IbeereColors.gray900,
      elevation: elevation,
      scrolledUnderElevation: 0,
      centerTitle: false,
      bottom: bottom,
      titleSpacing: 0,
      title: Padding(
        padding: contentPadding,
        child: Row(
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                child: Container(
                  padding: IbeereSpacing.paddingSm,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: IbeereColors.gray900,
                    size: 20,
                  ),
                ),
              ),
            Expanded(
              child:
                  titleWidget ??
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: IbeereColors.gray900,
                    ),
                  ),
            ),
          ],
        ),
      ),
      actions: actions != null
          ? [
              Padding(
                padding: contentPadding.copyWith(left: 0),
                child: Row(
                  children: actions!,
                ),
              ),
            ]
          : null,
    );
  }
}

/// AppBar with Search Field
class IbeereAppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  const IbeereAppBarSearch({
    super.key,
    this.hintText,
    this.onChanged,
    this.onClear,
    this.onBackPressed,
    this.showBackButton = true,
    this.backgroundColor,
    this.controller,
  });
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final Color? backgroundColor;
  final TextEditingController? controller;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<IbeereAppBarSearch> createState() => _IbeereAppBarSearchState();
}

class _IbeereAppBarSearchState extends State<IbeereAppBarSearch> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: widget.backgroundColor ?? IbeereColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: IbeereSpacing.paddingMd,
        child: Row(
          children: [
            if (widget.showBackButton)
              GestureDetector(
                onTap:
                    widget.onBackPressed ?? () => Navigator.of(context).pop(),
                child: Container(
                  padding: IbeereSpacing.paddingSm,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: IbeereColors.gray900,
                    size: 20,
                  ),
                ),
              ),
            Expanded(
              child: Container(
                height: 40,
                padding: IbeereSpacing.paddingHorizontalMd,
                decoration: BoxDecoration(
                  color: IbeereColors.gray100,
                  borderRadius: IbeereBorderRadius.radiusMd,
                  border: Border.all(color: IbeereColors.gray300),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: IbeereColors.gray600,
                      size: 20,
                    ),
                    IbeereSpacing.horizontalGapSm,
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {});
                          widget.onChanged?.call(value);
                        },
                        decoration: InputDecoration(
                          hintText: widget.hintText ?? 'Search...',
                          hintStyle: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: IbeereColors.gray400,
                              ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: IbeereColors.gray900,
                        ),
                      ),
                    ),
                    if (_controller.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.clear();
                          });
                          widget.onClear?.call();
                        },
                        child: const Icon(
                          Icons.close,
                          color: IbeereColors.gray600,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// AppBar with Multiple Action Buttons
class IbeereAppBarMultiAction extends StatelessWidget
    implements PreferredSizeWidget {
  const IbeereAppBarMultiAction({
    required this.actions,
    super.key,
    this.title,
    this.titleWidget,
    this.onBackPressed,
    this.showBackButton = true,
    this.backgroundColor,
    this.foregroundColor,
    this.maxVisibleActions = 3,
  });
  final String? title;
  final Widget? titleWidget;
  final List<IbeereAppBarAction> actions;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final int maxVisibleActions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final visibleActions = actions.length <= maxVisibleActions
        ? actions
        : actions.sublist(0, maxVisibleActions - 1);
    final hasMoreMenu = actions.length > maxVisibleActions;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? IbeereColors.white,
      foregroundColor: foregroundColor ?? IbeereColors.gray900,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      title: Padding(
        padding: IbeereSpacing.paddingMd,
        child: Row(
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                child: Container(
                  padding: IbeereSpacing.paddingSm,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: IbeereColors.gray900,
                    size: 20,
                  ),
                ),
              ),
            Expanded(
              child:
                  titleWidget ??
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: IbeereColors.gray900,
                    ),
                  ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: IbeereSpacing.paddingHorizontalMd,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...visibleActions.asMap().entries.map((entry) {
                final action = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    left: entry.key > 0 ? IbeereSpacing.md : 0,
                  ),
                  child: GestureDetector(
                    onTap: action.onPressed,
                    child: Container(
                      padding: IbeereSpacing.paddingSm,
                      child: Icon(
                        action.icon,
                        color: action.color ?? IbeereColors.gray900,
                        size: 24,
                      ),
                    ),
                  ),
                );
              }),
              if (hasMoreMenu) ...[
                IbeereSpacing.horizontalGapMd,
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: IbeereColors.gray900,
                  ),
                  itemBuilder: (context) =>
                      actions.sublist(maxVisibleActions - 1).map((action) {
                        return PopupMenuItem<String>(
                          onTap: action.onPressed,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                action.icon,
                                color: action.color ?? IbeereColors.gray900,
                                size: 20,
                              ),
                              IbeereSpacing.horizontalGapMd,
                              Text(action.label ?? ''),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// AppBar Action Model
class IbeereAppBarAction {
  IbeereAppBarAction({
    required this.icon,
    required this.onPressed,
    this.color,
    this.label,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final String? label;
}

