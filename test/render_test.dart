// Render harness: draws every screen at the exact metrics of the reference
// phone (1080x2412 px, DPR 2.625, status bar 125px, system nav bar 62px,
// system font scale ~0.87) with the real Inter + Material icon fonts, and
// writes PNGs to test/renders/. CI pushes these to the `renders` branch so the
// UI can be compared numerically against the Kite screenshots.
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_app/main.dart';

const double kDpr = 2.625;
final double kFontScale = double.parse(
    const String.fromEnvironment('FONT_SCALE', defaultValue: '0.87'));

Future<void> _loadFonts() async {
  final manifest =
      json.decode(await rootBundle.loadString('FontManifest.json')) as List;
  var hasIcons = false;
  for (final entry in manifest) {
    final family = entry['family'] as String;
    if (family.contains('MaterialIcons')) hasIcons = true;
    final loader = FontLoader(family);
    for (final f in entry['fonts'] as List) {
      loader.addFont(rootBundle.load(f['asset'] as String));
    }
    await loader.load();
  }
  final iconFile = File('test/fonts/MaterialIcons-Regular.otf');
  if (!hasIcons && iconFile.existsSync()) {
    final loader = FontLoader('MaterialIcons')
      ..addFont(Future.value(ByteData.sublistView(iconFile.readAsBytesSync())));
    await loader.load();
  }
}

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 4; i++) {
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 250)));
    await tester.pump(const Duration(milliseconds: 50));
  }
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(_loadFonts);

  const screens = <String, List<int>>{
    'watchlist': [0, 0],
    'orders': [1, 0],
    'holdings': [2, 0],
    'positions': [2, 1],
    'ipo': [3, 0],
    'account': [4, 0],
  };

  Future<void> render(WidgetTester tester, String name, int index, int tab,
      double fontScale) async {
      // Flutter view excludes the 62px system nav bar; the status bar (125px)
      // is drawn over the app as on the real device.
      tester.view.physicalSize = const Size(1080, 2412 - 62);
      tester.view.devicePixelRatio = kDpr;
      tester.view.padding = const FakeViewPadding(top: 125);
      tester.view.viewPadding = const FakeViewPadding(top: 125);
      tester.platformDispatcher.textScaleFactorTestValue = fontScale;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final key = GlobalKey();
      await tester.pumpWidget(RepaintBoundary(
        key: key,
        child: MyApp(
          key: ValueKey(name),
          initialIndex: index,
          portfolioTab: tab,
        ),
      ));
      await _settle(tester);
      // Capture at full device resolution (goldens would be 1x).
      final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(key));
      await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: kDpr);
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        final file = File('test/renders/$name.png')..createSync(recursive: true);
        file.writeAsBytesSync(png!.buffer.asUint8List());
      });
  }

  for (final e in screens.entries) {
    testWidgets('render ${e.key}', (tester) async {
      await render(tester, e.key, e.value[0], e.value[1], kFontScale);
    });
  }

  // Calibration: same screens at several system font scales, to find the one
  // that reproduces the real device screenshot.
  for (final fs in [0.80, 0.85, 0.90, 1.00]) {
    for (final e in {'watchlist': [0, 0], 'holdings': [2, 0]}.entries) {
      final tag = (fs * 100).round().toString().padLeft(3, '0');
      testWidgets('calibrate ${e.key} @$fs', (tester) async {
        await render(tester, 'cal_${e.key}_$tag', e.value[0], e.value[1], fs);
      });
    }
  }
}
