import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteClientContactUseCase
    extends BaseUseCase<int, bool> {
  final ClientRepository repository;

  DeleteClientContactUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.deleteClientContact(input);
  }
}