import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class KiteTab {
  final String label;
  final int? badge; // count bubble, e.g. Open (6)
  final bool lock; // padlock icon, e.g. Major Indices
  const KiteTab(this.label, {this.badge, this.lock = false});
}

/// Horizontally scrollable tab row on the grey band, with a blue underline on
/// the selected tab. Each tab is wrapped in IntrinsicWidth so the underline has
/// a bounded width (a plain horizontal ListView gives items unbounded width,
/// which makes `width: infinity` fail to lay out and the tabs render blank).
class KiteTabs extends StatelessWidget {
  final List<KiteTab> tabs;
  final int selected;
  final ValueChanged<int> onSelect;
  final Widget? trailing; // e.g. the layers (+) button on the watchlist
  final bool centered; // center a small set of tabs (e.g. Portfolio)
  final double tabPadding;

  const KiteTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onSelect,
    this.trailing,
    this.centered = false,
    this.tabPadding = 12,
  });

  @override
  Widget build(BuildContext context) {
    final Widget inner;
    if (centered) {
      inner = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [for (int i = 0; i < tabs.length; i++) _tab(tabs[i], i)],
      );
    } else {
      inner = Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < tabs.length; i++) _tab(tabs[i], i),
                ],
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      );
    }
    return Container(color: AppTheme.topSection, height: 30.36, child: inner);
  }

  Widget _tab(KiteTab t, int i) {
    final sel = selected == i;
    return GestureDetector(
      onTap: () => onSelect(i),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: tabPadding),
        child: IntrinsicWidth(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.label,
                        style: GoogleFonts.inter(
                          fontSize: 9.9,
                          fontWeight: sel ? FontWeight.w500 : FontWeight.w400,
                          color: sel ? AppTheme.blue : AppTheme.textPrimary,
                        ),
                      ),
                      if (t.lock) ...[
                        const SizedBox(width: 3.3),
                        const Icon(Icons.lock_outline, size: 9.24, color: AppTheme.textPrimary),
                      ],
                      if (t.badge != null) ...[
                        const SizedBox(width: 4.62),
                        _badge(t.badge!, sel),
                      ],
                    ],
                  ),
                ),
              ),
              Container(
                height: 1.65,
                width: double.infinity,
                color: sel ? AppTheme.blue : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(int n, bool sel) {
    return Container(
      width: 14.52,
      height: 14.52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: sel ? AppTheme.badgeActive : AppTheme.badgeInactive,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$n',
        style: GoogleFonts.inter(
          fontSize: 7.59,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
