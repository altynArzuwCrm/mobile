import 'package:crm/core/local/token_store.dart';
import 'package:crm/core/usecase/usecase.dart';
import 'package:crm/features/auth/domain/usecases/login_usecase.dart';
import 'package:crm/features/auth/domain/usecases/logout_usecase.dart';
import 'package:crm/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._loginUseCase, this._logoutUseCase) : super(AuthInitial()) {
    on<LogInEvent>(_onLogIn);
    on<CheckAuthEvent>(_onCheck);
    on<LogOutEvent>(_logOut);
    on<InitialEvent>(_onInitial);
  }

  void _onLogIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginUseCase.execute(event.params);
    result.fold(
      (failure) => {emit(AuthFailure(failure.message))},
      (data) => {emit(Authenticated())},
    );
  }

  Future<void> _onCheck(CheckAuthEvent event, Emitter<AuthState> emit) async {
    final isTokenStored = await locator<Store>().isTokenAvailable();

    if (isTokenStored) {
      emit(Authenticated());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onInitial(InitialEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
  }

  Future<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _logoutUseCase.execute(NoParams());
    result.fold(
      (failure) => {emit(AuthFailure(failure.message))},
      (data) => {
        if (data) {emit(AuthInitial())},
      },
    );
  }
}
