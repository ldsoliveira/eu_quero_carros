import 'package:eu_quero_carros/core/errors/exceptions.dart';
import 'package:eu_quero_carros/core/network/network_info.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/datasources/remote_datasource.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/models/car_model.dart';

/// Contrato Repository
abstract class EuQueroCarrosRepository {
  Future<List<CarModel>> getCarsList();
  Future<void> sendReservas();
}

class EuQueroCarrosRepositoryImpl implements EuQueroCarrosRepository {
  EuQueroCarrosRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo
  });

  final CarsRemoteDataSourceImpl remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<List<CarModel>> getCarsList() async {
    if(await networkInfo.isConnected) {
      try {
        return remoteDataSource.getCarsList();
      } on ServerException {
        throw ServerFailure();
      }
    } else {
      throw NetworkConnectivityFailure();
    }
  }

  @override
  Future<void> sendReservas() async {
    if(await networkInfo.isConnected) {
      try {
        return remoteDataSource.sendReservas();
      } on ServerException {
        throw ServerFailure();
      }
    } else {
      throw NetworkConnectivityFailure();
    }
  }
}