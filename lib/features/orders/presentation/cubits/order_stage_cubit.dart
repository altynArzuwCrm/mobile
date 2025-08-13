import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStageSelectionCubit extends Cubit<Map<int, String?>> {
  OrderStageSelectionCubit() : super({});

  void setStage(int orderId, String? stageName) {
    emit({...state, orderId: stageName});
  }

  String? getStage(int orderId) {
    return state[orderId];
  }
}
