import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

/// Custom Text Input Field for Ibeere 2.0
/// 
/// Text input with validation, prefix/suffix icons, and visual feedback
class IbeereTextInput extends StatefulWidget {

  const IbeereTextInput({
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.initialValue,
    this.isRequired = false,
  });
  final String? label;
  final String? hintText;
  final String? errorText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final String? initialValue;
  final bool isRequired;

  @override
  State<IbeereTextInput> createState() => _IbeereTextInputState();
}

class _IbeereTextInputState extends State<IbeereTextInput> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.label,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemibold,
                    color: DesignTokens.primary,
                  ),
                ),
                if (widget.isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: DesignTokens.error,
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spaceSm),
        ],
        TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          maxLines: _obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: widget.errorText != null
                    ? const Color(0xFFFF3B30)
                    : const Color(0xFFE5E7EB),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF007AFF),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFFF3B30),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: _focusNode.hasFocus
                        ? const Color(0xFF007AFF)
                        : const Color(0xFF9CA3AF),
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: widget.onSuffixTap,
                    child: Icon(
                      widget.suffixIcon,
                      color: const Color(0xFF9CA3AF),
                    ),
                  )
                : widget.obscureText
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[500],
                        ),
                      )
                    : null,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: DesignTokens.fontSizeBase,
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: DesignTokens.error,
              fontSize: DesignTokens.fontSizeSm,
              fontWeight: DesignTokens.fontWeightMedium,
            ),
          ),
        ],
      ],
    );
  }
}

/// Dropdown/Select Input for Ibeere 2.0
/// 
/// Custom dropdown with Ibeere styling
class IbeereDropdown<T> extends StatelessWidget {

  const IbeereDropdown({
    required this.value, required this.items, super.key,
    this.label,
    this.onChanged,
    this.hintText,
    this.icon,
    this.isRequired = false,
  });
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? hintText;
  final IconData? icon;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemibold,
                    color: DesignTokens.primary,
                  ),
                ),
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: DesignTokens.error,
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spaceSm),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[300] ?? Colors.grey),
          ),
          child: DropdownButton<T>(
            isExpanded: true,
            underline: const SizedBox.shrink(),
            value: value,
            hint: Text(
              hintText ?? 'Select an option',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: Colors.grey[500],
              ),
            ),
            items: items,
            onChanged: onChanged,
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spaceMd,
              vertical: DesignTokens.spaceSm,
            ),
          ),
        ),
      ],
    );
  }
}

/// Checkbox for Ibeere 2.0
/// 
/// Custom checkbox with label
class IbeereCheckbox extends StatelessWidget {

  const IbeereCheckbox({
    required this.value, super.key,
    this.onChanged,
    this.label,
    this.checkColor,
  });
  final bool value;
  final void Function(bool?)? onChanged;
  final String? label;
  final Color? checkColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: checkColor ?? DesignTokens.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
          ),
          if (label != null) ...[
            const SizedBox(width: DesignTokens.spaceSm),
            Expanded(
              child: Text(
                label!,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase,
                  fontWeight: DesignTokens.fontWeightNormal,
                  color: DesignTokens.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Radio Button for Ibeere 2.0
/// 
/// Custom radio button with label
class IbeereRadio<T> extends StatelessWidget {

  const IbeereRadio({
    required this.value, required this.groupValue, super.key,
    this.onChanged,
    this.label,
    this.activeColor,
  });
  final T value;
  final T? groupValue;
  final void Function(T?)? onChanged;
  final String? label;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: activeColor ?? DesignTokens.primary,
          ),
          if (label != null) ...[
            const SizedBox(width: DesignTokens.spaceSm),
            Expanded(
              child: Text(
                label!,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase,
                  fontWeight: DesignTokens.fontWeightNormal,
                  color: DesignTokens.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

