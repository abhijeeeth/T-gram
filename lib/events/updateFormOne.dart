import 'package:tigramnks/events/formOneevent.dart';
import 'package:tigramnks/model/formOneModel.dart';

class UpdateFormOne extends formOneEvent {
  final formOneFields newForm;
  final int formOneIndex;

  UpdateFormOne(this.formOneIndex, this.newForm);
}
