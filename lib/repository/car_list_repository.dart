import 'package:car_garage/network/api/api_provider.dart';
import 'package:car_garage/network/api/dio_client.dart';

import '../network/models/car_dto.dart';

class CarListRepository {
  ApiProvider _apiProvider = ApiProvider(DioClient().dio);

  Future<List<CarDto>> fetchCarList() => _apiProvider.getCarList();
}
