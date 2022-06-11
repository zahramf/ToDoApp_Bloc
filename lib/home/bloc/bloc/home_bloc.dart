import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:to_do_app_bloc/home/services/authentication.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  HomeBloc(this._auth) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      // TODO: implement event handler
    });
  }
}
