class ZonePosition {
  final String zoneId;
  final int index;
  final int? row;
  final int? column;
  final double? scrollOffset;

  const ZonePosition({
    required this.zoneId,
    this.index = 0,
    this.row,
    this.column,
    this.scrollOffset,
  });

  ZonePosition copyWith({
    String? zoneId,
    int? index,
    int? row,
    int? column,
    double? scrollOffset,
  }) {
    return ZonePosition(
      zoneId: zoneId ?? this.zoneId,
      index: index ?? this.index,
      row: row ?? this.row,
      column: column ?? this.column,
      scrollOffset: scrollOffset ?? this.scrollOffset,
    );
  }
}
