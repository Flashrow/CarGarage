import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/car_dto.dart';
import '../models/person_dto.dart';
import 'endpoints.dart';

part 'api_provider.g.dart';

@lazySingleton
@RestApi()
abstract class ApiProvider {
  @factoryMethod
  factory ApiProvider(Dio dio) = _ApiProvider;

  @GET(Endpoints.carList)
  Future<List<CarDto>> getCarList();

  @GET(Endpoints.personList)
  Future<List<PersonDto>> getPersonList();

  @POST(Endpoints.carList)
  Future<String> addNewCar({
    @Body() CarDto? newCar,
  });
}
