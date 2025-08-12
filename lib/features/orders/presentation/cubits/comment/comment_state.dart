part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentLoading extends CommentState {}
final class CommentLoaded extends CommentState {
  final List<CommentModel> data;

  CommentLoaded(this.data);
}
final class CommentConnectionError extends CommentState {}
final class CommentError extends CommentState {}
