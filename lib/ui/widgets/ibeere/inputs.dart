// lib/ui/widgets/ibeere/inputs.dart
// Ibeere 2.0 Design System - Input Components

import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere/colors.dart';
import 'package:flutterquiz/ui/widgets/ibeere/spacing.dart';

/// Base Text Field Component
class IbeereTextField extends StatefulWidget {

  const IbeereTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.counterText,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final String? counterText;

  @override
  State<IbeereTextField> createState() => _IbeereTextFieldState();
}

class _IbeereTextFieldState extends State<IbeereTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocus);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocus);
    }
    super.dispose();
  }

  void _handleFocus() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: IbeereColors.gray900,
                  fontWeight: FontWeight.w600,
                ),
          ),
          IbeereSpacing.verticalGapXs,
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: IbeereBorderRadius.radiusMd,
            border: Border.all(
              color: widget.errorText != null
                  ? IbeereColors.error
                  : _isFocused
                      ? IbeereColors.primary
                      : IbeereColors.gray300,
              width: _isFocused ? 2 : 1,
            ),
            color: widget.enabled
                ? IbeereColors.white
                : IbeereColors.gray100,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            textCapitalization: widget.textCapitalization,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: IbeereColors.gray400,
                  ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: IbeereSpacing.paddingMd,
                      child: widget.prefixIcon,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: IbeereSpacing.paddingMd,
                      child: widget.suffixIcon,
                    )
                  : null,
              counterText: widget.counterText ?? (widget.maxLength != null ? '' : null),
              contentPadding: IbeereSpacing.paddingMd.copyWith(
                left: widget.prefixIcon != null
                    ? IbeereSpacing.sm
                    : IbeereSpacing.md,
                right: widget.suffixIcon != null
                    ? IbeereSpacing.sm
                    : IbeereSpacing.md,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: IbeereColors.gray900,
                ),
          ),
        ),
        if (widget.errorText != null) ...[
          IbeereSpacing.verticalGapXs,
          Text(
            widget.errorText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: IbeereColors.error,
                ),
          ),
        ] else if (widget.helperText != null) ...[
          IbeereSpacing.verticalGapXs,
          Text(
            widget.helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: IbeereColors.gray600,
                ),
          ),
        ],
      ],
    );
  }
}

/// Password/Hidden Text Field
class IbeerePasswordField extends StatefulWidget {

  const IbeerePasswordField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
  });
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;

  @override
  State<IbeerePasswordField> createState() => _IbeerePasswordFieldState();
}

class _IbeerePasswordFieldState extends State<IbeerePasswordField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return IbeereTextField(
      controller: widget.controller,
      labelText: widget.labelText ?? 'Password',
      hintText: widget.hintText,
      helperText: widget.helperText,
      errorText: widget.errorText,
      obscureText: !_isVisible,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _isVisible = !_isVisible;
          });
        },
        child: Icon(
          _isVisible ? Icons.visibility : Icons.visibility_off,
          color: IbeereColors.gray600,
          size: 20,
        ),
      ),
    );
  }
}

/// Phone Number Field with formatting
class IbeerePhoneField extends StatelessWidget {

  const IbeerePhoneField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.focusNode,
    this.countryCode = '+1',
  });
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final String countryCode;

  @override
  Widget build(BuildContext context) {
    return IbeereTextField(
      controller: controller,
      labelText: labelText ?? 'Phone Number',
      hintText: hintText ?? '(555) 123-4567',
      errorText: errorText,
      keyboardType: TextInputType.phone,
      onChanged: onChanged,
      focusNode: focusNode,
      prefixIcon: Text(
        countryCode,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: IbeereColors.gray900,
            ),
      ),
    );
  }
}

/// Email Field with validation
class IbeereEmailField extends StatelessWidget {

  const IbeereEmailField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.focusNode,
  });
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return IbeereTextField(
      controller: controller,
      labelText: labelText ?? 'Email Address',
      hintText: hintText ?? 'you@example.com',
      errorText: errorText,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      focusNode: focusNode,
      prefixIcon: const Icon(
        Icons.email_outlined,
        color: IbeereColors.gray600,
        size: 20,
      ),
    );
  }
}

/// Search Field
class IbeereSearchField extends StatefulWidget {

  const IbeereSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.hintText,
    this.autoFocus = false,
  });
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final String? hintText;
  final bool autoFocus;

  @override
  State<IbeereSearchField> createState() => _IbeereSearchFieldState();
}

class _IbeereSearchFieldState extends State<IbeereSearchField> {
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
    return IbeereTextField(
      controller: _controller,
      hintText: widget.hintText ?? 'Search...',
      onChanged: (value) {
        setState(() {});
        widget.onChanged?.call(value);
      },
      prefixIcon: const Icon(
        Icons.search,
        color: IbeereColors.gray600,
        size: 20,
      ),
      suffixIcon: _controller.text.isNotEmpty
          ? GestureDetector(
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
            )
          : null,
    );
  }
}

