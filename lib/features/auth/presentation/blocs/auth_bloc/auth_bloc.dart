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

  Future<void> _onLogIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginUseCase.execute(event.params);

    await result.fold(
          (failure) async {
        emit(AuthFailure(failure.message));
      },
          (data) async {
        final store = locator<Store>();
        await store.setRemember(event.remember);

        emit(Authenticated());
      },
    );
  }


  Future<void> _onCheck(CheckAuthEvent event, Emitter<AuthState> emit) async {
    final store = locator<Store>();
    final isTokenStored = await store.isTokenAvailable();
    final remember = await store.getRemember();

    if (isTokenStored && remember) {
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
