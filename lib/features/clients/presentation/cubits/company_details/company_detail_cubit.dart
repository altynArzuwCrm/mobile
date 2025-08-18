import 'package:crm/core/error/failure.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/get_company_details_usecase.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'company_detail_state.dart';

class CompanyDetailCubit extends Cubit<CompanyDetailState> {
  CompanyDetailCubit() : super(CompanyDetailLoading());

  final GetCompanyDetailsUseCase _companyDetailsUseCase =
      GetCompanyDetailsUseCase(repository: locator());

  void getCompanyDetails(String title) async {
    emit(CompanyDetailLoading());
    final result = await _companyDetailsUseCase.execute(title);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(CompanyDetailConnectionError());
        } else {
          emit(CompanyDetailError());
        }
      },
      (data) {
        emit(CompanyDetailLoaded(data));
      },
    );
  }
}
