part of 'stage_cubit.dart';

sealed class StageState {}

final class StageLoading extends StageState {}
final class StageLoaded extends StageState {
  final List<StageModel> data;
  final String? selectedCategory;

  StageLoaded(this.data, {this.selectedCategory});

  StageLoaded copyWith({
    List<StageModel>? data,
    String? selectedCategory,
  }) {
    return StageLoaded(
      data ?? this.data,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
final class StageError extends StageState {}
