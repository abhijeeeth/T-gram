import 'package:tigramnks/events/formOneevent.dart';
import 'package:tigramnks/model/formOneModel.dart';

class setFormOne extends formOneEvent {
  List<formOneFields> formOneList;

  setFormOne(List<formOneFields> formOne) : formOneList = formOne;
}
