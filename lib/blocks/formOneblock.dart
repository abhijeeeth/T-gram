import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/events/addFormOne.dart';
import 'package:tigramnks/events/deleteFormOne.dart';
import 'package:tigramnks/events/setFormOne.dart';
import 'package:tigramnks/events/updateFormOne.dart';
import '../model/formOneModel.dart';
import '../events/formOneevent.dart';

class formOneBlock extends Bloc<formOneEvent, List<formOneFields>> {
  formOneBlock() : super(<formOneFields>[]);

  @override
  Stream<List<formOneFields>> mapEventToState(formOneEvent event) async* {
    if (event is setFormOne) {
      yield event.formOneList;
    } else if (event is addFormOne) {
      List<formOneFields> newState = List.from(state);
      if (event.newForm != null) {
        newState.add(event.newForm);
      }
      yield newState;
    } else if (event is deleteForm1) {
      List<formOneFields> newState = List.from(state);
      newState.removeAt(event.formOneIndex);
      yield newState;
    } else if (event is UpdateFormOne) {
      List<formOneFields> newState = List.from(state);
      newState[event.formOneIndex] = event.newForm;
      yield newState;
    }
  }
}
