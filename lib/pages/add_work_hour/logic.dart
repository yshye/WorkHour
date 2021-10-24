import 'package:get/get.dart';
import 'package:work_hour/bmob/table/work_info.dart';

class AddWorkHourLogic extends GetxController {
  late WorkInfo _info;

  set info(WorkInfo _info) => this._info = _info;

  WorkInfo get info => _info;
}
