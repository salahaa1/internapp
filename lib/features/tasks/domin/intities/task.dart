class Task {
  final int id;
  final String taskName;
  final String description;
  final String priority;
  final String startDate;
  final String dueDate;
  final int statusId;

  const Task({
    required this.id,
    required this.taskName,
    required this.description,
    required this.priority,
    required this.startDate,
    required this.dueDate,
    required this.statusId,
  });
}
