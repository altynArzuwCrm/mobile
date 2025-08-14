import 'package:crm/core/error/failure.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/clients/domain/usecases/get_companies_usecase.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyLoading());

  final GetCompaniesUseCase _getCompaniesUseCase = GetCompaniesUseCase(
    repository: locator(),
  );

  void getCompanies() async {
    final result = await _getCompaniesUseCase.execute(NoParams());

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(CompanyConnectionError());
        } else {
          emit(CompanyError());
        }
      },
      (data) {
        emit(CompanyLoaded(data));
      },
    );
  }
}
