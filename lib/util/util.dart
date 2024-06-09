bool isHabbitCompletedTOday(List<DateTime> completeddays) {
  final today = DateTime.now();
  return completeddays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}
