import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class IbeereTextField extends StatelessWidget {
  const IbeereTextField({
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines == 1 ? 56 : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        enabled: enabled,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: IbeereDesignTokens.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: IbeereDesignTokens.textTertiary,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: IbeereDesignTokens.textSecondary,
                  size: 20,
                )
              : null,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: enabled
              ? const Color(0xFFF1F5F9)
              : const Color(0xFFF8FAFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: IbeereDesignTokens.primaryPurple,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: IbeereDesignTokens.primaryRed,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: IbeereDesignTokens.primaryRed,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class IbeereOTPField extends StatefulWidget {
  const IbeereOTPField({
    required this.length,
    required this.onCompleted,
    this.onChanged,
    super.key,
  });

  final int length;
  final Function(String) onCompleted;
  final Function(String)? onChanged;

  @override
  State<IbeereOTPField> createState() => _IbeereOTPFieldState();
}

class _IbeereOTPFieldState extends State<IbeereOTPField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            right: index < widget.length - 1 ? 8 : 0,
          ),
          child: _buildOTPBox(index),
        ),
      ),
    );
  }

  Widget _buildOTPBox(int index) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        obscureText: true,
        obscuringCharacter: '*',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: IbeereDesignTokens.textPrimary,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < widget.length - 1) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
              final otp = _controllers.map((c) => c.text).join();
              if (otp.length == widget.length) {
                widget.onCompleted(otp);
              }
            }
          }
          
          final otp = _controllers.map((c) => c.text).join();
          widget.onChanged?.call(otp);
        },
        onTap: () {
          if (_controllers[index].text.isNotEmpty) {
            _controllers[index].clear();
          }
        },
      ),
    );
  }
}

class IbeerePhoneField extends StatelessWidget {
  const IbeerePhoneField({
    required this.controller,
    required this.onCountryChanged,
    this.countryCode = '+229',
    this.countryFlag = '🇧🇯',
    super.key,
  });

  final TextEditingController controller;
  final Function(String) onCountryChanged;
  final String countryCode;
  final String countryFlag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    countryFlag,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    countryCode,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: IbeereDesignTokens.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: IbeereDesignTokens.textPrimary,
              ),
              decoration: const InputDecoration(
                hintText: '91952546',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: IbeereDesignTokens.textTertiary,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
