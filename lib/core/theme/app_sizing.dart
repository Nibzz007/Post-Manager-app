/// Spacing, dimensions, and sizing tokens. Use for padding, margin, height, width.
/// Align with Figma spacing scale (e.g. 4pt grid).
abstract final class AppSizing {
  AppSizing._();

  // --- Spacing (padding / margin) ---
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 12;
  static const double spaceLg = 16;
  static const double spaceXl = 24;
  static const double space2xl = 32;
  static const double space3xl = 48;

  // --- Min touch target (accessibility) ---
  static const double minTouchTarget = 44;

  // --- Icon sizes ---
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 48;
  static const double iconEmpty = 64;

  // --- Button / control ---
  static const double buttonHeight = 48;
  static const double buttonPaddingH = 24;
  static const double buttonPaddingV = 12;

  // --- List / content ---
  static const double listItemGap = 12;
  static const double listPaddingH = 16;
  static const double listPaddingV = 8;
  static const double listPaddingBottom = 24;

  // --- App bar ---
  static const double appBarHeight = 56;
  static const double appBarTitleSize = 20;

  // --- Content width (for readability on tablet / web) ---
  static const double contentMaxWidth = 600;
}
