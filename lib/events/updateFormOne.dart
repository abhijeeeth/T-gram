


import 'package:tigramnks/events/formOneevent.dart';
import 'package:tigramnks/model/formOneModel.dart';

class UpdateFormOne extends formOneEvent {
  formOneFields newForm;
  int formOneIndex;

  UpdateFood(int index, formOneFields form) {
    newForm = form;
    formOneIndex = index;
  }
}