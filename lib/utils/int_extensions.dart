extension IntDateExtensions on int {
  String toDateTime() {
    final time = DateTime.fromMillisecondsSinceEpoch(this);

    return '${time.day.toString().padLeft(2, '0')}-${time.month.toString().
    padLeft(2, '0')}-${time.year} '
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().
    padLeft(2, '0')}';
  }
}
