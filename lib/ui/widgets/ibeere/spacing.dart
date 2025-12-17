// lib/ui/widgets/ibeere/spacing.dart
// Ibeere 2.0 Design System - Spacing & Layout

import 'package:flutter/material.dart';

/// Spacing scale for consistent layouts
class IbeereSpacing {
  // Private constructor to prevent instantiation
  IbeereSpacing._();

  // Spacing scale (dp)
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  // Edge insets for common use cases
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingXxl = EdgeInsets.all(xxl);

  // Horizontal padding
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingHorizontalXl = EdgeInsets.symmetric(horizontal: xl);

  // Vertical padding
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets paddingVerticalXl = EdgeInsets.symmetric(vertical: xl);

  // Symmetrical padding (horizontal & vertical)
  static const EdgeInsets paddingSymmetricSmall = EdgeInsets.symmetric(horizontal: sm, vertical: xs);
  static const EdgeInsets paddingSymmetricMedium = EdgeInsets.symmetric(horizontal: lg, vertical: md);
  static const EdgeInsets paddingSymmetricLarge = EdgeInsets.symmetric(horizontal: xl, vertical: lg);

  // SizedBox helpers
  static const SizedBox gapXs = SizedBox(height: xs, width: xs);
  static const SizedBox gapSm = SizedBox(height: sm, width: sm);
  static const SizedBox gapMd = SizedBox(height: md, width: md);
  static const SizedBox gapLg = SizedBox(height: lg, width: lg);
  static const SizedBox gapXl = SizedBox(height: xl, width: xl);
  static const SizedBox gapXxl = SizedBox(height: xxl, width: xxl);

  // Vertical gaps
  static const SizedBox verticalGapXs = SizedBox(height: xs);
  static const SizedBox verticalGapSm = SizedBox(height: sm);
  static const SizedBox verticalGapMd = SizedBox(height: md);
  static const SizedBox verticalGapLg = SizedBox(height: lg);
  static const SizedBox verticalGapXl = SizedBox(height: xl);
  static const SizedBox verticalGapXxl = SizedBox(height: xxl);

  // Horizontal gaps
  static const SizedBox horizontalGapXs = SizedBox(width: xs);
  static const SizedBox horizontalGapSm = SizedBox(width: sm);
  static const SizedBox horizontalGapMd = SizedBox(width: md);
  static const SizedBox horizontalGapLg = SizedBox(width: lg);
  static const SizedBox horizontalGapXl = SizedBox(width: xl);
  static const SizedBox horizontalGapXxl = SizedBox(width: xxl);
}

/// Border radius definitions
class IbeereBorderRadius {
  // Private constructor to prevent instantiation
  IbeereBorderRadius._();

  static const double xs = 2;
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double full = 999;

  static final radiusXs = BorderRadius.circular(xs);
  static final radiusSm = BorderRadius.circular(sm);
  static final radiusMd = BorderRadius.circular(md);
  static final radiusLg = BorderRadius.circular(lg);
  static final radiusXl = BorderRadius.circular(xl);
  static final radiusFull = BorderRadius.circular(full);

  // Top only
  static const radiusTopMd = BorderRadius.only(
    topLeft: Radius.circular(md),
    topRight: Radius.circular(md),
  );

  static const radiusTopLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );

  // Bottom only
  static const radiusBottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(md),
    bottomRight: Radius.circular(md),
  );

  static const radiusBottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );
}

/// Shadow definitions
class IbeereShadows {
  // Private constructor to prevent instantiation
  IbeereShadows._();

  static const BoxShadow sm = BoxShadow(
    color: Color(0x0D000000),
    offset: Offset(0, 1),
    blurRadius: 2,
  );

  static const BoxShadow md = BoxShadow(
    color: Color(0x19000000),
    offset: Offset(0, 4),
    blurRadius: 6,
  );

  static const BoxShadow lg = BoxShadow(
    color: Color(0x19000000),
    offset: Offset(0, 10),
    blurRadius: 15,
  );

  static const BoxShadow xl = BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 20),
    blurRadius: 25,
  );

  static const List<BoxShadow> smList = [sm];
  static const List<BoxShadow> mdList = [md];
  static const List<BoxShadow> lgList = [lg];
  static const List<BoxShadow> xlList = [xl];
}

