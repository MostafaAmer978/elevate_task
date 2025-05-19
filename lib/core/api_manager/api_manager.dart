import 'package:dio/dio.dart';
import 'package:elevate_task/core/utils/constants.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio();
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? parameter,}) async {
    try {
      Response response = await dio.get(Constants.baseURL + endpoint, queryParameters: parameter,);
      return response;
    } catch (error) {
      throw Exception("Failed to GetData : ${error.toString()}");
    }
  }

}
