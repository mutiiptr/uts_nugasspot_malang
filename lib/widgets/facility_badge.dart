import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FacilityBadge extends StatelessWidget {
  final String label;
  final bool isCompact;

  const FacilityBadge({
    super.key,
    required this.label,
    this.isCompact = false,
  });

  IconData _getIconForFacility(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('wi-fi') || lower.contains('wifi') || lower.contains('fiber')) {
      return Icons.wifi_rounded;
    } else if (lower.contains('colokan') || lower.contains('stopkontak')) {
      return Icons.power_rounded;
    } else if (lower.contains('24 jam')) {
      return Icons.all_inclusive_rounded;
    } else if (lower.contains('ac')) {
      return Icons.ac_unit_rounded;
    } else if (lower.contains('musholla')) {
      return Icons.mosque_rounded;
    } else if (lower.contains('parkir')) {
      return Icons.local_parking_rounded;
    } else if (lower.contains('kursi') || lower.contains('ergonomis') || lower.contains('meja')) {
      return Icons.chair_alt_rounded;
    } else if (lower.contains('outdoor') || lower.contains('kebun') || lower.contains('taman')) {
      return Icons.forest_rounded;
    } else if (lower.contains('rooftop')) {
      return Icons.roofing_rounded;
    } else if (lower.contains('photobooth')) {
      return Icons.camera_alt_rounded;
    } else if (lower.contains('refill')) {
      return Icons.replay_rounded;
    }
    return Icons.check_circle_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final icon = _getIconForFacility(label);

    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: AppTheme.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppTheme.primary),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
