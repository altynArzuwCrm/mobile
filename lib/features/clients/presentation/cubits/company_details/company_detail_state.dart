part of 'company_detail_cubit.dart';

@immutable
sealed class CompanyDetailState {}

final class CompanyDetailLoading extends CompanyDetailState {}
final class CompanyDetailLoaded extends CompanyDetailState {
  final ClientEntity data;

  CompanyDetailLoaded(this.data);

}
final class CompanyDetailConnectionError extends CompanyDetailState {}
final class CompanyDetailError extends CompanyDetailState {}
