class OpeningTimesBreak {
  const OpeningTimesBreak(this.start, this.end);
  final int start;
  final int end;
}

class OpeningTimes {
  const OpeningTimes(this.opening, this.closing, this.breaks);

  final num opening;
  final num closing;
  final OpeningTimesBreak breaks;
}
