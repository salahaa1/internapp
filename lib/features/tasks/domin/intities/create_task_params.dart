class CreateTaskParams {
  final String taskName;
  final String description;
  final String priority;
  final String startDate;
  final String dueDate;
  final int statusId;
  final List<int> assignedUserIds;
  final int ownerId;
  final String assignmentType;
  final bool executeTaskIndividually;
  final String recurrenceType;

  const CreateTaskParams({
    required this.taskName,
    required this.description,
    required this.priority,
    required this.startDate,
    required this.dueDate,
    required this.statusId,
    required this.assignedUserIds,
    required this.ownerId,
    required this.assignmentType,
    required this.executeTaskIndividually,
    required this.recurrenceType,
  });
}
