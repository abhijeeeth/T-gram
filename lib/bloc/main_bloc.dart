import 'package:bloc/bloc.dart';

// Define the Bloc
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<MainEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
// Define the events

class MainEvent {}

// Define the states

class MainState {}

class GetOfficerDashboardEvent extends MainEvent {}

class GetOfficerDashboardLoadingState extends MainState {}

class GetOfficerDashboardErrorState extends MainState {
  final String error;

  GetOfficerDashboardErrorState(this.error);
}

class GetOfficerDashboardSuccessState extends MainState {
  final List<dynamic> data;

  GetOfficerDashboardSuccessState(this.data);
}
