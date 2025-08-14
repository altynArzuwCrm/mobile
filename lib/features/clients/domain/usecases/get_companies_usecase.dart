import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class GetCompaniesUseCase extends BaseUseCase<NoParams, List<String>> {
  final ClientRepository repository;

  GetCompaniesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<String>>> execute(input) async {
    return await repository.getCompanies();
  }
}
