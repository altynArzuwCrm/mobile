import 'package:crm/core/error/failure.dart';
import 'package:crm/features/orders/data/models/comment_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.repository) : super(CommentLoading());

  final OrderRepository repository;

  Future<void> getOrderComments(int orderId) async {
    emit(CommentLoading());

    final result = await repository.getOrderComments(orderId);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(CommentConnectionError());
        } else {
          emit(CommentError());
        }
      },
      (data) {
        emit(CommentLoaded(data));
      },
    );
  }

  Future<void> createOrderComments(CommentParams params) async {

    final result = await repository.createOrderComment(params);

    result.fold(
      (error) {
        // if (error is ConnectionFailure) {
        //   emit(CommentConnectionError());
        // } else {
        //   emit(CommentError());
        // }
      },
      (data) {
        if (data.isNotEmpty) {
          emit(CommentLoaded(data));
        }
      },
    );
  }
  Future<void> deleteOrderComment(int id, int orderId) async {

    final result = await repository.deleteOrderComment(id, orderId);

    result.fold(
      (error) {
        // if (error is ConnectionFailure) {
        //   emit(CommentConnectionError());
        // } else {
        //   emit(CommentError());
        // }
      },
      (data) {
        if (data.isNotEmpty) {
          emit(CommentLoaded(data));
        }
      },
    );
  }
}
