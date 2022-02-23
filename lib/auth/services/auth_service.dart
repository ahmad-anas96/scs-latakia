import 'package:scs_latakia_app/auth/models/login_request_model.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';
import 'package:scs_latakia_app/const.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<LoginResponseModel?> login(LoginRequestModel model) async {
    try {
      var response = await http.post(Uri.parse("$ROOT_API/user/login"),
          body: model.toJson());
      if (response.statusCode == 200) {
        return LoginResponseModel.fromRawJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<LoginResponseModel?> register(LoginRequestModel model) async {
    try {
      var response =
          await http.post(Uri.parse("$ROOT_API/user"), body: model.toJson());
      if (response.statusCode == 201) {
        return LoginResponseModel.fromRawJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
