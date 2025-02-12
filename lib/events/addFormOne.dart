

import 'package:tigramnks/events/formOneevent.dart';
import 'package:tigramnks/model/formOneModel.dart';

class addFormOne extends formOneEvent {
  formOneFields newForm;

  AddFood(formOneFields form) {
    newForm = form;
  }
}