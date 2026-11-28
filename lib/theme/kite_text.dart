import 'package:flutter/material.dart';

/// Kite's typeface is Inter with tabular (fixed-width) figures — verified by
/// comparing word proportions in the Kite screenshots. The font is bundled in
/// assets/fonts (SIL OFL), so it works offline and in render tests.
const String kFontFamily = 'Inter';

TextStyle inter({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? letterSpacing,
  double? height,
}) {
  return TextStyle(
    fontFamily: kFontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
