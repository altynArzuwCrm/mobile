import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/repositories/project_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProjectUseCase
    extends BaseUseCase<CreateProjectParams, ProjectEntity> {
  final ProjectRepository repository;

  CreateProjectUseCase({required this.repository});

  @override
  Future<Either<Failure, ProjectEntity>> execute(
    CreateProjectParams input,
  ) async {
    return await repository.createProject(input);
  }
}

class CreateProjectParams {
  final String title;
  final String? price;
  final String? payment;
  final DateTime? deadline;
  final int? id;


  CreateProjectParams({
    required   this.price,
    required this.title,
    required  this.payment,
    required   this.deadline,
    this.id,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['title'] = title;
    if (price != null)  params['total_price'] = price;
    if (payment != null)  params['payment_amount'] = payment;
    if (deadline != null) params['deadline'] = deadline!.toIso8601String();

    return params;
  }

  @override
  String toString() {
    return 'CreateProjectParams{title: $title, price: $price, payment: $payment, deadline: $deadline, id: $id}';
  }
}
