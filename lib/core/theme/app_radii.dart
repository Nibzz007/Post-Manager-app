import 'package:flutter/material.dart';

/// Border radius tokens. Align with Figma corner radius values.
abstract final class AppRadii {
  AppRadii._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double full = 9999;

  static BorderRadius get radiusXs => BorderRadius.circular(xs);
  static BorderRadius get radiusSm => BorderRadius.circular(sm);
  static BorderRadius get radiusMd => BorderRadius.circular(md);
  static BorderRadius get radiusLg => BorderRadius.circular(lg);
  static BorderRadius get radiusXl => BorderRadius.circular(xl);
  static BorderRadius get radiusFull => BorderRadius.circular(full);

  /// Buttons, chips, inputs
  static BorderRadius get button => radiusMd;
  /// Cards, sheets, dialogs
  static BorderRadius get card => radiusLg;
  /// Badges, tags, pills
  static BorderRadius get badge => radiusSm;
}
