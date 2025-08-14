part of 'company_cubit.dart';

sealed class CompanyState {}

final class CompanyLoading extends CompanyState {}

final class CompanyLoaded extends CompanyState {
  final List<String> data;

  CompanyLoaded(this.data);
}

final class CompanyError extends CompanyState {}

final class CompanyConnectionError extends CompanyState {}
