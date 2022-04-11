import 'package:car_garage/network/api/api_provider.dart';
import 'package:car_garage/network/api/dio_client.dart';
import 'package:car_garage/network/models/person_dto.dart';

class PersonListRepository {
  final ApiProvider _apiProvider = ApiProvider(DioClient().dio);

  Future<List<PersonDto>> fetchPersonsList() => _apiProvider.getPersonList();
}
