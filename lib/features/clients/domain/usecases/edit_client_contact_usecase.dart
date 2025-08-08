import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

import 'create_client_contact_usecase.dart';

class EditClientContactUseCase extends BaseUseCase<ClientContactParams, bool> {
  final ClientRepository repository;

  EditClientContactUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(input) async {
    return await repository.editClientContact(input);
  }
}
