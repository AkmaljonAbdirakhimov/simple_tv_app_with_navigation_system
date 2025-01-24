import 'package:flutter/services.dart';

/// The type of zone for navigation
enum ZoneType {
  horizontal,
  grid,
}

/// Configuration for a navigation zone
class ZoneConfig {
  final String zoneId;
  final ZoneType type;
  final String? leftZoneId;
  final String? rightZoneId;
  final String? upZoneId;
  final String? downZoneId;
  final bool autoScroll;

  const ZoneConfig({
    required this.zoneId,
    required this.type,
    this.leftZoneId,
    this.rightZoneId,
    this.upZoneId,
    this.downZoneId,
    this.autoScroll = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZoneConfig &&
          runtimeType == other.runtimeType &&
          zoneId == other.zoneId &&
          type == other.type &&
          leftZoneId == other.leftZoneId &&
          rightZoneId == other.rightZoneId &&
          upZoneId == other.upZoneId &&
          downZoneId == other.downZoneId &&
          autoScroll == other.autoScroll;

  @override
  int get hashCode =>
      zoneId.hashCode ^
      type.hashCode ^
      leftZoneId.hashCode ^
      rightZoneId.hashCode ^
      upZoneId.hashCode ^
      downZoneId.hashCode ^
      autoScroll.hashCode;
}
