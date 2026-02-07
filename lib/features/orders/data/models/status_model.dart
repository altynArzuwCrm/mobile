class StatusModel {
  final String name;
  final String? status;

  const StatusModel({required this.name, required this.status});

  static const List<StatusModel> statuses = [
    StatusModel(name: 'Все', status: null),
    // StatusModel(name: 'Ожидает', status: 'pending'),
    StatusModel(name: 'В работе', status: 'in_progress'),
    // StatusModel(name: 'На рассмотрении', status: 'under_review'),
    StatusModel(name: 'Одобрено', status: 'approved'),
    StatusModel(name: 'Актуальные', status: 'current'),
    // StatusModel(name: 'Отменено', status: 'cancelled'),
  ];
}
