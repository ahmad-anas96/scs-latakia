import 'package:flutter/material.dart';
import 'package:scs_latakia_app/updates/models/update_model.dart';
import 'package:http/http.dart' as http;
import 'package:scs_latakia_app/utils/const.dart';

class UpdateViewModel extends ChangeNotifier {
  UpdateModel? _updateModel;

  UpdateViewModel() {
    Future.delayed(Duration.zero, () async {
      try {
        var response = await http.get(Uri.parse("$ROOT/update.json"));
        updateModel = UpdateModel.fromRawJson(response.body);
      } catch (e) {
        updateModel = null;
      }
    });
  }

  UpdateModel? get updateModel => _updateModel;

  set updateModel(UpdateModel? value) {
    _updateModel = value;
    notifyListeners();
  }
}
