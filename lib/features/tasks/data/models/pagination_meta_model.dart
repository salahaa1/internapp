import 'package:tasks_project/features/tasks/domin/intities/pagination_meta.dart';

class PaginationMetaModel extends PaginationMeta {
  const PaginationMetaModel({
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.total,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 10,
      total: json['total'] ?? 0,
    );
  }
}
