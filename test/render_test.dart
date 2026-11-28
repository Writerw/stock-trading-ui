// Render harness: draws every screen at the exact metrics of the reference
// phone (1080x2412 px, DPR 2.625, status bar 125px, system nav bar 62px,
// system font scale ~0.87) with the real Inter + Material icon fonts, and
// writes PNGs to test/renders/. CI pushes these to the `renders` branch so the
// UI can be compared numerically against the Kite screenshots.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_app/main.dart';

const double kDpr = 2.625;
const double kFontScale =
    double.fromEnvironment('FONT_SCALE', defaultValue: 0.87);

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

  for (final e in screens.entries) {
    testWidgets('render ${e.key}', (tester) async {
      // Flutter view excludes the 62px system nav bar; the status bar (125px)
      // is drawn over the app as on the real device.
      tester.view.physicalSize = const Size(1080, 2412 - 62);
      tester.view.devicePixelRatio = kDpr;
      tester.view.padding = const FakeViewPadding(top: 125);
      tester.view.viewPadding = const FakeViewPadding(top: 125);
      tester.platformDispatcher.textScaleFactorTestValue = kFontScale;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final key = GlobalKey();
      await tester.pumpWidget(RepaintBoundary(
        key: key,
        child: MyApp(
          key: ValueKey(e.key),
          initialIndex: e.value[0],
          portfolioTab: e.value[1],
        ),
      ));
      await _settle(tester);
      await expectLater(find.byKey(key), matchesGoldenFile('renders/${e.key}.png'));
    });
  }
}
