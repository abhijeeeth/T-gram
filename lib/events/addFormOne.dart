import 'package:tigramnks/events/formOneevent.dart';
import 'package:tigramnks/model/formOneModel.dart';

class addFormOne extends formOneEvent {
  late formOneFields newForm;

  AddFood(formOneFields form) {
    newForm = form;
  }
}
